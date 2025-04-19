import 'package:movies/pages/movie/models/movie.model.dart';

import 'models/movies.model.dart';

class MoviesRepository {
  const MoviesRepository();

  Future<MoviesModel> fetchMovies() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return MoviesModel(
      page: 1,
      results: List.generate(
        40,
        (index) => MovieModel.fixture().copyWith(
          id: index + 1,
          title: 'Test Movie ${index + 1}',
          backdropPath: '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
          posterPath: '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
        ),
      ),
      totalPages: 10,
      totalResults: 100,
    );
  }
}
