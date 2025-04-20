import 'package:hive/hive.dart';
import 'package:movies/domain/data_sources/movies_local_data_source.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

class MoviesLocalDataSourceImpl implements IMoviesLocalDataSource {
  static const String moviesBoxName = 'movies_box';
  static const String movieDetailsBoxName = 'movie_details_box';

  MoviesLocalDataSourceImpl(this._moviesBox, this._detailsBox);

  final Box<MoviesModel> _moviesBox;
  final Box<MovieDetailModel> _detailsBox;

  @override
  Future<MoviesModel?> getMovies(int page) async {
    return _moviesBox.get('page_$page');
  }

  @override
  Future<void> cacheMovies(MoviesModel movies, int page) async {
    await _moviesBox.put('page_$page', movies);
  }

  @override
  Future<MovieDetailModel?> getMovieDetails(int movieId) async {
    return _detailsBox.get('movie_$movieId');
  }

  @override
  Future<void> cacheMovieDetails(MovieDetailModel movieDetail) async {
    await _detailsBox.put('movie_${movieDetail.id}', movieDetail);
  }

  @override
  Future<void> clearCache() async {
    await _moviesBox.clear();
    await _detailsBox.clear();
  }
}
