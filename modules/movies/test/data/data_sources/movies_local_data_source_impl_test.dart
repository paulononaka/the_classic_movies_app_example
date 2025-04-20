import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/data/data_sources/movies_local_data_source_impl.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

import '../../helpers/mocks.dart';

void main() {
  late MoviesLocalDataSourceImpl localDataSource;
  late MockMoviesBox mockMoviesBox;
  late MockMovieDetailsBox mockMovieDetailsBox;

  setUp(() {
    mockMoviesBox = MockMoviesBox();
    mockMovieDetailsBox = MockMovieDetailsBox();

    localDataSource = MoviesLocalDataSourceImpl(mockMoviesBox, mockMovieDetailsBox);
  });

  group('getMovies', () {
    test('should return cached MoviesModel when it exists in the box', () async {
      // Given
      final moviesModel = MoviesModel.fixture();
      const page = 1;
      when(() => mockMoviesBox.get('page_$page')).thenReturn(moviesModel);

      // When
      final result = await localDataSource.getMovies(page);

      // Then
      expect(result, equals(moviesModel));
      verify(() => mockMoviesBox.get('page_$page')).called(1);
    });

    test('should return null when requested movies are not in the box', () async {
      // Given
      const page = 1;
      when(() => mockMoviesBox.get('page_$page')).thenReturn(null);

      // When
      final result = await localDataSource.getMovies(page);

      // Then
      expect(result, isNull);
      verify(() => mockMoviesBox.get('page_$page')).called(1);
    });
  });

  group('cacheMovies', () {
    test('should cache MoviesModel in the box with the correct key', () async {
      // Given
      final moviesModel = MoviesModel.fixture();
      const page = 1;
      when(() => mockMoviesBox.put('page_$page', moviesModel)).thenAnswer((_) async {});

      // When
      await localDataSource.cacheMovies(moviesModel, page);

      // Then
      verify(() => mockMoviesBox.put('page_$page', moviesModel)).called(1);
    });
  });

  group('getMovieDetails', () {
    test('should return cached MovieDetailModel when it exists in the box', () async {
      // Given
      final movieDetail = MovieDetailModel.fixture();
      final movieId = movieDetail.id;
      when(() => mockMovieDetailsBox.get('movie_$movieId')).thenReturn(movieDetail);

      // When
      final result = await localDataSource.getMovieDetails(movieId);

      // Then
      expect(result, equals(movieDetail));
      verify(() => mockMovieDetailsBox.get('movie_$movieId')).called(1);
    });

    test('should return null when requested movie details are not in the box', () async {
      // Given
      const movieId = 123;
      when(() => mockMovieDetailsBox.get('movie_$movieId')).thenReturn(null);

      // When
      final result = await localDataSource.getMovieDetails(movieId);

      // Then
      expect(result, isNull);
      verify(() => mockMovieDetailsBox.get('movie_$movieId')).called(1);
    });
  });

  group('cacheMovieDetails', () {
    test('should cache MovieDetailModel in the box with the correct key', () async {
      // Given
      final movieDetail = MovieDetailModel.fixture();
      when(() => mockMovieDetailsBox.put('movie_${movieDetail.id}', movieDetail)).thenAnswer((_) async {});

      // When
      await localDataSource.cacheMovieDetails(movieDetail);

      // Then
      verify(() => mockMovieDetailsBox.put('movie_${movieDetail.id}', movieDetail)).called(1);
    });
  });

  group('clearCache', () {
    test('should clear both movies and movie details boxes', () async {
      // Given
      when(() => mockMoviesBox.clear()).thenAnswer((_) async => 0);
      when(() => mockMovieDetailsBox.clear()).thenAnswer((_) async => 0);

      // When
      await localDataSource.clearCache();

      // Then
      verify(() => mockMoviesBox.clear()).called(1);
      verify(() => mockMovieDetailsBox.clear()).called(1);
    });
  });
}
