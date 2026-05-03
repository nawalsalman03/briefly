import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiDataSource {
  late final GenerativeModel _model;

  GeminiDataSource() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null) {
      throw Exception(
        'GEMINI_API_KEY not found in .env file. '
        'Make sure .env file exists in project root with GEMINI_API_KEY=your_key',
      );
    }
    _model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);
  }

  /// Fetch curated tech news summary from Gemini AI
  /// Uses Google Search tool to find latest tech news
  /// Returns summary in Pakistani Korangi slang Roman Urdu
  Future<String> fetchGeminiSummary() async {
    try {
      final userMessage =
          '''You are an expert news reporter who curates content and provides a brief to the point response in Pakistani Korangi slang Roman Urdu. You do not give long paragraphs but just some bullet points with the summary.

Latest tech news summary in last 24 hours.''';

      final response = await _model.generateContent([
        Content.text(userMessage),
      ]);

      if (response.text == null || response.text!.isEmpty) {
        throw Exception('No response received from Gemini API');
      }

      return response.text!;
    } catch (e) {
      throw Exception('Error fetching Gemini summary: $e');
    }
  }
}
