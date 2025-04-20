import 'package:flutter/widgets.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

abstract class IMoviesRepository {
  Future<MoviesModel> fetchMovies(BuildContext context, {int page = 1});
  Future<MovieDetailModel> fetchMovieDetails(BuildContext context, {required int movieId});
}
