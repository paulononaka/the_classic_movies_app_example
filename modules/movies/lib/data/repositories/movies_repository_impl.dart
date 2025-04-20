import 'package:flutter/widgets.dart';
import 'package:movies/domain/data_sources/movies_local_data_source.dart';
import 'package:movies/domain/data_sources/movies_remote_data_source.dart';
import 'package:movies/domain/repositories/movies_repository.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

class MoviesRepositoryImpl implements IMoviesRepository {
  MoviesRepositoryImpl({required IMoviesRemoteDataSource remoteDataSource, required IMoviesLocalDataSource localDataSource})
      : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final IMoviesRemoteDataSource _remoteDataSource;
  final IMoviesLocalDataSource _localDataSource;

  @override
  Future<MoviesModel> fetchMovies(BuildContext context, {int page = 1}) async {
    final cachedMovies = await _localDataSource.getMovies(page);

    if (cachedMovies != null && cachedMovies.results.isNotEmpty) {
      return cachedMovies;
    }

    if (!context.mounted) return MoviesModel.empty();
    final moviesModel = await _remoteDataSource.fetchMovies(context, page: page);
    await _localDataSource.cacheMovies(moviesModel, page);
    return moviesModel;
  }

  @override
  Future<MovieDetailModel> fetchMovieDetails(BuildContext context, {required int movieId}) async {
    final cachedMovieDetail = await _localDataSource.getMovieDetails(movieId);

    if (cachedMovieDetail != null) {
      return cachedMovieDetail;
    }

    if (!context.mounted) return MovieDetailModel.empty();
    final movieDetailModel = await _remoteDataSource.fetchMovieDetails(context, movieId: movieId);
    await _localDataSource.cacheMovieDetails(movieDetailModel);
    return movieDetailModel;
  }
}
