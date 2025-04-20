import 'package:core/env.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:movies/domain/data_sources/movies_remote_data_source.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

class MoviesRemoteDataSourceImpl implements IMoviesRemoteDataSource {
  MoviesRemoteDataSourceImpl({required Dio dio, required Env env})
      : _dio = dio,
        _env = env;

  final Dio _dio;
  final Env _env;

  @override
  Future<MoviesModel> fetchMovies(BuildContext context, {int page = 1}) async {
    try {
      final response = await _dio.get(
        '${_env.tmdbBaseUrl}/discover/movie',
        queryParameters: {
          'api_key': _env.tmdbApiKey,
          'page': page,
          'sort_by': 'popularity.desc',
        },
      );

      return MoviesModel.fromJson(response.data);
    } on DioException catch (e) {
      if (!context.mounted) rethrow;
      throw NetworkException.fromDioException(e, context);
    }
  }

  @override
  Future<MovieDetailModel> fetchMovieDetails(BuildContext context, {required int movieId}) async {
    try {
      final response = await _dio.get(
        '${_env.tmdbBaseUrl}/movie/$movieId',
        queryParameters: {
          'api_key': _env.tmdbApiKey,
        },
      );

      return MovieDetailModel.fromJson(response.data);
    } on DioException catch (e) {
      if (!context.mounted) rethrow;
      throw NetworkException.fromDioException(e, context);
    }
  }
}
