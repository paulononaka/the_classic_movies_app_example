import 'package:core/env.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies/infrastructure/movies_dependencies.dart';
import 'package:movies/routes/movies_navigator.dart';

final GetIt di = GetIt.instance;

class AppDependencies {
  Future<void> init() async {
    await dotenv.load(fileName: '.env');

    di
      ..allowReassignment = true
      ..registerFactory<MoviesNavigator>(() => MoviesNavigator())
      ..registerFactory<Env>(() => Env())
      ..registerFactory<Dio>(() => Dio());

    final moviesDependencies = MoviesDependencies();
    await moviesDependencies.init();
  }
}
