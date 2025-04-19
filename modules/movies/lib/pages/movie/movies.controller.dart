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

  Future<void> fetchInitialData() async {
    _notifyMoviesLoading();
    try {
      final response = await moviesRepository.fetchMovies();
      movies = response.results;
      _notifyMoviesSuccess();
    } catch (ex, stacktrace) {
      CMALogger.e('Error while fetching initial movies data', ex: ex, stacktrace: stacktrace);
      _notifyMoviesError();
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
