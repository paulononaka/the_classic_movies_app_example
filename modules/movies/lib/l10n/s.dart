import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 's_en.dart';
import 's_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/s.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @movies_page_app_bar.
  ///
  /// In en, this message translates to:
  /// **'Hello Movies'**
  String get movies_page_app_bar;

  /// No description provided for @movies_page_title.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get movies_page_title;

  /// No description provided for @movies_page_genre_action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get movies_page_genre_action;

  /// No description provided for @movies_page_minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get movies_page_minutes;

  /// No description provided for @movies_page_error_message.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get movies_page_error_message;

  /// No description provided for @movies_page_no_movies.
  ///
  /// In en, this message translates to:
  /// **'No movies available'**
  String get movies_page_no_movies;

  /// No description provided for @movie_details_error_loading.
  ///
  /// In en, this message translates to:
  /// **'Error loading details'**
  String get movie_details_error_loading;

  /// No description provided for @movie_details_title.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get movie_details_title;

  /// No description provided for @movie_details_minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get movie_details_minutes;

  /// No description provided for @movie_details_tab_about.
  ///
  /// In en, this message translates to:
  /// **'About Movie'**
  String get movie_details_tab_about;

  /// No description provided for @movie_details_tab_produced_by.
  ///
  /// In en, this message translates to:
  /// **'Produced By'**
  String get movie_details_tab_produced_by;

  /// No description provided for @movie_details_overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get movie_details_overview;

  /// No description provided for @movie_details_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get movie_details_status;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @go_back.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get go_back;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return SEn();
    case 'es': return SEs();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
