import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:design_system/theme/extensions/classic_movies_app_theme_extension.dart';

class ClassicMoviesAppTheme {
  static ThemeData get theme {
    final themeExtension = ClassicMoviesAppThemeExtension.light;
    
    return ThemeData(
      useMaterial3: false,
      fontFamily: 'Gilroy',
      brightness: Brightness.light,
      primaryColor: themeExtension.primaryYellow,
      canvasColor: themeExtension.canvasLight,
      scaffoldBackgroundColor: themeExtension.scaffoldBackground,
      appBarTheme: AppBarTheme(
        color: themeExtension.scaffoldBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: themeExtension.primaryYellow, size: 24),
        titleTextStyle: TextStyle(
          color: themeExtension.textLight, 
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          fontSize: 16
        ),
      ),
      cardTheme: CardTheme(
        color: themeExtension.cardBackground,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)), 
          side: BorderSide(color: themeExtension.border, width: 1)
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: themeExtension.tabIndicator, width: 4), 
          insets: const EdgeInsets.symmetric(horizontal: 16)
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
        titleLarge: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: themeExtension.primaryYellow,
          foregroundColor: themeExtension.textDark,
          minimumSize: kIsWeb ? const Size(56, 48) : const Size(48, 48),
          elevation: 2,
          textStyle: TextStyle(
            color: themeExtension.textDark, 
            fontFamily: 'Gilroy', 
            fontWeight: FontWeight.w600, 
            fontSize: 16
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: themeExtension.primaryYellow,
          side: BorderSide(color: themeExtension.primaryYellow, width: 2),
          minimumSize: kIsWeb ? const Size(56, 48) : const Size(48, 48),
          textStyle: TextStyle(
            color: themeExtension.primaryYellow, 
            fontFamily: 'Gilroy', 
            fontWeight: FontWeight.w600, 
            fontSize: 16
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: themeExtension.primaryYellow,
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: TextStyle(
            color: themeExtension.primaryYellow, 
            fontFamily: 'Gilroy', 
            fontWeight: FontWeight.w600, 
            fontSize: 16
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(right: 24, left: 24, top: 16, bottom: 16),
        filled: true,
        fillColor: themeExtension.inputFillBackground,
        floatingLabelStyle: TextStyle(
          fontSize: 14, 
          height: 1.2, 
          fontWeight: FontWeight.bold, 
          color: themeExtension.primaryYellow
        ),
        labelStyle: TextStyle(
          fontSize: 14, 
          height: 1.2, 
          fontWeight: FontWeight.w400, 
          color: themeExtension.primaryYellow
        ),
        hintStyle: TextStyle(
          fontSize: 14, 
          height: 1.2, 
          fontWeight: FontWeight.w400, 
          color: themeExtension.hintText
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), 
          borderSide: BorderSide(color: themeExtension.border)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), 
          borderSide: BorderSide(color: themeExtension.primaryYellow, width: 2)
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), 
          borderSide: BorderSide(color: themeExtension.secondary, width: 2)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), 
          borderSide: BorderSide(color: themeExtension.border)
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(24), topLeft: Radius.circular(24))
        ),
        backgroundColor: themeExtension.cardBackground,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: themeExtension.inputFillBackground,
        disabledColor: themeExtension.border,
        selectedColor: themeExtension.primaryYellow,
        secondarySelectedColor: themeExtension.primaryYellow,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: const TextStyle(color: Colors.white, fontFamily: 'Gilroy', fontWeight: FontWeight.w500),
        secondaryLabelStyle: TextStyle(color: themeExtension.textDark, fontFamily: 'Gilroy', fontWeight: FontWeight.w700),
        brightness: Brightness.dark,
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: themeExtension.primaryYellow,
        onPrimary: themeExtension.textDark,
        secondary: themeExtension.secondary,
        onSecondary: Colors.white,
        error: themeExtension.error,
        onError: Colors.white,
        surface: themeExtension.scaffoldBackground,
        onSurface: Colors.white,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
      extensions: [themeExtension],
    );
  }

  static ThemeData get darkTheme {
    final themeExtension = ClassicMoviesAppThemeExtension.dark;
    
    return ThemeData(
      useMaterial3: false,
      fontFamily: 'Gilroy',
      brightness: Brightness.dark,
      primaryColor: themeExtension.primaryYellow,
      canvasColor: Colors.black,
      scaffoldBackgroundColor: themeExtension.scaffoldBackground,
      appBarTheme: AppBarTheme(
        color: themeExtension.scaffoldBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: themeExtension.primaryYellow, size: 24),
        titleTextStyle: TextStyle(
          color: themeExtension.textLight, 
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          fontSize: 16
        ),
      ),
      cardTheme: CardTheme(
        color: themeExtension.cardBackground,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)), 
          side: BorderSide(color: themeExtension.border, width: 1)
        ),
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
        titleLarge: TextStyle(color: Colors.white, fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: themeExtension.primaryYellow,
          foregroundColor: themeExtension.textDark,
          minimumSize: kIsWeb ? const Size(56, 48) : const Size(48, 48),
          elevation: 2,
          textStyle: TextStyle(
            color: themeExtension.textDark, 
            fontFamily: 'Gilroy', 
            fontWeight: FontWeight.w600, 
            fontSize: 16
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: Colors.white,
          side: BorderSide(color: themeExtension.textDark, width: 1),
          minimumSize: const Size(48, 48),
          textStyle: const TextStyle(
            color: Colors.white,
            fontFamily: 'Gilroy', 
            fontWeight: FontWeight.w500, 
            fontSize: 16
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: themeExtension.primaryYellow,
          minimumSize: const Size(48, 48),
          textStyle: TextStyle(
            color: themeExtension.primaryYellow, 
            fontFamily: 'Gilroy', 
            fontWeight: FontWeight.w600, 
            fontSize: 14
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: themeExtension.primaryYellow,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w600, fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w600, fontSize: 10),
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: themeExtension.primaryYellow,
        onPrimary: themeExtension.textDark,
        secondary: themeExtension.secondary,
        onSecondary: Colors.white,
        error: themeExtension.error,
        onError: Colors.white,
        surface: themeExtension.scaffoldBackground,
        onSurface: Colors.white,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
      extensions: [themeExtension],
    );
  }
}
