import 'package:core/env.dart';
import 'package:core/services/feature_toggle_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/repositories/movies_repository.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';
import 'package:movies/pages/movie_details/movie_details_page.dart';
import 'package:movies/routes/movies_navigator.dart';
import '../../../../../test/helpers/golden_test_helper.dart';
import '../../helpers/mocks.dart';

void main() {
  final repository = MoviesRepositoryMock();
  final featureToggleService = FeatureToggleServiceMock();

  setUpAll(() {
    registerFallbackValue(BuildContextMock());
    registerFallbackValue(FeatureToggle.showRatingDisplay);
  });

  DeviceBuilder deviceBuilder() {
    return DeviceBuilder()..addScenario(widget: AppGoldenTester().appWrapper(MovieDetailsPage.create(movieId: 634649)));
  }

  setUp(() {
    GetIt.I
      ..registerFactory<MoviesNavigator>(() => MoviesNavigatorMock())
      ..registerFactory<Env>(() => EnvMock())
      ..registerFactory<IMoviesRepository>(() => repository)
      ..registerFactory<FeatureToggleService>(() => featureToggleService);
  });

  tearDown(() => GetIt.I.reset());

  group('MovieDetailsPage Tests', () {
    testGoldens('renders MovieDetailsPage correctly with rating hidden', (final tester) async {
      // Given
      final testMovieDetail = MovieDetailModel.fixture();

      when(() => repository.fetchMovieDetails(any(), movieId: 634649)).thenAnswer((_) => Future.value(testMovieDetail));
      when(() => featureToggleService.isFeatureEnabled(FeatureToggle.showRatingDisplay)).thenReturn(false);

      // When
      await tester.pumpDeviceBuilder(deviceBuilder());
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'movie_details_page_rating_hidden');
    });

    testGoldens('renders MovieDetailsPage correctly with rating displayed', (final tester) async {
      // Given
      final testMovieDetail = MovieDetailModel.fixture();

      when(() => repository.fetchMovieDetails(any(), movieId: 634649)).thenAnswer((_) => Future.value(testMovieDetail));
      when(() => featureToggleService.isFeatureEnabled(FeatureToggle.showRatingDisplay)).thenReturn(true);

      // When
      await tester.pumpDeviceBuilder(deviceBuilder());
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'movie_details_page_rating_displayed');
    });

    testGoldens('renders Produced By tab correctly', (final tester) async {
      // Given
      final testMovieDetail = MovieDetailModel.fixture();

      when(() => repository.fetchMovieDetails(any(), movieId: 634649)).thenAnswer((_) => Future.value(testMovieDetail));
      when(() => featureToggleService.isFeatureEnabled(any())).thenReturn(false);

      // When
      await tester.pumpDeviceBuilder(deviceBuilder());
      await tester.pumpAndSettle();

      // Tap on the Produced By tab
      await tester.tap(find.text('Produced By'));
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'movie_details_produced_by_tab');
    });
  });
}
