import 'package:get_it/get_it.dart';
import 'package:movies/routes/movies_navigator.dart';

final GetIt dependencies = GetIt.instance;

class AppDependencies {
  Future<void> init() async {
    dependencies
      ..allowReassignment = true
      ..registerFactory<MoviesNavigator>(() => MoviesNavigator());
  }
}
