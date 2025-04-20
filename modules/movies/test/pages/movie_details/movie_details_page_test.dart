import 'package:core/env.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/pages/movie_details/models/movie_detail.model.dart';
import 'package:movies/repositories/movies.repository.dart';
import 'package:movies/pages/movie_details/movie_details_page.dart';
import 'package:movies/routes/movies_navigator.dart';
import '../../../../../test/helpers/golden_test_helper.dart';
import '../../helpers/mocks.dart';

void main() {
  final repository = MoviesRepositoryMock();

  setUpAll(AppGoldenTester().setUpAll);

  DeviceBuilder deviceBuilder() {
    return DeviceBuilder()..addScenario(widget: AppGoldenTester().appWrapper(MovieDetailsPage.create(movieId: 634649)));
  }

  setUp(() {
    GetIt.I
      ..registerFactory<MoviesNavigator>(() => MoviesNavigatorMock())
      ..registerFactory<Env>(() => EnvMock())
      ..registerFactory<MoviesRepository>(() => repository);
  });

  tearDown(() => GetIt.I.reset());

  group('MovieDetailsPage Tests', () {
    testGoldens('renders MovieDetailsPage correctly', (final tester) async {
      // Given
      final testMovieDetail = MovieDetailModel.fixture();

      when(() => repository.fetchMovieDetails(movieId: 634649)).thenAnswer((_) => Future.value(testMovieDetail));

      // When
      await tester.pumpDeviceBuilder(deviceBuilder());
      await tester.pumpAndSettle();

      await screenMatchesGolden(tester, 'movie_details_page');
    });

    testGoldens('renders Produced By tab correctly', (final tester) async {
      // Given
      final testMovieDetail = MovieDetailModel.fixture();

      when(() => repository.fetchMovieDetails(movieId: 634649)).thenAnswer((_) => Future.value(testMovieDetail));

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
