import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_styles.dart';

/// Thème principal de l'application avec support iOS-first et mode clair/sombre
class AppTheme {
  /// Thème clair - Minimaliste, inspiré iOS
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      // Couleurs principales
      primary: Color(0xFF000000),
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFF2F2F7),
      onPrimaryContainer: Color(0xFF000000),
      
      // Couleurs secondaires
      secondary: AppColors.accentBlue,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.accentBlueLight,
      onSecondaryContainer: AppColors.accentBlue,
      
      // Couleurs de surface
      background: AppColors.backgroundLight,
      onBackground: AppColors.textPrimaryLight,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimaryLight,
      surfaceVariant: AppColors.elevatedSurfaceLight,
      onSurfaceVariant: AppColors.textSecondaryLight,
      
      // Couleurs d'erreur
      error: AppColors.badDay,
      onError: Colors.white,
      errorContainer: AppColors.badDayLight,
      onErrorContainer: AppColors.badDay,
      
      // Couleurs de succès (custom)
      tertiary: AppColors.goodDay,
      onTertiary: Colors.white,
      tertiaryContainer: AppColors.goodDayLight,
      onTertiaryContainer: AppColors.goodDay,
      
      // États
      outline: AppColors.separatorLight,
      outlineVariant: AppColors.separatorLight.withOpacity(0.5),
      shadow: AppColors.overlayLight,
      scrim: AppColors.overlayLight,
      inverseSurface: AppColors.backgroundDark,
      onInverseSurface: AppColors.textPrimaryDark,
      inversePrimary: AppColors.accentBlue,
    ),
    
    // Typographie iOS-like (SF Pro)
    typography: Typography.material2021(
      black: _buildTextTheme(Brightness.light),
      white: _buildTextTheme(Brightness.dark),
      englishLike: true,
    ),
    
    // Configuration des polices
    fontFamily: 'SF Pro Display',
    fontFamilyFallback: const [
      '-apple-system',
      'BlinkMacSystemFont',
      'Helvetica Neue',
      'Arial',
      'sans-serif'
    ],
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimaryLight,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: AppDimensions.fontSizeLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryLight,
      ),
      toolbarHeight: AppDimensions.appBarHeight,
      iconTheme: const IconThemeData(
        color: AppColors.textPrimaryLight,
        size: AppDimensions.iconSizeMedium,
      ),
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF000000),
      unselectedItemColor: Color(0xFF8E8E93),
      selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentBlue,
      foregroundColor: Colors.white,
      elevation: AppDimensions.elevationMedium,
      shape: CircleBorder(),
      sizeConstraints: BoxConstraints(
        minWidth: 56,
        minHeight: 56,
      ),
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentBlue,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.textTertiaryLight,
        disabledForegroundColor: Colors.white,
        padding: AppDimensions.paddingAllMedium,
        minimumSize: const Size(
          AppDimensions.buttonMinWidth,
          AppDimensions.buttonHeightMedium,
        ),
        elevation: AppDimensions.elevationNone,
        shadowColor: Colors.transparent,
        textStyle: TextStyle(
          fontSize: AppDimensions.fontSizeMedium,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
      ),
    ),
    
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accentBlue,
        disabledForegroundColor: AppColors.textTertiaryLight,
        padding: AppDimensions.paddingAllSmall,
        minimumSize: const Size(
          AppDimensions.buttonMinWidth,
          AppDimensions.buttonHeightSmall,
        ),
        textStyle: TextStyle(
          fontSize: AppDimensions.fontSizeMedium,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
      ),
    ),
    
    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimaryLight,
        disabledForegroundColor: AppColors.textTertiaryLight,
        side: BorderSide(
          color: AppColors.separatorLight,
          width: AppDimensions.borderWidthNormal,
        ),
        padding: AppDimensions.paddingAllMedium,
        minimumSize: const Size(
          AppDimensions.buttonMinWidth,
          AppDimensions.buttonHeightMedium,
        ),
        textStyle: TextStyle(
          fontSize: AppDimensions.fontSizeMedium,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
      ),
    ),
    
    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.elevatedSurfaceLight,
      elevation: AppDimensions.elevationLow,
      shadowColor: AppColors.overlayLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        side: BorderSide.none,
      ),
      margin: EdgeInsets.zero,
    ),
    
    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.elevatedSurfaceLight,
      elevation: AppDimensions.elevationHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusXLarge),
      ),
      titleTextStyle: TextStyle(
        fontSize: AppDimensions.fontSizeXXLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryLight,
      ),
      contentTextStyle: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryLight,
        height: AppDimensions.lineHeightLoose,
      ),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceLight,
      contentPadding: AppDimensions.paddingAllMedium,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.separatorLight,
          width: AppDimensions.borderWidthNormal,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.separatorLight,
          width: AppDimensions.borderWidthNormal,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.accentBlue,
          width: AppDimensions.borderWidthThick,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.badDay,
          width: AppDimensions.borderWidthNormal,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.badDay,
          width: AppDimensions.borderWidthThick,
        ),
      ),
      labelStyle: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryLight,
      ),
      hintStyle: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiaryLight,
      ),
      errorStyle: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: AppColors.badDay,
      ),
    ),
    
    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.accentBlue;
        }
        return AppColors.separatorLight;
      }),
      checkColor: const MaterialStatePropertyAll(Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMicro),
      ),
      side: BorderSide(
        color: AppColors.separatorLight,
        width: AppDimensions.borderWidthNormal,
      ),
    ),
    
    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.accentBlue;
        }
        return AppColors.separatorLight;
      }),
    ),
    
    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.accentBlue;
        }
        return Colors.white;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.accentBlue.withOpacity(0.5);
        }
        return AppColors.separatorLight.withOpacity(0.5);
      }),
    ),
    
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.separatorLight,
      thickness: AppDimensions.borderWidthThin,
      space: AppDimensions.spacingMedium,
    ),
    
    // Tab Bar Theme
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.textPrimaryLight,
      unselectedLabelColor: AppColors.textSecondaryLight,
      labelStyle: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w400,
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: AppColors.accentBlue,
          width: AppDimensions.borderWidthThick,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.label,
    ),
    
    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceLight,
      disabledColor: AppColors.textTertiaryLight.withOpacity(0.1),
      selectedColor: AppColors.accentBlue,
      secondarySelectedColor: AppColors.accentBlue,
      labelStyle: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryLight,
      ),
      secondaryLabelStyle: const TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      brightness: Brightness.light,
      padding: AppDimensions.paddingHorizontalSmall,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.separatorLight,
          width: AppDimensions.borderWidthNormal,
        ),
      ),
    ),
    
    // SnackBar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.elevatedSurfaceLight,
      actionTextColor: AppColors.accentBlue,
      disabledActionTextColor: AppColors.textTertiaryLight,
      contentTextStyle: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryLight,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      elevation: AppDimensions.elevationHigh,
      behavior: SnackBarBehavior.floating,
    ),
    
    // Bottom Sheet Theme
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.elevatedSurfaceLight,
      elevation: AppDimensions.elevationHigh,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.borderRadiusXLarge),
        ),
      ),
      modalBackgroundColor: AppColors.overlayLight,
      modalElevation: AppDimensions.elevationXHigh,
    ),
    
    // Tooltip Theme
    tooltipTheme: TooltipThemeData(
      height: AppDimensions.buttonHeightSmall,
      padding: AppDimensions.paddingAllSmall,
      margin: AppDimensions.paddingAllSmall,
      textStyle: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryDark,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      waitDuration: const Duration(milliseconds: 500),
      showDuration: const Duration(seconds: 2),
    ),
    
    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.accentBlue,
      linearTrackColor: AppColors.separatorLight,
      circularTrackColor: AppColors.separatorLight,
    ),
    
    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.textPrimaryLight,
      size: AppDimensions.iconSizeMedium,
    ),
    
    // Primary Icon Theme
    primaryIconTheme: const IconThemeData(
      color: Colors.white,
      size: AppDimensions.iconSizeMedium,
    ),
    
    // Badge Theme
    badgeTheme: const BadgeThemeData(
      backgroundColor: AppColors.badDay,
      textColor: Colors.white,
      smallSize: 16,
      largeSize: 24,
    ),
    
    // Page Transitions Theme (iOS-like)
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    
    // Visual Density
    visualDensity: VisualDensity.adaptivePlatformDensity,
    
    // Material Tap Target Size
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
  
  /// Thème sombre - Minimaliste, inspiré iOS Dark Mode
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      // Couleurs principales
      primary: Color(0xFFFFFFFF),
      onPrimary: Color(0xFF000000),
      primaryContainer: Color(0xFF2C2C2E),
      onPrimaryContainer: Color(0xFFFFFFFF),
      
      // Couleurs secondaires
      secondary: AppColors.accentBlue,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.accentBlue.withOpacity(0.2),
      onSecondaryContainer: AppColors.accentBlue,
      
      // Couleurs de surface
      background: AppColors.backgroundDark,
      onBackground: AppColors.textPrimaryDark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      surfaceVariant: AppColors.elevatedSurfaceDark,
      onSurfaceVariant: AppColors.textSecondaryDark,
      
      // Couleurs d'erreur
      error: AppColors.badDay,
      onError: Colors.white,
      errorContainer: AppColors.badDay.withOpacity(0.2),
      onErrorContainer: AppColors.badDay,
      
      // Couleurs de succès (custom)
      tertiary: AppColors.goodDay,
      onTertiary: Colors.white,
      tertiaryContainer: AppColors.goodDay.withOpacity(0.2),
      onTertiaryContainer: AppColors.goodDay,
      
      // États
      outline: AppColors.separatorDark,
      outlineVariant: AppColors.separatorDark.withOpacity(0.5),
      shadow: AppColors.overlayDark,
      scrim: AppColors.overlayDark,
      inverseSurface: AppColors.backgroundLight,
      onInverseSurface: AppColors.textPrimaryLight,
      inversePrimary: AppColors.accentBlue,
    ),
    
    // Typographie iOS-like (SF Pro)
    typography: Typography.material2021(
      black: _buildTextTheme(Brightness.light),
      white: _buildTextTheme(Brightness.dark),
      englishLike: true,
    ),
    
    // Configuration des polices
    fontFamily: 'SF Pro Display',
    fontFamilyFallback: const [
      '-apple-system',
      'BlinkMacSystemFont',
      'Helvetica Neue',
      'Arial',
      'sans-serif'
    ],
    
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textPrimaryDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: AppDimensions.fontSizeLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
      ),
      toolbarHeight: AppDimensions.appBarHeight,
      iconTheme: const IconThemeData(
        color: AppColors.textPrimaryDark,
        size: AppDimensions.iconSizeMedium,
      ),
    ),
    
    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF000000),
      selectedItemColor: Color(0xFFFFFFFF),
      unselectedItemColor: Color(0xFF8E8E93),
      selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    
    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.accentBlue,
      foregroundColor: Colors.white,
      elevation: AppDimensions.elevationMedium,
      shape: CircleBorder(),
      sizeConstraints: BoxConstraints(
        minWidth: 56,
        minHeight: 56,
      ),
    ),
    
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accentBlue,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppColors.textTertiaryDark,
        disabledForegroundColor: AppColors.textPrimaryDark,
        padding: AppDimensions.paddingAllMedium,
        minimumSize: const Size(
          AppDimensions.buttonMinWidth,
          AppDimensions.buttonHeightMedium,
        ),
        elevation: AppDimensions.elevationNone,
        shadowColor: Colors.transparent,
        textStyle: TextStyle(
          fontSize: AppDimensions.fontSizeMedium,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
      ),
    ),
    
    // Text Button Theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.accentBlue,
        disabledForegroundColor: AppColors.textTertiaryDark,
        padding: AppDimensions.paddingAllSmall,
        minimumSize: const Size(
          AppDimensions.buttonMinWidth,
          AppDimensions.buttonHeightSmall,
        ),
        textStyle: TextStyle(
          fontSize: AppDimensions.fontSizeMedium,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
      ),
    ),
    
    // Outlined Button Theme
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimaryDark,
        disabledForegroundColor: AppColors.textTertiaryDark,
        side: BorderSide(
          color: AppColors.separatorDark,
          width: AppDimensions.borderWidthNormal,
        ),
        padding: AppDimensions.paddingAllMedium,
        minimumSize: const Size(
          AppDimensions.buttonMinWidth,
          AppDimensions.buttonHeightMedium,
        ),
        textStyle: TextStyle(
          fontSize: AppDimensions.fontSizeMedium,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        ),
      ),
    ),
    
    // Card Theme
    cardTheme: CardTheme(
      color: AppColors.elevatedSurfaceDark,
      elevation: AppDimensions.elevationLow,
      shadowColor: AppColors.overlayDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        side: BorderSide.none,
      ),
      margin: EdgeInsets.zero,
    ),
    
    // Dialog Theme
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.elevatedSurfaceDark,
      elevation: AppDimensions.elevationHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusXLarge),
      ),
      titleTextStyle: TextStyle(
        fontSize: AppDimensions.fontSizeXXLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryDark,
      ),
      contentTextStyle: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryDark,
        height: AppDimensions.lineHeightLoose,
      ),
    ),
    
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceDark,
      contentPadding: AppDimensions.paddingAllMedium,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.separatorDark,
          width: AppDimensions.borderWidthNormal,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.separatorDark,
          width: AppDimensions.borderWidthNormal,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.accentBlue,
          width: AppDimensions.borderWidthThick,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.badDay,
          width: AppDimensions.borderWidthNormal,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.badDay,
          width: AppDimensions.borderWidthThick,
        ),
      ),
      labelStyle: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryDark,
      ),
      hintStyle: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiaryDark,
      ),
      errorStyle: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: AppColors.badDay,
      ),
    ),
    
    // Checkbox Theme
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.accentBlue;
        }
        return AppColors.separatorDark;
      }),
      checkColor: const MaterialStatePropertyAll(Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMicro),
      ),
      side: BorderSide(
        color: AppColors.separatorDark,
        width: AppDimensions.borderWidthNormal,
      ),
    ),
    
    // Radio Theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.accentBlue;
        }
        return AppColors.separatorDark;
      }),
    ),
    
    // Switch Theme
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.accentBlue;
        }
        return Colors.white;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return AppColors.accentBlue.withOpacity(0.5);
        }
        return AppColors.separatorDark.withOpacity(0.5);
      }),
    ),
    
    // Divider Theme
    dividerTheme: const DividerThemeData(
      color: AppColors.separatorDark,
      thickness: AppDimensions.borderWidthThin,
      space: AppDimensions.spacingMedium,
    ),
    
    // Tab Bar Theme
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.textPrimaryDark,
      unselectedLabelColor: AppColors.textSecondaryDark,
      labelStyle: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w400,
      ),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          color: AppColors.accentBlue,
          width: AppDimensions.borderWidthThick,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.label,
    ),
    
    // Chip Theme
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceDark,
      disabledColor: AppColors.textTertiaryDark.withOpacity(0.1),
      selectedColor: AppColors.accentBlue,
      secondarySelectedColor: AppColors.accentBlue,
      labelStyle: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryDark,
      ),
      secondaryLabelStyle: const TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      brightness: Brightness.dark,
      padding: AppDimensions.paddingHorizontalSmall,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.separatorDark,
          width: AppDimensions.borderWidthNormal,
        ),
      ),
    ),
    
    // SnackBar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.elevatedSurfaceDark,
      actionTextColor: AppColors.accentBlue,
      disabledActionTextColor: AppColors.textTertiaryDark,
      contentTextStyle: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryDark,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      elevation: AppDimensions.elevationHigh,
      behavior: SnackBarBehavior.floating,
    ),
    
    // Bottom Sheet Theme
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.elevatedSurfaceDark,
      elevation: AppDimensions.elevationHigh,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.borderRadiusXLarge),
        ),
      ),
      modalBackgroundColor: AppColors.overlayDark,
      modalElevation: AppDimensions.elevationXHigh,
    ),
    
    // Tooltip Theme
    tooltipTheme: TooltipThemeData(
      height: AppDimensions.buttonHeightSmall,
      padding: AppDimensions.paddingAllSmall,
      margin: AppDimensions.paddingAllSmall,
      textStyle: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryLight,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        boxShadow: [
          BoxShadow(
            color: AppColors.overlayDark,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      waitDuration: const Duration(milliseconds: 500),
      showDuration: const Duration(seconds: 2),
    ),
    
    // Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.accentBlue,
      linearTrackColor: AppColors.separatorDark,
      circularTrackColor: AppColors.separatorDark,
    ),
    
    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.textPrimaryDark,
      size: AppDimensions.iconSizeMedium,
    ),
    
    // Primary Icon Theme
    primaryIconTheme: const IconThemeData(
      color: Colors.black,
      size: AppDimensions.iconSizeMedium,
    ),
    
    // Badge Theme
    badgeTheme: const BadgeThemeData(
      backgroundColor: AppColors.badDay,
      textColor: Colors.white,
      smallSize: 16,
      largeSize: 24,
    ),
    
    // Page Transitions Theme (iOS-like)
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    
    // Visual Density
    visualDensity: VisualDensity.adaptivePlatformDensity,
    
    // Material Tap Target Size
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
  
  /// Thème adaptatif basé sur la luminosité du système
  static ThemeData adaptiveTheme(Brightness brightness) {
    return brightness == Brightness.light ? lightTheme : darkTheme;
  }
  
  /// Thème basé sur le mode système
  static ThemeData get systemTheme {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    return adaptiveTheme(brightness);
  }
  
  /// Construire le TextTheme cohérent avec iOS
  static TextTheme _buildTextTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final secondaryTextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    
    return TextTheme(
      // Display
      displayLarge: TextStyle(
        fontSize: AppDimensions.fontSizeDisplayLarge,
        fontWeight: FontWeight.w100,
        color: textColor,
        letterSpacing: -0.5,
      ),
      displayMedium: TextStyle(
        fontSize: AppDimensions.fontSizeDisplayMedium,
        fontWeight: FontWeight.w300,
        color: textColor,
        letterSpacing: -0.25,
      ),
      displaySmall: TextStyle(
        fontSize: AppDimensions.fontSizeDisplaySmall,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      
      // Headline
      headlineLarge: TextStyle(
        fontSize: AppDimensions.fontSizeXXXLarge,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.25,
      ),
      headlineMedium: TextStyle(
        fontSize: AppDimensions.fontSizeXXLarge,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontSize: AppDimensions.fontSizeXLarge,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      
      // Title
      titleLarge: TextStyle(
        fontSize: AppDimensions.fontSizeLarge,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.15,
      ),
      titleMedium: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
        letterSpacing: 0.1,
      ),
      titleSmall: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
        letterSpacing: 0.1,
      ),
      
      // Body
      bodyLarge: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.5,
        height: AppDimensions.lineHeightLoose,
      ),
      bodyMedium: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: textColor,
        letterSpacing: 0.25,
        height: AppDimensions.lineHeightMedium,
      ),
      bodySmall: TextStyle(
        fontSize: AppDimensions.fontSizeMicro,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
        letterSpacing: 0.4,
      ),
      
      // Label
      labelLarge: TextStyle(
        fontSize: AppDimensions.fontSizeMedium,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.5,
      ),
      labelMedium: TextStyle(
        fontSize: AppDimensions.fontSizeSmall,
        fontWeight: FontWeight.w500,
        color: textColor,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontSize: AppDimensions.fontSizeMicro,
        fontWeight: FontWeight.w500,
        color: secondaryTextColor,
        letterSpacing: 0.5,
      ),
    );
  }
  
  /// Obtenir le thème pour un contexte donné
  static ThemeData of(BuildContext context) {
    return Theme.of(context);
  }
  
  /// Vérifier si le thème actuel est sombre
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
  
  /// Obtenir la couleur de texte primaire pour le contexte actuel
  static Color primaryTextColor(BuildContext context) {
    return isDark(context) ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
  }
  
  /// Obtenir la couleur de texte secondaire pour le contexte actuel
  static Color secondaryTextColor(BuildContext context) {
    return isDark(context) ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
  }
  
  /// Obtenir la couleur de fond pour le contexte actuel
  static Color backgroundColor(BuildContext context) {
    return isDark(context) ? AppColors.backgroundDark : AppColors.backgroundLight;
  }
  
  /// Obtenir la couleur de surface pour le contexte actuel
  static Color surfaceColor(BuildContext context) {
    return isDark(context) ? AppColors.surfaceDark : AppColors.surfaceLight;
  }
  
  /// Obtenir la couleur d'accent (bleu iOS) pour le contexte actuel
  static Color accentColor(BuildContext context) {
    return AppColors.accentBlue;
  }
  
  /// Obtenir la couleur de succès (vert) pour le contexte actuel
  static Color successColor(BuildContext context) {
    return AppColors.goodDay;
  }
  
  /// Obtenir la couleur d'erreur (rouge) pour le contexte actuel
  static Color errorColor(BuildContext context) {
    return AppColors.badDay;
  }
  
  /// Obtenir la couleur neutre (gris) pour le contexte actuel
  static Color neutralColor(BuildContext context) {
    return isDark(context) ? AppColors.neutralDayDark : AppColors.neutralDayLight;
  }
}