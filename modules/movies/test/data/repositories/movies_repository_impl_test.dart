import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/data/repositories/movies_repository_impl.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';

import '../../helpers/mocks.dart';

void main() {
  late MoviesRepositoryImpl repository;
  late MockMoviesRemoteDataSource mockRemoteDataSource;
  late MockMoviesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockMoviesRemoteDataSource();
    mockLocalDataSource = MockMoviesLocalDataSource();
    repository = MoviesRepositoryImpl(remoteDataSource: mockRemoteDataSource, localDataSource: mockLocalDataSource);
    registerFallbackValue(MoviesModel.fixture());
    registerFallbackValue(MovieDetailModel.fixture());
  });

  group('fetchMovies', () {
    test('should return cached movies when available in local data source', () async {
      // Given
      final moviesModel = MoviesModel.fixture();
      const page = 1;

      when(() => mockLocalDataSource.getMovies(page)).thenAnswer((_) async => moviesModel);

      // When
      final result = await repository.fetchMovies(page: page);

      // Then
      expect(result, equals(moviesModel));
      verify(() => mockLocalDataSource.getMovies(page)).called(1);
      verifyNever(() => mockRemoteDataSource.fetchMovies(page: page));
      verifyNever(() => mockLocalDataSource.cacheMovies(any(), any()));
    });

    test('should fetch from remote and cache it when local data is not available', () async {
      // Given
      final moviesModel = MoviesModel.fixture();
      const page = 1;

      when(() => mockLocalDataSource.getMovies(page)).thenAnswer((_) async => null);
      when(() => mockRemoteDataSource.fetchMovies(page: page)).thenAnswer((_) async => moviesModel);
      when(() => mockLocalDataSource.cacheMovies(moviesModel, page)).thenAnswer((_) async {});

      // When
      final result = await repository.fetchMovies(page: page);

      // Then
      expect(result, equals(moviesModel));
      verify(() => mockLocalDataSource.getMovies(page)).called(1);
      verify(() => mockRemoteDataSource.fetchMovies(page: page)).called(1);
      verify(() => mockLocalDataSource.cacheMovies(moviesModel, page)).called(1);
    });

    test('should fetch from remote and cache it when local data is empty', () async {
      // Given
      final emptyMoviesModel = MoviesModel.fixture().copyWith(results: []);
      final remoteMoviesModel = MoviesModel.fixture();
      const page = 1;

      when(() => mockLocalDataSource.getMovies(page)).thenAnswer((_) async => emptyMoviesModel);
      when(() => mockRemoteDataSource.fetchMovies(page: page)).thenAnswer((_) async => remoteMoviesModel);
      when(() => mockLocalDataSource.cacheMovies(remoteMoviesModel, page)).thenAnswer((_) async {});

      // When
      final result = await repository.fetchMovies(page: page);

      // Then
      expect(result, equals(remoteMoviesModel));
      verify(() => mockLocalDataSource.getMovies(page)).called(1);
      verify(() => mockRemoteDataSource.fetchMovies(page: page)).called(1);
      verify(() => mockLocalDataSource.cacheMovies(remoteMoviesModel, page)).called(1);
    });
  });

  group('fetchMovieDetails', () {
    test('should return cached movie details when available in local data source', () async {
      // Given
      final movieDetailModel = MovieDetailModel.fixture();
      final movieId = movieDetailModel.id;

      when(() => mockLocalDataSource.getMovieDetails(movieId)).thenAnswer((_) async => movieDetailModel);

      // When
      final result = await repository.fetchMovieDetails(movieId: movieId);

      // Then
      expect(result, equals(movieDetailModel));
      verify(() => mockLocalDataSource.getMovieDetails(movieId)).called(1);
      verifyNever(() => mockRemoteDataSource.fetchMovieDetails(movieId: movieId));
      verifyNever(() => mockLocalDataSource.cacheMovieDetails(any()));
    });

    test('should fetch from remote and cache it when local data is not available', () async {
      // Given
      final movieDetailModel = MovieDetailModel.fixture();
      final movieId = movieDetailModel.id;

      when(() => mockLocalDataSource.getMovieDetails(movieId)).thenAnswer((_) async => null);
      when(() => mockRemoteDataSource.fetchMovieDetails(movieId: movieId)).thenAnswer((_) async => movieDetailModel);
      when(() => mockLocalDataSource.cacheMovieDetails(movieDetailModel)).thenAnswer((_) async {});

      // When
      final result = await repository.fetchMovieDetails(movieId: movieId);

      // Then
      expect(result, equals(movieDetailModel));
      verify(() => mockLocalDataSource.getMovieDetails(movieId)).called(1);
      verify(() => mockRemoteDataSource.fetchMovieDetails(movieId: movieId)).called(1);
      verify(() => mockLocalDataSource.cacheMovieDetails(movieDetailModel)).called(1);
    });
  });
}
