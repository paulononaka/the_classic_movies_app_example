import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ClassicMoviesTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: false,
      fontFamily: 'Gilroy',
      brightness: Brightness.light,
      primaryColor: const Color(0xFFF2C94C),
      canvasColor: const Color(0xFFF5F5F0),
      scaffoldBackgroundColor: const Color(0xFF242A32),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF242A32),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFF2C94C), size: 24),
        titleTextStyle: TextStyle(color: Color(0xFFECECEC), fontWeight: FontWeight.w600, fontSize: 16, fontFamily: 'Montserrat'),
      ),
      cardTheme: const CardTheme(
        color: Color(0xFF1A1A1A),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)), side: BorderSide(color: Color(0xFF3C3C3C), width: 1)),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14),
        unselectedLabelStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14),
        indicator: UnderlineTabIndicator(borderSide: BorderSide(color: Color(0xFF3A3F47), width: 4), insets: EdgeInsets.symmetric(horizontal: 16)),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
        titleLarge: TextStyle(color: Color(0xFFECECEC), fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: const Color(0xFFF2C94C),
          foregroundColor: const Color(0xFF333333),
          minimumSize: kIsWeb ? const Size(56, 48) : const Size(48, 48),
          elevation: 2,
          textStyle: const TextStyle(color: Color(0xFF333333), fontFamily: 'Gilroy', fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: const Color(0xFFF2C94C),
          side: const BorderSide(color: Color(0xFFF2C94C), width: 2),
          minimumSize: kIsWeb ? const Size(56, 48) : const Size(48, 48),
          textStyle: const TextStyle(color: Color(0xFFF2C94C), fontFamily: 'Gilroy', fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFF2C94C),
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(color: Color(0xFFF2C94C), fontFamily: 'Gilroy', fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(right: 24, left: 24, top: 16, bottom: 16),
        filled: true,
        fillColor: const Color(0xFF252525),
        floatingLabelStyle: const TextStyle(fontSize: 14, height: 1.2, fontWeight: FontWeight.bold, color: Color(0xFFF2C94C)),
        labelStyle: const TextStyle(fontSize: 14, height: 1.2, fontWeight: FontWeight.w400, color: Color(0xFFF2C94C)),
        hintStyle: const TextStyle(fontSize: 14, height: 1.2, fontWeight: FontWeight.w400, color: Color(0xFF999999)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF3C3C3C))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFF2C94C), width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF8C1D18), width: 2)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF3C3C3C))),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))),
        backgroundColor: Color(0xFF1A1A1A),
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: Color(0xFF252525),
        disabledColor: Color(0xFF3C3C3C),
        selectedColor: Color(0xFFF2C94C),
        secondarySelectedColor: Color(0xFFF2C94C),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: TextStyle(color: Color(0xFFFFFFFF), fontFamily: 'Gilroy', fontWeight: FontWeight.w500),
        secondaryLabelStyle: TextStyle(color: Color(0xFF333333), fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
        brightness: Brightness.dark,
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFFF2C94C),
        onPrimary: Color(0xFF333333),
        secondary: Color(0xFF8C1D18),
        onSecondary: Colors.white,
        error: Color(0xFFE76F51),
        onError: Colors.white,
        surface: Color(0xFF242A32),
        onSurface: Colors.white,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: false,
      fontFamily: 'Gilroy',
      brightness: Brightness.dark,
      primaryColor: const Color(0xFFF2C94C),
      canvasColor: Colors.black,
      scaffoldBackgroundColor: const Color(0xFF242A32),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF242A32),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFF2C94C), size: 24),
        titleTextStyle: TextStyle(color: Color(0xFFECECEC), fontWeight: FontWeight.w600, fontSize: 16, fontFamily: 'Montserrat'),
      ),
      cardTheme: const CardTheme(
        color: Color(0xFF1A1A1A),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)), side: BorderSide(color: Color(0xFF3C3C3C), width: 1)),
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: Color(0xFF333333),
        unselectedLabelColor: Colors.white,
        indicator: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(90))),
        labelStyle: TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w700, fontSize: 14),
        unselectedLabelStyle: TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w500, fontSize: 14),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
        titleLarge: TextStyle(color: Color(0xFFECECEC), fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: const Color(0xFFF2C94C),
          foregroundColor: const Color(0xFF333333),
          minimumSize: kIsWeb ? const Size(56, 48) : const Size(48, 48),
          elevation: 2,
          textStyle: const TextStyle(color: Color(0xFF333333), fontFamily: 'Gilroy', fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFF333333), width: 1),
          minimumSize: const Size(48, 48),
          textStyle: const TextStyle(color: Colors.white, fontFamily: 'Gilroy', fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFF2C94C),
          minimumSize: const Size(48, 48),
          textStyle: const TextStyle(color: Color(0xFFF2C94C), fontFamily: 'Gilroy', fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xFFF2C94C),
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w600, fontSize: 10),
        unselectedLabelStyle: TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w600, fontSize: 10),
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFF2C94C),
        onPrimary: Color(0xFF333333),
        secondary: Color(0xFF8C1D18),
        onSecondary: Colors.white,
        error: Color(0xFFE76F51),
        onError: Colors.white,
        surface: Color(0xFF242A32),
        onSurface: Colors.white,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
    );
  }
}
