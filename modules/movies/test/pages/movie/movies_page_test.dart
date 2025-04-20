import 'package:core/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/repositories/movies_repository.dart';
import 'package:movies/pages/movie/models/movie.model.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie/movies.controller.dart';
import 'package:movies/pages/movie/movies_page.dart';
import 'package:movies/routes/movies_navigator.dart';
import 'package:provider/provider.dart';

import '../../../../../test/helpers/golden_test_helper.dart';
import '../../helpers/mocks.dart';

void main() {
  final navigator = MoviesNavigatorMock();
  final repository = MoviesRepositoryMock();
  late MoviesController controller;

  setUpAll(AppGoldenTester().setUpAll);

  setUp(() {
    controller = MoviesController(moviesRepository: MoviesRepositoryMock());
  });

  DeviceBuilder deviceBuilder() {
    return DeviceBuilder()
      ..addScenario(
        widget: AppGoldenTester().appWrapper(
          ChangeNotifierProvider<MoviesController>.value(
            value: controller,
            child: MoviesPage.create(),
          ),
        ),
      );
  }

  setUp(() {
    GetIt.I
      ..registerFactory<MoviesNavigator>(() => navigator)
      ..registerFactory<Env>(() => EnvMock())
      ..registerFactory<IMoviesRepository>(() => repository);
  });

  tearDown(() => GetIt.I.reset());

  group('MoviesPage Tests', () {
    testGoldens('renders empty state', (tester) async {
      // Given
      when(() => repository.fetchMovies()).thenAnswer((_) => Future.value(MoviesModel.empty()));

      // When
      await tester.pumpDeviceBuilder(deviceBuilder());
      await tester.pumpAndSettle();

      // Then - should still show the UI but with empty list
      expect(find.byType(ListView), findsOneWidget);
      await screenMatchesGolden(tester, 'movies_page_empty');
    });

    testGoldens('renders with data', (tester) async {
      // Given
      final testMovies = MoviesModel(
        page: 1,
        results: [
          MovieModel.fixture().copyWith(id: 1, title: 'Test Movie 1'),
          MovieModel.fixture().copyWith(id: 2, title: 'Test Movie 2'),
        ],
        totalPages: 1,
        totalResults: 2,
      );

      when(() => repository.fetchMovies()).thenAnswer((_) => Future.value(testMovies));

      // When
      await tester.pumpDeviceBuilder(deviceBuilder());
      await tester.pumpAndSettle();

      // Then
      expect(find.text('Test Movie 1'), findsOneWidget);
      expect(find.text('Test Movie 2'), findsOneWidget);
      await screenMatchesGolden(tester, 'movies_page_data');
    });

    testGoldens('renders error state', (tester) async {
      // Given
      when(() => repository.fetchMovies()).thenThrow(Exception('Network error'));

      // When
      await tester.pumpDeviceBuilder(deviceBuilder());
      await tester.pumpAndSettle();

      // Then
      expect(find.text('Something went wrong'), findsOneWidget);
      await screenMatchesGolden(tester, 'movies_page_error');
    });
  });

  group('MoviesPage Pagination Tests', () {
    testGoldens('should fetch next page when scrolling to 80% of list', (tester) async {
      // Given
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
      when(() => repository.fetchMovies(page: 2)).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        return secondPageMovies;
      });

      // When - load first page
      await tester.pumpDeviceBuilder(deviceBuilder());
      await tester.pumpAndSettle();

      // Verify first page loaded
      await screenMatchesGolden(tester, 'movies_page_first_page_loaded');

      // When - scroll to bottom to trigger next page load
      await tester.dragUntilVisible(
        find.text('Test Movie 10'),
        find.byType(ListView),
        const Offset(0, -500),
      );

      await tester.pumpAndSettle();

      // Then - should show both pages
      expect(find.text('Test Movie 11'), findsOneWidget);
      verify(() => repository.fetchMovies(page: 2)).called(1);
      await screenMatchesGolden(tester, 'movies_page_second_page_loaded');
    });
  });
}
