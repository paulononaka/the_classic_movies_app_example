import 'package:core/env.dart';
import 'package:core/session_tracker_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
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

class BuildContextMock extends Mock implements BuildContext {
  @override
  bool get mounted => true;
}

class BuildContextMockNotMounted extends Mock implements BuildContext {
  @override
  bool get mounted => false;
}

class SessionTrackerServiceMock extends Mock implements SessionTrackerService {
  @override
  String get sessionId => 'session_id';
}

class DioMock extends Mock implements Dio {}

class MockMovieDetailsBox extends Mock implements Box<MovieDetailModel> {}

class MockMoviesBox extends Mock implements Box<MoviesModel> {}

class MockMoviesLocalDataSource extends Mock implements IMoviesLocalDataSource {}

class MockMoviesRemoteDataSource extends Mock implements IMoviesRemoteDataSource {}

class MoviesNavigatorMock extends Mock implements MoviesNavigator {}

class MoviesRepositoryMock extends Mock implements IMoviesRepository {}
