import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import 'app_theme.dart';

/// Extensions personnalisées pour le thème de l'application
/// Permet d'accéder facilement aux couleurs et styles spécifiques à l'application

// Extension pour accéder aux couleurs personnalisées via ThemeData
extension AppThemeExtension on ThemeData {
  // Couleurs d'état pour les jours
  Color get goodDayColor => AppColors.goodDay;
  Color get badDayColor => AppColors.badDay;
  Color get neutralDayColor => AppColors.neutralDay;
  
  // Couleurs adaptatives
  Color get adaptiveBackground => AppTheme.backgroundColor(this as BuildContext);
  Color get adaptiveSurface => AppTheme.surfaceColor(this as BuildContext);
  Color get adaptivePrimaryText => AppTheme.primaryTextColor(this as BuildContext);
  Color get adaptiveSecondaryText => AppTheme.secondaryTextColor(this as BuildContext);
  
  // Styles spécifiques à l'application
  TextStyle get todayDateStyle => TextStyle(
    fontSize: AppDimensions.fontSizeXXXLarge,
    fontWeight: FontWeight.w300,
    color: AppTheme.primaryTextColor(this as BuildContext),
    letterSpacing: -0.5,
  );
  
  TextStyle get dayNameStyle => TextStyle(
    fontSize: AppDimensions.fontSizeLarge,
    fontWeight: FontWeight.w400,
    color: AppTheme.secondaryTextColor(this as BuildContext),
    letterSpacing: 0.25,
  );
  
  TextStyle get dayStatusStyle => TextStyle(
    fontSize: AppDimensions.fontSizeXLarge,
    fontWeight: FontWeight.w500,
    color: AppTheme.primaryTextColor(this as BuildContext),
  );
  
  // Méthode pour obtenir la couleur d'un jour basé sur sa valeur
  Color getDayColor(int value) {
    switch (value) {
      case 1: return goodDayColor;
      case -1: return badDayColor;
      default: return neutralDayColor;
    }
  }
}

// Extension pour BuildContext pour un accès facile au thème
extension ThemeContextExtension on BuildContext {
  ThemeData get appTheme => Theme.of(this);
  
  // Couleurs
  Color get goodDayColor => AppColors.goodDay;
  Color get badDayColor => AppColors.badDay;
  Color get neutralDayColor => AppColors.neutralDay;
  
  Color get adaptiveBackground => AppTheme.backgroundColor(this);
  Color get adaptiveSurface => AppTheme.surfaceColor(this);
  Color get adaptivePrimaryText => AppTheme.primaryTextColor(this);
  Color get adaptiveSecondaryText => AppTheme.secondaryTextColor(this);
  Color get adaptiveAccent => AppTheme.accentColor(this);
  
  // Vérifications
  bool get isDarkTheme => AppTheme.isDark(this);
  
  // Styles
  TextStyle get todayDateStyle => AppStyles.todayDateStyle(this);
  TextStyle get dayNameStyle => AppStyles.dayNameStyle(this);
  TextStyle get dayStatusStyle => AppStyles.dayStatusStyle(this);
  TextStyle get calendarCellStyle => AppStyles.calendarCellStyle(this);
  TextStyle get calendarHeaderStyle => AppStyles.calendarHeaderStyle(this);
  
  // Dimensions
  double get dayCellSize => AppDimensions.getDayCellSize(this);
  EdgeInsets get screenPadding => EdgeInsets.all(AppDimensions.getResponsivePadding(this));
  
  // Méthodes utilitaires
  Color getDayStatusColor(int value) {
    return AppThemeExtension(appTheme).getDayColor(value);
  }
  
  Color getPercentageColor(double percentage) {
    return AppStyles.percentageStyle(this, percentage).color!;
  }
  
  // Navigation
  void popWithResult<T>([T? result]) {
    Navigator.of(this).pop(result);
  }
  
  void pushNamedWithArguments(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }
}

// Extension pour ColorScheme
extension ColorSchemeExtension on ColorScheme {
  // Couleurs personnalisées pour l'application
  Color get goodDay => AppColors.goodDay;
  Color get badDay => AppColors.badDay;
  Color get neutralDay => AppColors.neutralDay;
  
  // Variantes
  Color get goodDayVariant => AppColors.goodDayLight;
  Color get badDayVariant => AppColors.badDayLight;
  Color get neutralDayVariant => AppColors.neutralDayLight;
}

// Extension pour TextTheme
extension TextThemeExtension on TextTheme {
  // Styles personnalisés pour l'application
  TextStyle get appDisplayLarge => const TextStyle(
    fontSize: AppDimensions.fontSizeDisplayLarge,
    fontWeight: FontWeight.w100,
    letterSpacing: -0.5,
  );
  
  TextStyle get appDisplayMedium => const TextStyle(
    fontSize: AppDimensions.fontSizeDisplayMedium,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.25,
  );
  
  TextStyle get appHeadlineLarge => const TextStyle(
    fontSize: AppDimensions.fontSizeXXXLarge,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );
  
  TextStyle get appTitleMedium => const TextStyle(
    fontSize: AppDimensions.fontSizeMedium,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
  
  TextStyle get appBodyLarge => const TextStyle(
    fontSize: AppDimensions.fontSizeMedium,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: AppDimensions.lineHeightLoose,
  );
  
  TextStyle get appLabelMedium => const TextStyle(
    fontSize: AppDimensions.fontSizeSmall,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
}