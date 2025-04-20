import 'package:movies/pages/movie/models/movie.model.dart';

sealed class MoviesState {
  const MoviesState();
}

class MoviesLoadingState extends MoviesState {
  const MoviesLoadingState();
}

class MoviesSuccessState extends MoviesState {
  const MoviesSuccessState({
    required this.movies,
    required this.currentPage,
    required this.hasReachedMax,
  });

  final List<MovieModel> movies;
  final int currentPage;
  final bool hasReachedMax;
}

class MoviesEmptyState extends MoviesState {
  const MoviesEmptyState();
}

class MoviesErrorState extends MoviesState {
  const MoviesErrorState({this.message});

  final String? message;
}

class MoviesNetworkErrorState extends MoviesState {
  const MoviesNetworkErrorState({required this.message});

  final String message;
}
