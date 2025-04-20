import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:movies/domain/data_sources/movies_remote_data_source.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MoviesRemoteDataSourceImpl implements IMoviesRemoteDataSource {
  MoviesRemoteDataSourceImpl({required Dio dio, required Env env})
      : _dio = dio,
        _env = env;

  final Dio _dio;
  final Env _env;

  @override
  Future<MoviesModel> fetchMovies(BuildContext context, {int page = 1}) {
    return _performGetRequest<MoviesModel>(
      context: context,
      url: '${_env.tmdbBaseUrl}/discover/movie',
      queryParameters: {'api_key': _env.tmdbApiKey, 'page': page, 'sort_by': 'popularity.desc'},
      fromJson: (data) => MoviesModel.fromJson(data),
    );
  }

  @override
  Future<MovieDetailModel> fetchMovieDetails(BuildContext context, {required int movieId}) {
    return _performGetRequest<MovieDetailModel>(
      context: context,
      url: '${_env.tmdbBaseUrl}/movie/$movieId',
      queryParameters: {'api_key': _env.tmdbApiKey},
      fromJson: (data) => MovieDetailModel.fromJson(data),
    );
  }

  Future<T> _performGetRequest<T>({
    required BuildContext context,
    required String url,
    required Map<String, dynamic> queryParameters,
    required T Function(dynamic data) fromJson,
  }) async {
    final transaction = Sentry.startTransaction('dio-web-request', 'request', bindToScope: true);
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      transaction.status = SpanStatus.fromHttpStatusCode(response.statusCode ?? -1);
      return fromJson(response.data);
    } on DioException catch (e) {
      transaction.status = SpanStatus.fromHttpStatusCode(e.response?.statusCode ?? -1);
      transaction.throwable = e;
      if (!context.mounted) rethrow;
      throw NetworkException.fromDioException(e, context);
    } finally {
      transaction.finish();
    }
  }
}
