import 'package:intl/intl.dart' as intl;
import 's.dart';

class SEs extends S {
  SEs([String locale = 'es']) : super(locale);

  @override
  String get retry => 'Reintentar';

  @override
  String get go_back => 'Volver';
  
  @override
  String get empty_state_action => 'Actualizar';
}
