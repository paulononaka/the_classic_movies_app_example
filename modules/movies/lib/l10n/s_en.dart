// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 's.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get movies_page_app_bar => 'Hello Movies';

  @override
  String get movies_page_title => 'Movies';

  @override
  String get movies_page_genre_action => 'Action';

  @override
  String get movies_page_minutes => 'minutes';

  @override
  String get movies_page_error_message => 'Something went wrong';

  @override
  String get movie_details_error_loading => 'Error loading details';

  @override
  String get movie_details_title => 'Detail';

  @override
  String get movie_details_minutes => 'Minutes';

  @override
  String get movie_details_tab_about => 'About Movie';

  @override
  String get movie_details_tab_produced_by => 'Produced By';

  @override
  String get movie_details_overview => 'Overview';

  @override
  String get movie_details_status => 'Status';
}
