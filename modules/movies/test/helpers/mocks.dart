import 'package:core/env.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/data_sources/movies_local_data_source.dart';
import 'package:movies/domain/data_sources/movies_remote_data_source.dart';
import 'package:movies/domain/repositories/movies_repository.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';
import 'package:movies/routes/movies_navigator.dart';

class EnvMock extends Mock implements Env {
  @override
  String get tmdbApiKey => 'tmdb_api_key';

  @override
  String get tmdbBaseUrl => 'https://api.themoviedb.org/3';
}

class DioMock extends Mock implements Dio {}

class MockMovieDetailsBox extends Mock implements Box<MovieDetailModel> {}

class MockMoviesBox extends Mock implements Box<MoviesModel> {}

class MockMoviesLocalDataSource extends Mock implements IMoviesLocalDataSource {}

class MockMoviesRemoteDataSource extends Mock implements IMoviesRemoteDataSource {}

class MoviesNavigatorMock extends Mock implements MoviesNavigator {}

class MoviesRepositoryMock extends Mock implements IMoviesRepository {}
