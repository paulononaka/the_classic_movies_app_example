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
  final IMoviesRepository moviesRepository;

  MovieDetailsController({required this.moviesRepository});

  MovieDetailsControllerStatus status = MovieDetailsControllerStatus.loading;
  MovieDetailModel movieDetail = MovieDetailModel.empty();
  String errorMessage = '';

  Future<void> fetchMovieDetails(BuildContext context, {required int movieId}) async {
    _notifyMovieDetailsLoading();
    try {
      final response = await moviesRepository.fetchMovieDetails(context, movieId: movieId);
      movieDetail = response;
      _notifyMovieDetailsSuccess();
    } on NetworkException catch (e, stacktrace) {
      CMALogger.e('Network error while fetching movie details', ex: e, stacktrace: stacktrace);
      _notifyMovieDetailsError(e.message);
    } catch (ex, stacktrace) {
      CMALogger.e('Error while fetching movie details', ex: ex, stacktrace: stacktrace);
      _notifyMovieDetailsError('An error occurred while fetching movie details');
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

  void _notifyMovieDetailsError([String message = '']) {
    status = MovieDetailsControllerStatus.error;
    errorMessage = message;
    notifyListeners();
  }
}
