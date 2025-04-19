import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/pages/movie/models/movie.model.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie/movies.controller.dart';

import '../../helpers/mocks.dart';

void main() {
  group('MoviesController Tests', () {
    late MoviesRepositoryMock repository;
    late MoviesController controller;

    setUp(() {
      repository = MoviesRepositoryMock();
      controller = MoviesController(moviesRepository: repository);
    });

    test('initial state should be loading with empty movies list', () {
      expect(controller.status, equals(MoviesControllerStatus.loading));
      expect(controller.movies, isEmpty);
      expect(controller.isLoadingMore, isFalse);
      expect(controller.hasReachedMax, isFalse);
    });

    test('fetchInitialData should update state with first page of movies', () async {
      // Given
      final testMovies = MoviesModel(
        page: 1,
        results: List.generate(10, (index) => MovieModel.fixture().copyWith(id: index + 1, title: 'Test Movie ${index + 1}')),
        totalPages: 10,
        totalResults: 100,
      );

      when(() => repository.fetchMovies(page: 1)).thenAnswer((_) async => testMovies);

      // When
      await controller.fetchInitialData();

      // Then
      expect(controller.status, equals(MoviesControllerStatus.success));
      expect(controller.movies.length, equals(10));
      expect(controller.movies.first.id, equals(1));
      expect(controller.movies.last.id, equals(10));
      expect(controller.isLoadingMore, isFalse);
      expect(controller.hasReachedMax, isFalse);
      verify(() => repository.fetchMovies(page: 1)).called(1);
    });

    test('fetchNextPage should append next page of movies to existing list', () async {
      // Given - first page already loaded
      final firstPageMovies = MoviesModel(
        page: 1,
        results: List.generate(10, (index) => MovieModel.fixture().copyWith(id: index + 1, title: 'Test Movie ${index + 1}')),
        totalPages: 10,
        totalResults: 100,
      );

      final secondPageMovies = MoviesModel(
        page: 2,
        results: List.generate(10, (index) => MovieModel.fixture().copyWith(id: index + 11, title: 'Test Movie ${index + 11}')),
        totalPages: 10,
        totalResults: 100,
      );

      when(() => repository.fetchMovies(page: 1)).thenAnswer((_) async => firstPageMovies);
      when(() => repository.fetchMovies(page: 2)).thenAnswer((_) async => secondPageMovies);

      // Load first page
      await controller.fetchInitialData();

      // When - fetch next page
      await controller.fetchNextPage();

      // Then
      expect(controller.status, equals(MoviesControllerStatus.success));
      expect(controller.movies.length, equals(20));
      expect(controller.movies.first.id, equals(1));
      expect(controller.movies.last.id, equals(20));
      expect(controller.isLoadingMore, isFalse);
      expect(controller.hasReachedMax, isFalse);
      verify(() => repository.fetchMovies(page: 2)).called(1);
    });

    test('fetchNextPage should do nothing if has reached max', () async {
      // Given - set up controller with last page loaded
      final lastPageMovies = MoviesModel(
        page: 1,
        results: List.generate(5, (index) => MovieModel.fixture()),
        totalPages: 1,
        totalResults: 5,
      );

      when(() => repository.fetchMovies(page: 1)).thenAnswer((_) async => lastPageMovies.copyWith(page: 1));

      // Load first page
      await controller.fetchInitialData();

      // When - try to fetch next page when already at max
      await controller.fetchNextPage();

      // Then - should not call repository again
      verifyNever(() => repository.fetchMovies(page: 2));
    });

    test('fetchNextPage should handle errors gracefully', () async {
      // Given - first page already loaded
      final firstPageMovies = MoviesModel(
        page: 1,
        results: List.generate(10, (index) => MovieModel.fixture()),
        totalPages: 10,
        totalResults: 100,
      );

      when(() => repository.fetchMovies(page: 1)).thenAnswer((_) async => firstPageMovies);
      when(() => repository.fetchMovies(page: 2)).thenThrow(Exception('Network error'));

      // Load first page
      await controller.fetchInitialData();
      final initialMoviesCount = controller.movies.length;

      // When - fetch next page with error
      await controller.fetchNextPage();

      // Then - should keep existing data and reset loading state
      expect(controller.status, equals(MoviesControllerStatus.success));
      expect(controller.movies.length, equals(initialMoviesCount));
      expect(controller.isLoadingMore, isFalse);
      verify(() => repository.fetchMovies(page: 2)).called(1);
    });
  });
}
