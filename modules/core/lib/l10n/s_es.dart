import 'package:intl/intl.dart' as intl;
import 's.dart';

class SEs extends S {
  SEs([String locale = 'es']) : super(locale);

  @override
  String get connection_timeout => 'Tiempo de conexión agotado. Por favor, verifica tu conexión a internet.';

  @override
  String get no_internet_connection => 'Sin conexión a internet. Por favor, verifica tu red.';

  @override
  String get unauthorized_access => 'Acceso no autorizado. Por favor, verifica tu clave API.';

  @override
  String get resource_not_found => 'Recurso no encontrado.';

  @override
  String get server_error => 'Error del servidor. Por favor, inténtalo de nuevo más tarde.';

  @override
  String get network_error_occurred => 'Ocurrió un error de red. Por favor, inténtalo de nuevo.';

  @override
  String get request_cancelled => 'La solicitud fue cancelada.';
}
