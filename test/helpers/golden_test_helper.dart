import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:movies/l10n/s.dart' as movies_l10n;
import 'package:design_system/l10n/s.dart' as design_system_l10n;
import 'package:core/l10n/s.dart' as core_l10n;

class AppGoldenTester {
  List<Device> get devices => [Device.iphone11];

  Widget appWrapper(final Widget widget) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      supportedLocales: movies_l10n.S.supportedLocales,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        core_l10n.S.delegate,
        movies_l10n.S.delegate,
        design_system_l10n.S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Material(child: widget),
    );
  }
}
