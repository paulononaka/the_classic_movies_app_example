import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:core/l10n/s.dart' as core_l10n;
import 'package:movies/l10n/s.dart' as movies_l10n;
import 'package:design_system/l10n/s.dart' as design_system_l10n;
import 'package:movies/dependencies.dart';
import 'package:movies/movies.dart';
import 'package:design_system/design_system.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:the_classic_movies_app_example/firebase_options.dart';

final GetIt di = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Env.load();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SentryService.initialize(() async {
    await DSDependencies().init();
    await AppDependencies().init();

    SentryService.configureScope(di<SessionTrackerService>());
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final navigator = di.get<MoviesNavigator>();

  @override
  Widget build(BuildContext context) {
    return ClassicMoviesThemeProviderApp(
      initialThemeMode: ThemeMode.light,
      builder: (themeMode, light, dark) => MaterialApp.router(
        title: 'Classic Movies App',
        theme: light,
        darkTheme: dark,
        themeMode: themeMode,
        localizationsDelegates: [
          core_l10n.S.delegate,
          movies_l10n.S.delegate,
          design_system_l10n.S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: movies_l10n.S.supportedLocales,
        routerConfig: navigator.config(),
      ),
    );
  }
}
