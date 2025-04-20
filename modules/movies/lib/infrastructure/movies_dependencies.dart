import 'package:core/env.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:movies/data/data_sources/movies_local_data_source_impl.dart';
import 'package:movies/data/data_sources/movies_remote_data_source_impl.dart';
import 'package:movies/data/repositories/movies_repository_impl.dart';
import 'package:movies/domain/data_sources/movies_local_data_source.dart';
import 'package:movies/domain/data_sources/movies_remote_data_source.dart';
import 'package:movies/domain/repositories/movies_repository.dart';
import 'package:movies/infrastructure/hive_service.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

final GetIt di = GetIt.instance;

class MoviesDependencies {
  Future<void> init() async {
    await HiveService.initialize();
    di.registerLazySingleton<Box<MoviesModel>>(() => Hive.box<MoviesModel>(MoviesLocalDataSourceImpl.moviesBoxName));
    di.registerLazySingleton<Box<MovieDetailModel>>(() => Hive.box<MovieDetailModel>(MoviesLocalDataSourceImpl.movieDetailsBoxName));
    di.registerLazySingleton<IMoviesLocalDataSource>(() => MoviesLocalDataSourceImpl(di<Box<MoviesModel>>(), di<Box<MovieDetailModel>>()));
    di.registerLazySingleton<IMoviesRemoteDataSource>(() => MoviesRemoteDataSourceImpl(dio: di<Dio>(), env: di<Env>()));
    di.registerLazySingleton<IMoviesRepository>(
      () => MoviesRepositoryImpl(
        remoteDataSource: di<IMoviesRemoteDataSource>(),
        localDataSource: di<IMoviesLocalDataSource>(),
      ),
    );
  }
}
