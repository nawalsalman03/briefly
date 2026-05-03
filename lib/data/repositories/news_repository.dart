// import '../datasources/news_remote_data_source.dart';
// import '../datasources/gemini_data_source.dart';
// import '../models/news_item.dart';

// class NewsRepository {
//   final NewsRemoteDataSource remoteDataSource;
//   final GeminiDataSource geminiDataSource;

//   NewsRepository({
//     required this.remoteDataSource,
//     required this.geminiDataSource,
//   });

//   /// Fetch news from REST API (existing functionality)
//   Future<List<NewsItem>> getTechNews() {
//     return remoteDataSource.fetchNews();
//   }

//   /// Fetch curated news summary from Gemini AI (new functionality)
//   Future<String> getGeminiSummary() {
//     return geminiDataSource.fetchGeminiSummary();
//   }
// }
import '../datasources/news_remote_data_source.dart';
import '../datasources/gemini_data_source.dart'; // ← ADD THIS IMPORT
import '../models/news_item.dart';

class NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final GeminiDataSource geminiDataSource; // ← ADD THIS FIELD

  NewsRepository({
    required this.remoteDataSource,
    required this.geminiDataSource, // ← ADD THIS TO CONSTRUCTOR
  });

  Future<List<NewsItem>> getTechNews() {
    return remoteDataSource.fetchNews();
  }

  // ← ADD THIS WHOLE METHOD
  Future<String> getGeminiSummary() {
    return geminiDataSource.fetchGeminiSummary();
  }
}
