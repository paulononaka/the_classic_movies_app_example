import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import 'helpers/cma_local_file_comparator_with_threshold.dart';

Future<void> testExecutable(final FutureOr<void> Function() testMain) async {
  if (goldenFileComparator is LocalFileComparator) {
    final testUrl = (goldenFileComparator as LocalFileComparator).basedir;

    const linuxThreshold = 0.05;
    const macOsThreshold = 0.0001;

    const kGoldenTestsThreshold = bool.fromEnvironment('RUNNING_ON_CI') ? linuxThreshold : macOsThreshold;

    goldenFileComparator = CMALocalFileComparatorWithThreshold(
      Uri.parse('$testUrl/test.dart'),
      kGoldenTestsThreshold,
    );
  } else {
    throw Exception(
      'Expected `goldenFileComparator` to be of type `LocalFileComparator`, '
      'but it is of type `${goldenFileComparator.runtimeType}`',
    );
  }

  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(defaultDevices: const [Device.iphone11]),
  );
}
