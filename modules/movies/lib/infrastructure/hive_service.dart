import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:movies/data/data_sources/movies_local_data_source_impl.dart';
import 'package:movies/pages/movie/models/movie.model.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

class HiveService {
  static Future<void> initialize() async {
    final appDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDir.path);

    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(MoviesModelAdapter());
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(MovieModelAdapter());
    if (!Hive.isAdapterRegistered(2)) Hive.registerAdapter(MovieDetailModelAdapter());
    if (!Hive.isAdapterRegistered(3)) Hive.registerAdapter(GenreAdapter());
    if (!Hive.isAdapterRegistered(4)) Hive.registerAdapter(ProductionCompanyAdapter());

    await Hive.openBox<MoviesModel>(MoviesLocalDataSourceImpl.moviesBoxName);
    await Hive.openBox<MovieDetailModel>(MoviesLocalDataSourceImpl.movieDetailsBoxName);
  }
}
