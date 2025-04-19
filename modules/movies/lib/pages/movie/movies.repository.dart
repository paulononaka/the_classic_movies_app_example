import 'package:dio/dio.dart';
import 'package:core/env.dart';

import 'models/movies.model.dart';

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
}
