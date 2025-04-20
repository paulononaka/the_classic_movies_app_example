import 'package:intl/intl.dart' as intl;
import 's.dart';

class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get retry => 'Retry';

  @override
  String get go_back => 'Go Back';
  
  @override
  String get empty_state_action => 'Refresh';
}
