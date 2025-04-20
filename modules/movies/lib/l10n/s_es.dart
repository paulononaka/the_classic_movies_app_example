// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 's.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class SEs extends S {
  SEs([String locale = 'es']) : super(locale);

  @override
  String get movies_page_app_bar => 'Hola Películas';

  @override
  String get movies_page_title => 'Películas';

  @override
  String get movies_page_genre_action => 'Acción';

  @override
  String get movies_page_minutes => 'minutos';

  @override
  String get movies_page_error_message => 'Algo salió mal';

  @override
  String get movie_details_error_loading => 'Error al cargar los detalles';

  @override
  String get movie_details_title => 'Detalle';

  @override
  String get movie_details_minutes => 'Minutos';

  @override
  String get movie_details_tab_about => 'Sobre la Película';

  @override
  String get movie_details_tab_cast => 'Reparto';

  @override
  String get movie_details_overview => 'Resumen';

  @override
  String get movie_details_status => 'Estado';
}
