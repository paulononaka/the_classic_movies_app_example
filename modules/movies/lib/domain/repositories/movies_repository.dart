import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

abstract class IMoviesRepository {
  Future<MoviesModel> fetchMovies({int page = 1});
  Future<MovieDetailModel> fetchMovieDetails({required int movieId});
}
