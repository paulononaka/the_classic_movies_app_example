import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:movies/pages/movie_details/movie_details_page.dart';

import '../../../../../test/helpers/golden_test_helper.dart';

void main() {
  DeviceBuilder deviceBuilder() {
    return DeviceBuilder()
      ..addScenario(
        widget: AppGoldenTester().appWrapper(
          const MovieDetailsPage(),
        ),
      );
  }

  group('MovieDetailsPage Tests', () {
    testGoldens('renders MovieDetailsPage correctly', (final tester) async {
      await tester.pumpDeviceBuilder(deviceBuilder());

      await screenMatchesGolden(tester, 'movie_details_page');
    });
  });
}
