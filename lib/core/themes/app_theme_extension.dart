import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import 'app_theme.dart';

/// Extensions personnalisées pour le thème de l'application

// Extension pour accéder aux couleurs personnalisées via ThemeData
extension AppThemeExtension on ThemeData {
  // Couleurs d'état pour les jours
  Color get goodDayColor => AppColors.goodDay;
  Color get badDayColor => AppColors.badDay;
  Color get neutralDayColor => AppColors.neutralDay;

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
  Color get adaptivePrimaryText => AppTheme.primaryTextColor(this);

  // Vérifications
  bool get isDarkTheme => AppTheme.isDark(this);

  // Dimensions
  double get dayCellSize => AppDimensions.getDayCellSize(this);
  EdgeInsets get screenPadding => EdgeInsets.all(AppDimensions.getResponsivePadding(this));

  // Méthodes utilitaires
  Color getDayStatusColor(int value) {
    switch (value) {
      case 1: return goodDayColor;
      case -1: return badDayColor;
      default: return neutralDayColor;
    }
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
