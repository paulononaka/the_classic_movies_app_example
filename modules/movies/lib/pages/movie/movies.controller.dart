import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'models/movie.model.dart';
import 'movies.repository.dart';

enum MoviesControllerStatus {
  loading,
  success,
  error;

  bool get isLoading => this == MoviesControllerStatus.loading;
  bool get isSuccess => this == MoviesControllerStatus.success;
  bool get isError => this == MoviesControllerStatus.error;
}

class MoviesController with ChangeNotifier {
  MoviesController({required this.moviesRepository});

  final MoviesRepository moviesRepository;
  MoviesControllerStatus status = MoviesControllerStatus.loading;
  List<MovieModel> movies = [];
  int _currentPage = 0;
  bool _isLoadingMore = false;
  bool _hasReachedMax = false;

  bool get isLoadingMore => _isLoadingMore;
  bool get hasReachedMax => _hasReachedMax;

  Future<void> fetchInitialData() async {
    _notifyMoviesLoading();
    try {
      _currentPage = 1;
      final response = await moviesRepository.fetchMovies(page: _currentPage);
      movies = response.results;
      _hasReachedMax = _currentPage >= response.totalPages;
      _notifyMoviesSuccess();
    } catch (ex, stacktrace) {
      CMALogger.e('Error while fetching initial movies data', ex: ex, stacktrace: stacktrace);
      _notifyMoviesError();
    }
  }

  Future<void> fetchNextPage() async {
    if (_isLoadingMore || _hasReachedMax) return;
    
    _isLoadingMore = true;
    notifyListeners();
    
    try {
      final nextPage = _currentPage + 1;
      final response = await moviesRepository.fetchMovies(page: nextPage);
      
      _currentPage = nextPage;
      movies = [...movies, ...response.results];
      _hasReachedMax = _currentPage >= response.totalPages;
      
      _isLoadingMore = false;
      notifyListeners();
    } catch (ex, stacktrace) {
      CMALogger.e('Error while fetching next page of movies', ex: ex, stacktrace: stacktrace);
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  void _notifyMoviesLoading() {
    status = MoviesControllerStatus.loading;
    notifyListeners();
  }

  void _notifyMoviesSuccess() {
    status = MoviesControllerStatus.success;
    notifyListeners();
  }

  void _notifyMoviesError() {
    status = MoviesControllerStatus.error;
    notifyListeners();
  }
}
