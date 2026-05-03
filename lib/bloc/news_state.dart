import '../data/models/news_item.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsItem> news;

  NewsLoaded(this.news);
}

// NEW STATES FOR GEMINI
class GeminiLoading extends NewsState {}

class GeminiLoaded extends NewsState {
  final String summary;

  GeminiLoaded(this.summary);
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
}
