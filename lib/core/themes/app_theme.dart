import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Thème principal de l'application - iOS-first, minimaliste
class AppTheme {
  /// Thème clair
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF000000),
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFF2F2F7),
      onPrimaryContainer: const Color(0xFF000000),
      secondary: AppColors.accentBlue,
      onSecondary: Colors.white,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimaryLight,
      error: AppColors.badDay,
      onError: Colors.white,
      tertiary: AppColors.goodDay,
      onTertiary: Colors.white,
      outline: AppColors.separatorLight,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    fontFamily: 'SF Pro Display',

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimaryLight,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryLight,
      ),
    ),

    // Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF000000),
      unselectedItemColor: Color(0xFF8E8E93),
      selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(120, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accentBlue,
      ),
    ),

    // Card
    cardTheme: CardThemeData(
      color: AppColors.elevatedSurfaceLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.zero,
    ),

    // Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.elevatedSurfaceLight,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.separatorLight,
      thickness: 0.5,
    ),

    // Progress Indicator
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.accentBlue,
    ),

    // Page Transitions (iOS-like)
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),

    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  /// Thème sombre
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFFFFFFFF),
      onPrimary: const Color(0xFF000000),
      primaryContainer: const Color(0xFF2C2C2E),
      onPrimaryContainer: const Color(0xFFFFFFFF),
      secondary: AppColors.accentBlue,
      onSecondary: Colors.white,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      error: AppColors.badDay,
      onError: Colors.white,
      tertiary: AppColors.goodDay,
      onTertiary: Colors.white,
      outline: AppColors.separatorDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    fontFamily: 'SF Pro Display',

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimaryDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
      ),
    ),

    // Bottom Navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF000000),
      selectedItemColor: Color(0xFFFFFFFF),
      unselectedItemColor: Color(0xFF8E8E93),
      selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(120, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accentBlue,
      ),
    ),

    // Card
    cardTheme: CardThemeData(
      color: AppColors.elevatedSurfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.zero,
    ),

    // Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.elevatedSurfaceDark,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.separatorDark,
      thickness: 0.5,
    ),

    // Progress Indicator
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.accentBlue,
    ),

    // Page Transitions (iOS-like)
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),

    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  /// Vérifier si le thème actuel est sombre
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Couleur de texte primaire
  static Color primaryTextColor(BuildContext context) {
    return isDark(context) ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
  }

  /// Couleur de fond
  static Color backgroundColor(BuildContext context) {
    return isDark(context) ? AppColors.backgroundDark : AppColors.backgroundLight;
  }
}
