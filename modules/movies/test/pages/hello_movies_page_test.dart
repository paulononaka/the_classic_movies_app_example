import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:movies/src/presentation/pages/hello_movies_page.dart';

import '../helpers/cma_golden_tester.dart';

void main() {
  DeviceBuilder deviceBuilder() {
    return DeviceBuilder()
      ..addScenario(
        widget: CMAMoviesGoldenTester().appWrapper(
          const HelloMoviesPage(),
        ),
      );
  }

  group('HelloMoviesPage Golden Tests', () {
    testGoldens('renders HelloMoviesPage correctly', (final tester) async {
      await tester.pumpDeviceBuilder(deviceBuilder());

      await screenMatchesGolden(tester, 'hello_movies_page');
    });
  });
}
