import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

abstract class IMoviesLocalDataSource {
  Future<MoviesModel?> getMovies(int page);
  Future<void> cacheMovies(MoviesModel movies, int page);
  Future<MovieDetailModel?> getMovieDetails(int movieId);
  Future<void> cacheMovieDetails(MovieDetailModel movieDetail);
  Future<void> clearCache();
}
