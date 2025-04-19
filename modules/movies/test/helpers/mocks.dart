import 'package:core/env.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/pages/movie/movies.repository.dart';
import 'package:movies/routes/movies_navigator.dart';

class EnvMock extends Mock implements Env {
  @override
  String get tmdbApiKey => 'tmdb_api_key';

  @override
  String get tmdbBaseUrl => 'https://api.themoviedb.org/3';
}

class DioMock extends Mock implements Dio {}

class MoviesNavigatorMock extends Mock implements MoviesNavigator {}

class MoviesRepositoryMock extends Mock implements MoviesRepository {}
