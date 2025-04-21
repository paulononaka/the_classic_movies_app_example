import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/infrastructure/movies_dependencies.dart';
import 'package:movies/routes/movies_navigator.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

final GetIt di = GetIt.instance;

class AppDependencies {
  Future<void> init() async {
    final featureToggleService = FeatureToggleService(FirebaseRemoteConfig.instance);
    await featureToggleService.initialize();

    di
      ..allowReassignment = true
      ..registerSingleton<FeatureToggleService>(featureToggleService)
      ..registerFactory<MoviesNavigator>(() => MoviesNavigator())
      ..registerFactory<Env>(() => Env())
      ..registerFactory<Dio>(() {
        final dio = Dio();
        dio.addSentry();
        return dio;
      });

    final moviesDependencies = MoviesDependencies();
    await moviesDependencies.init();
  }
}
