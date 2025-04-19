import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/pages/movie/models/movie.model.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie/movies.repository.dart';
import 'package:movies/pages/movie/movies_page.dart';
import 'package:movies/routes/movies_navigator.dart';

import '../../../../../test/helpers/golden_test_helper.dart';
import '../../helpers/mocks.dart';

void main() {
  setUpAll(AppGoldenTester().setUpAll);

  DeviceBuilder deviceBuilder() {
    return DeviceBuilder()
      ..addScenario(
        widget: AppGoldenTester().appWrapper(MoviesPage.create()),
      );
  }

  group('MoviesPage Tests', () {
    final navigator = MoviesNavigatorMock();
    final repository = MoviesRepositoryMock();

    setUp(() {
      GetIt.I
        ..registerFactory<MoviesNavigator>(() => navigator)
        ..registerFactory<MoviesRepository>(() => repository);
    });

    tearDown(() => GetIt.I.reset());
    testGoldens('renders empty state', (tester) async {
      // Given
      when(() => repository.fetchMovies()).thenAnswer((_) => Future.value(MoviesModel.empty()));

      // When
      await tester.pumpDeviceBuilder(deviceBuilder());
      await tester.pumpAndSettle();

      // Then - should still show the UI but with empty list
      expect(find.text('Movies'), findsOneWidget);
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
}
