import 'package:dio/dio.dart';
import 'package:core/env.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

import '../pages/movie/models/movies.model.dart';

class MoviesRepository {
  MoviesRepository({required Dio dio, required Env env})
      : _dio = dio,
        _env = env;

  final Dio _dio;
  final Env _env;

  Future<MoviesModel> fetchMovies({int page = 1}) async {
    final response = await _dio.get(
      '${_env.tmdbBaseUrl}/discover/movie',
      queryParameters: {
        'api_key': _env.tmdbApiKey,
        'page': page,
        'sort_by': 'popularity.desc',
      },
    );

    return MoviesModel.fromJson(response.data);
  }

  Future<MovieDetailModel> fetchMovieDetails({required int movieId}) async {
    final response = await _dio.get(
      '${_env.tmdbBaseUrl}/movie/$movieId',
      queryParameters: {
        'api_key': _env.tmdbApiKey,
      },
    );

    return MovieDetailModel.fromJson(response.data);
  }
}
