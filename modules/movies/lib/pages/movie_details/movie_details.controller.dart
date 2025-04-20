import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:movies/domain/repositories/movies_repository.dart';
import 'models/movie_detail.model.dart';

enum MovieDetailsControllerStatus {
  loading,
  success,
  error;

  bool get isLoading => this == MovieDetailsControllerStatus.loading;
  bool get isSuccess => this == MovieDetailsControllerStatus.success;
  bool get isError => this == MovieDetailsControllerStatus.error;
}

class MovieDetailsController with ChangeNotifier {
  MovieDetailsController({required this.moviesRepository});

  final IMoviesRepository moviesRepository;
  MovieDetailsControllerStatus status = MovieDetailsControllerStatus.loading;
  MovieDetailModel movieDetail = MovieDetailModel.empty();

  Future<void> fetchMovieDetails(int movieId) async {
    _notifyMovieDetailsLoading();
    try {
      final response = await moviesRepository.fetchMovieDetails(movieId: movieId);
      movieDetail = response;
      _notifyMovieDetailsSuccess();
    } catch (ex, stacktrace) {
      CMALogger.e('Error while fetching movie details', ex: ex, stacktrace: stacktrace);
      _notifyMovieDetailsError();
    }
  }

  void _notifyMovieDetailsLoading() {
    status = MovieDetailsControllerStatus.loading;
    notifyListeners();
  }

  void _notifyMovieDetailsSuccess() {
    status = MovieDetailsControllerStatus.success;
    notifyListeners();
  }

  void _notifyMovieDetailsError() {
    status = MovieDetailsControllerStatus.error;
    notifyListeners();
  }
}
