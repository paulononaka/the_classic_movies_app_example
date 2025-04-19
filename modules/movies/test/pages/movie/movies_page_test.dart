import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:movies/pages/movie/movies_page.dart';
import 'package:movies/routes/movies_navigator.dart';

import '../../../../../test/helpers/golden_test_helper.dart';

class MoviesNavigatorFake extends Fake implements MoviesNavigator {}

void main() {
  DeviceBuilder deviceBuilder() {
    return DeviceBuilder()
      ..addScenario(
        widget: AppGoldenTester().appWrapper(
          MoviesPage(),
        ),
      );
  }

  setUp(() {
    GetIt.I.registerFactory<MoviesNavigator>(() => MoviesNavigatorFake());
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  group('MoviesPage Tests', () {
    testGoldens('renders MoviesPage correctly', (final tester) async {
      await tester.pumpDeviceBuilder(deviceBuilder());

      await screenMatchesGolden(tester, 'movies_page');
    });
  });
}
