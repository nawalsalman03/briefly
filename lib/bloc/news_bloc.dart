// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../data/repositories/news_repository.dart';
// import 'news_event.dart';
// import 'news_state.dart';

// class NewsBloc extends Bloc<NewsEvent, NewsState> {
//   final NewsRepository repository;

//   NewsBloc({required this.repository}) : super(NewsInitial()) {
//     on<LoadNews>(_onLoadNews);
//   }

//   Future<void> _onLoadNews(
//     LoadNews event,
//     Emitter<NewsState> emit,
//   ) async {
//     emit(NewsLoading());
//     try {
//       final news = await repository.getTechNews();
//       emit(NewsLoaded(news));
//     } catch (e) {
//       emit(NewsError(e.toString()));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/news_repository.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc({required this.repository}) : super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
    on<LoadGeminiSummary>(_onLoadGeminiSummary);
  }

  /// Handle REST API news loading (existing functionality)
  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final news = await repository.getTechNews();
      emit(NewsLoaded(news));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  /// Handle Gemini AI news summary loading (new functionality)
  Future<void> _onLoadGeminiSummary(
    LoadGeminiSummary event,
    Emitter<NewsState> emit,
  ) async {
    emit(GeminiLoading());
    try {
      final summary = await repository.getGeminiSummary();
      emit(GeminiLoaded(summary));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
