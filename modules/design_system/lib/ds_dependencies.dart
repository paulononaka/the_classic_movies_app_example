import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:core/services/session_tracker_service.dart';

class DSDependencies {
  Future<void> init() async {
    GetIt.instance
      ..allowReassignment = true
      ..registerFactory<SessionTrackerService>(() => SessionTrackerService());
  }
}
