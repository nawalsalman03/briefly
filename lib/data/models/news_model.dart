class NewsModel {
  final String id;
  final String title;
  final String summary;
  final String source;
  final DateTime createdAt;

  NewsModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.source,
    required this.createdAt,
  });

  factory NewsModel.fromGemini(String summary) {
    return NewsModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Tech News Summary',
      summary: summary,
      source: 'Gemini AI',
      createdAt: DateTime.now(),
    );
  }
}
