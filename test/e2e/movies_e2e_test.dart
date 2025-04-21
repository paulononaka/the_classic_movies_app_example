import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/repositories/movies_repository.dart';
import 'package:movies/movies.dart';
import 'package:movies/pages/movie/models/movie.model.dart';
import 'package:movies/pages/movie/models/movies.model.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';
import 'package:movies/pages/movie_details/components/movie_details_widget.dart';
import 'package:movies/pages/movie_details/components/movie_header_widget.dart';
import 'package:movies/pages/movie_details/components/tab_bar_widget.dart';
import 'package:movies/routes/movies_navigator.dart';
import 'package:the_classic_movies_app_example/main.dart';
import 'package:get_it/get_it.dart';
import 'package:design_system/design_system.dart';
import 'package:core/core.dart';

class FeatureToggleServiceMock extends Mock implements FeatureToggleService {}

class EnvMock extends Mock implements Env {}

void main() {
  group('E2E Test Classic Movies App', () {
    final featureToggleService = FeatureToggleServiceMock();
    final env = EnvMock();
    setUp(() {
      GetIt.I
        ..registerLazySingleton<Env>(() => env)
        ..registerLazySingleton<MoviesNavigator>(() => MoviesNavigator())
        ..registerLazySingleton<FeatureToggleService>(() => featureToggleService)
        ..registerLazySingleton<SessionTrackerService>(() => SessionTrackerServiceMock());

      when(() => featureToggleService.isFeatureEnabled(FeatureToggle.showRatingDisplay)).thenReturn(false);
    });

    tearDown(() => GetIt.I.reset());

    DeviceBuilder deviceBuilder() => DeviceBuilder()..addScenario(widget: MyApp());

    group('Happy Path Flow', () {
      setUp(() {
        GetIt.I.registerLazySingleton<IMoviesRepository>(() => MoviesRepositoryMock());
      });

      testGoldens('Complete Happy Path Flow', (tester) async {
        // Initial loading of the app showing the movies list
        await tester.pumpDeviceBuilder(deviceBuilder());
        await tester.pumpAndSettle();
        await screenMatchesGolden(tester, 'happy_path_movies_list_page');

        // Verify movies are displayed
        expect(find.byType(MovieListItem), findsWidgets);

        // Select the first movie to view details
        final firstMovie = find.byType(MovieListItem).first;
        expect(firstMovie, findsOneWidget);
        await tester.tap(firstMovie);
        await tester.pumpAndSettle();

        // Verify we're on the movie details page
        await screenMatchesGolden(tester, 'happy_path_movie_details_page');
        expect(find.byType(MovieHeaderWidget), findsOneWidget);

        // Verify movie details components are displayed
        expect(find.byType(MovieDetailsWidget), findsOneWidget);
        expect(find.byType(TabBarWidget), findsOneWidget);

        // Tap on the Overview tab (first tab)
        final overviewTab = find.text('Overview').first;
        expect(overviewTab, findsOneWidget);
        await tester.tap(overviewTab);
        await tester.pumpAndSettle();
        await screenMatchesGolden(tester, 'happy_path_movie_overview_tab');

        // Tap on the Produced By tab (second tab)
        final producedByTab = find.text('Produced By').first;
        expect(producedByTab, findsOneWidget);
        await tester.tap(producedByTab);
        await tester.pumpAndSettle();
        await screenMatchesGolden(tester, 'happy_path_movie_produced_by_tab');

        // Navigate back to the movies list
        final backButton = find.byKey(const Key('back_button'));
        expect(backButton, findsOneWidget);
        await tester.tap(backButton);
        await tester.pumpAndSettle();

        // Verify we're back on the movies list page
        await screenMatchesGolden(tester, 'happy_path_back_to_movies_list');
        expect(find.byType(MovieListItem), findsWidgets);
      });
    });

    group('Error Scenarios', () {
      setUp(() {
        GetIt.I.registerLazySingleton<IMoviesRepository>(() => MoviesRepositoryErrorMock());
      });

      testGoldens('Network Error When Loading Movies', (tester) async {
        // Initial loading of the app with network error
        await tester.pumpDeviceBuilder(deviceBuilder());
        await tester.pumpAndSettle();

        // Verify error state is displayed
        await screenMatchesGolden(tester, 'error_loading_movies');
        expect(find.byType(AppErrorWidget), findsOneWidget);

        // Tap retry button
        final retryButton = find.text('Retry');
        expect(retryButton, findsOneWidget);
        await tester.tap(retryButton);
        await tester.pumpAndSettle();

        // Error should still be displayed after retry
        await screenMatchesGolden(tester, 'error_after_retry');
        expect(find.byType(AppErrorWidget), findsOneWidget);
      });
    });
  });
}

class MoviesRepositoryMock implements IMoviesRepository {
  @override
  Future<MovieDetailModel> fetchMovieDetails(BuildContext context, {required int movieId}) async {
    return MovieDetailModel(
      id: movieId,
      title: 'Mock Movie Title',
      overview: 'This is a mock movie overview for testing purposes.',
      posterPath: '',
      backdropPath: '',
      releaseDate: '2023-10-31',
      runtime: 120,
      voteAverage: 8.5,
      genres: [Genre(id: 1, name: 'Action'), Genre(id: 2, name: 'Drama')],
      status: 'Released',
      tagline: 'Mock Tagline',
      productionCompanies: [ProductionCompany(id: 1, name: 'Mock Studio', logoPath: '', originCountry: 'US')],
    );
  }

  @override
  Future<MoviesModel> fetchMovies(BuildContext context, {int page = 1}) async {
    return MoviesModel(
      page: page,
      totalPages: 10,
      totalResults: 200,
      results: List.generate(
        20,
        (index) => MovieModel(
          id: index + 1,
          title: 'Movie ${index + 1}',
          releaseDate: '2023-10-${(index % 28) + 1}',
          voteAverage: (index % 5) + 5.0,
        ),
      ),
    );
  }
}

class MoviesRepositoryErrorMock implements IMoviesRepository {
  @override
  Future<MovieDetailModel> fetchMovieDetails(BuildContext context, {required int movieId}) async {
    throw Exception('Network error occurred while fetching movie details');
  }

  @override
  Future<MoviesModel> fetchMovies(BuildContext context, {int page = 1}) async {
    throw Exception('Network error occurred while fetching popular movies');
  }
}

class SessionTrackerServiceMock implements SessionTrackerService {
  String _sessionId = 'MOCK_SESSION';

  @override
  String get sessionId => _sessionId;

  @override
  void setSessionId() {
    _sessionId = 'MOCK_SESSION_${DateTime.now().millisecondsSinceEpoch}';
  }
}
