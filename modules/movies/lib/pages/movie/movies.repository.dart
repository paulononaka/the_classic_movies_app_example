import 'package:movies/pages/movie/models/movie.model.dart';

import 'models/movies.model.dart';

class MoviesRepository {
  const MoviesRepository();

  Future<MoviesModel> fetchMovies({int page = 1}) async {
    await Future.delayed(const Duration(milliseconds: 200));

    const int itemsPerPage = 10;
    final int startIndex = (page - 1) * itemsPerPage;

    return MoviesModel(
      page: page,
      results: List.generate(
        page < itemsPerPage ? itemsPerPage : itemsPerPage * (page - itemsPerPage - 1),
        (index) => MovieModel.fixture().copyWith(
          id: startIndex + index + 1,
          title: 'Test Movie ${startIndex + index + 1}',
          backdropPath: '/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg',
          posterPath: '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg',
        ),
      ),
      totalPages: 10,
      totalResults: 100,
    );
  }
}
