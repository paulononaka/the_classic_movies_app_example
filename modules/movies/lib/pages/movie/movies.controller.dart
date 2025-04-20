import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:movies/domain/repositories/movies_repository.dart';
import 'package:movies/pages/movie/movies.state.dart';

class MoviesController with ChangeNotifier {
  MoviesController({required this.moviesRepository});

  final IMoviesRepository moviesRepository;

  MoviesState _state = const MoviesLoadingState();
  bool _isLoadingMore = false;

  MoviesState get state => _state;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> fetchData(BuildContext context) async {
    _setState(const MoviesLoadingState());

    try {
      const currentPage = 1;
      final response = await moviesRepository.fetchMovies(context, page: currentPage);
      final movies = response.results;
      final hasReachedMax = currentPage >= response.totalPages;

      if (movies.isEmpty) {
        _setState(const MoviesEmptyState());
      } else {
        _setState(MoviesSuccessState(movies: movies, currentPage: currentPage, hasReachedMax: hasReachedMax));
      }
    } on NetworkException catch (e) {
      CMALogger.d('Network error while fetching initial movies data');
      _setState(MoviesNetworkErrorState(message: e.message));
    } catch (ex, stacktrace) {
      CMALogger.e('Error while fetching initial movies data', ex: ex, stacktrace: stacktrace);
      _setState(const MoviesErrorState());
    }
  }

  Future<void> fetchNextPage(BuildContext context) async {
    if (_isLoadingMore || !_canLoadMore()) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      final currentState = _state;
      if (currentState is! MoviesSuccessState) return;

      final nextPage = currentState.currentPage + 1;
      final response = await moviesRepository.fetchMovies(context, page: nextPage);

      _setState(MoviesSuccessState(
        movies: [...currentState.movies, ...response.results],
        currentPage: nextPage,
        hasReachedMax: nextPage >= response.totalPages,
      ));
    } on NetworkException catch (e) {
      CMALogger.d('Network error while fetching next page of movies');
      _setState(MoviesNetworkErrorState(message: e.message));
    } catch (ex, stacktrace) {
      CMALogger.e('Error while fetching next page of movies', ex: ex, stacktrace: stacktrace);
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  bool _canLoadMore() {
    final currentState = _state;
    if (currentState is MoviesSuccessState) {
      return !currentState.hasReachedMax;
    }
    return false;
  }

  void _setState(MoviesState state) {
    _state = state;
    notifyListeners();
  }
}
