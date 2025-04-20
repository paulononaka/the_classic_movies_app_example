import 'package:core/env.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies/repositories/movies.repository.dart';
import 'package:movies/routes/movies_navigator.dart';

final GetIt dependencies = GetIt.instance;

class AppDependencies {
  Future<void> init() async {
    await dotenv.load(fileName: '.env');

    dependencies
      ..allowReassignment = true
      ..registerFactory<MoviesNavigator>(() => MoviesNavigator())
      ..registerFactory<Env>(() => Env())
      ..registerFactory<MoviesRepository>(() => MoviesRepository(dio: Dio(), env: dependencies.get<Env>()));
  }
}
