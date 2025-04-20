import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/pages/movie/models/movie.model.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie/movies.controller.dart';
import 'package:movies/pages/movie/movies.state.dart';

import '../../helpers/mocks.dart';

void main() {
  group('MoviesController Tests', () {
    late MoviesRepositoryMock repository;
    late MoviesController controller;

    setUpAll(() {
      registerFallbackValue(BuildContextMock());
    });

    setUp(() {
      repository = MoviesRepositoryMock();
      controller = MoviesController(moviesRepository: repository);
    });

    test('initial state should be loading with empty movies list', () {
      expect(controller.state, isA<MoviesLoadingState>());
      expect(controller.isLoadingMore, isFalse);
    });

    test('fetchInitialData should update state with first page of movies', () async {
      // Given
      final testMovies = MoviesModel(
        page: 1,
        results: List.generate(10, (index) => MovieModel.fixture().copyWith(id: index + 1, title: 'Test Movie ${index + 1}')),
        totalPages: 10,
        totalResults: 100,
      );

      when(() => repository.fetchMovies(any(), page: 1)).thenAnswer((_) async => testMovies);

      // When
      await controller.fetchData(BuildContextMock());

      // Then
      expect(controller.state, isA<MoviesSuccessState>());

      final state = controller.state as MoviesSuccessState;
      expect(state.movies.length, equals(10));
      expect(state.movies.first.id, equals(1));
      expect(state.movies.last.id, equals(10));
      expect(state.currentPage, 1);
      expect(state.hasReachedMax, isFalse);

      expect(controller.isLoadingMore, isFalse);
      verify(() => repository.fetchMovies(any(), page: 1)).called(1);
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

      when(() => repository.fetchMovies(any(), page: 1)).thenAnswer((_) async => firstPageMovies);
      when(() => repository.fetchMovies(any(), page: 2)).thenAnswer((_) async => secondPageMovies);

      // Load first page
      await controller.fetchData(BuildContextMock());

      // When - fetch next page
      await controller.fetchNextPage(BuildContextMock());

      // Then
      expect(controller.state, isA<MoviesSuccessState>());

      final state = controller.state as MoviesSuccessState;
      expect(state.movies.length, equals(20));
      expect(state.movies.first.id, equals(1));
      expect(state.movies.last.id, equals(20));
      expect(state.currentPage, 2);
      expect(state.hasReachedMax, isFalse);

      expect(controller.isLoadingMore, isFalse);
      verify(() => repository.fetchMovies(any(), page: 2)).called(1);
    });

    test('fetchNextPage should do nothing if has reached max', () async {
      // Given - set up controller with last page loaded
      final lastPageMovies = MoviesModel(
        page: 1,
        results: List.generate(5, (index) => MovieModel.fixture()),
        totalPages: 1,
        totalResults: 5,
      );

      when(() => repository.fetchMovies(any(), page: 1)).thenAnswer((_) async => lastPageMovies.copyWith(page: 1));

      // Load first page
      await controller.fetchData(BuildContextMock());

      // Verify state before next operation
      expect(controller.state, isA<MoviesSuccessState>());
      expect((controller.state as MoviesSuccessState).hasReachedMax, isTrue);

      // When - try to fetch next page when already at max
      await controller.fetchNextPage(BuildContextMock());

      // Then - should not call repository again
      verifyNever(() => repository.fetchMovies(any(), page: 2));
    });

    test('fetchNextPage should handle errors gracefully', () async {
      // Given - first page already loaded
      final firstPageMovies = MoviesModel(
        page: 1,
        results: List.generate(10, (index) => MovieModel.fixture()),
        totalPages: 10,
        totalResults: 100,
      );

      when(() => repository.fetchMovies(any(), page: 1)).thenAnswer((_) async => firstPageMovies);
      when(() => repository.fetchMovies(any(), page: 2)).thenThrow(Exception('Network error'));

      // Load first page
      await controller.fetchData(BuildContextMock());

      // Verify state before operation
      expect(controller.state, isA<MoviesSuccessState>());

      // When - fetch next page with error
      await controller.fetchNextPage(BuildContextMock());

      // Then - should keep existing state type, but might have error info
      expect(controller.isLoadingMore, isFalse);
      verify(() => repository.fetchMovies(any(), page: 2)).called(1);
    });
  });
}
