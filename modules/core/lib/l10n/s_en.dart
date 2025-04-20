import 'package:intl/intl.dart' as intl;
import 's.dart';

class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get connection_timeout => 'Connection timeout. Please check your internet connection.';

  @override
  String get no_internet_connection => 'No internet connection. Please check your network.';

  @override
  String get unauthorized_access => 'Unauthorized access. Please check your API key.';

  @override
  String get resource_not_found => 'Resource not found.';

  @override
  String get server_error => 'Server error. Please try again later.';

  @override
  String get network_error_occurred => 'Network error occurred. Please try again.';

  @override
  String get request_cancelled => 'Request was cancelled.';
}
