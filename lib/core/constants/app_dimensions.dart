import 'package:flutter/material.dart';

/// Constantes de dimensions, espacements et tailles pour une cohérence visuelle
class AppDimensions {
  // Espacements
  static const double spacingMicro = 2.0;
  static const double spacingTiny = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 12.0;
  static const double spacingLarge = 16.0;
  static const double spacingXLarge = 24.0;
  static const double spacingXXLarge = 32.0;
  static const double spacingXXXLarge = 48.0;
  static const double spacingJumbo = 64.0;
  
  // Bordures
  static const double borderWidthThin = 0.5;
  static const double borderWidthNormal = 1.0;
  static const double borderWidthThick = 2.0;
  static const double borderWidthExtraThick = 3.0;
  
  // Rayons de bordure
  static const double borderRadiusMicro = 4.0;
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusXLarge = 24.0;
  static const double borderRadiusCircle = 999.0; // Pour les cercles
  
  // Tailles d'icônes
  static const double iconSizeMicro = 12.0;
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 48.0;
  static const double iconSizeXXLarge = 64.0;
  
  // Tailles de texte
  static const double fontSizeMicro = 10.0;
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeXLarge = 18.0;
  static const double fontSizeXXLarge = 20.0;
  static const double fontSizeXXXLarge = 24.0;
  static const double fontSizeDisplaySmall = 32.0;
  static const double fontSizeDisplayMedium = 40.0;
  static const double fontSizeDisplayLarge = 48.0;
  
  // Hauteurs de ligne
  static const double lineHeightTight = 1.0;
  static const double lineHeightMedium = 1.2;
  static const double lineHeightLoose = 1.5;
  static const double lineHeightVeryLoose = 1.8;
  
  // Hauteurs de widgets
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightMedium = 44.0;
  static const double buttonHeightLarge = 52.0;
  static const double appBarHeight = 56.0;
  static const double bottomNavBarHeight = 80.0;
  static const double tabBarHeight = 48.0;
  static const double listTileHeight = 56.0;
  static const double listTileHeightDense = 40.0;
  
  // Largeurs de widgets
  static const double buttonMinWidth = 88.0;
  static const double dialogWidth = 280.0;
  static const double drawerWidth = 304.0;
  static const double sidebarWidth = 240.0;
  
  // Tailles d'éléments spécifiques
  static const double dayCellSize = 36.0;
  static const double dayCellSizeLarge = 44.0;
  static const double monthCellWidth = 100.0;
  static const double monthCellHeight = 80.0;
  static const double calendarHeaderHeight = 40.0;
  static const double statsCardHeight = 120.0;
  static const double statusIndicatorSize = 60.0;
  static const double statusButtonSize = 70.0;
  
  // Opacités
  static const double opacityDisabled = 0.38;
  static const double opacityMedium = 0.60;
  static const double opacityHigh = 0.87;
  static const double opacityFull = 1.0;
  
  // Durées d'animation (en millisecondes)
  static const int animationDurationFast = 150;
  static const int animationDurationMedium = 300;
  static const int animationDurationSlow = 500;
  static const int animationDurationPageTransition = 250;
  static const int animationDurationSnackbar = 4000;
  static const int animationDurationTooltip = 1500;
  
  // Élévations
  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationXHigh = 16.0;
  
  // Padding
  static const EdgeInsets paddingNone = EdgeInsets.zero;
  static const EdgeInsets paddingAllMicro = EdgeInsets.all(spacingMicro);
  static const EdgeInsets paddingAllTiny = EdgeInsets.all(spacingTiny);
  static const EdgeInsets paddingAllSmall = EdgeInsets.all(spacingSmall);
  static const EdgeInsets paddingAllMedium = EdgeInsets.all(spacingMedium);
  static const EdgeInsets paddingAllLarge = EdgeInsets.all(spacingLarge);
  static const EdgeInsets paddingAllXLarge = EdgeInsets.all(spacingXLarge);
  
  static const EdgeInsets paddingHorizontalSmall = EdgeInsets.symmetric(horizontal: spacingSmall);
  static const EdgeInsets paddingHorizontalMedium = EdgeInsets.symmetric(horizontal: spacingMedium);
  static const EdgeInsets paddingHorizontalLarge = EdgeInsets.symmetric(horizontal: spacingLarge);
  
  static const EdgeInsets paddingVerticalSmall = EdgeInsets.symmetric(vertical: spacingSmall);
  static const EdgeInsets paddingVerticalMedium = EdgeInsets.symmetric(vertical: spacingMedium);
  static const EdgeInsets paddingVerticalLarge = EdgeInsets.symmetric(vertical: spacingLarge);
  
  static const EdgeInsets paddingScreen = EdgeInsets.all(spacingLarge);
  static const EdgeInsets paddingScreenHorizontal = EdgeInsets.symmetric(horizontal: spacingLarge);
  static const EdgeInsets paddingScreenVertical = EdgeInsets.symmetric(vertical: spacingLarge);
  
  // Margin
  static const EdgeInsets marginNone = EdgeInsets.zero;
  static const EdgeInsets marginAllSmall = EdgeInsets.all(spacingSmall);
  static const EdgeInsets marginAllMedium = EdgeInsets.all(spacingMedium);
  static const EdgeInsets marginAllLarge = EdgeInsets.all(spacingLarge);
  
  static const EdgeInsets marginBottomSmall = EdgeInsets.only(bottom: spacingSmall);
  static const EdgeInsets marginBottomMedium = EdgeInsets.only(bottom: spacingMedium);
  static const EdgeInsets marginBottomLarge = EdgeInsets.only(bottom: spacingLarge);
  
  static const EdgeInsets marginTopSmall = EdgeInsets.only(top: spacingSmall);
  static const EdgeInsets marginTopMedium = EdgeInsets.only(top: spacingMedium);
  static const EdgeInsets marginTopLarge = EdgeInsets.only(top: spacingLarge);
  
  // Tailles de médias queries (breakpoints)
  static const double breakpointMobile = 600.0;
  static const double breakpointTablet = 900.0;
  static const double breakpointDesktop = 1200.0;
  
  // Dimensions du calendrier
  static const int calendarDaysPerWeek = 7;
  static const int calendarWeeksPerMonth = 6; // Maximum
  static const int calendarTotalCells = calendarDaysPerWeek * calendarWeeksPerMonth;
  static const int monthsPerYear = 12;
  static const int daysPerYear = 365;
  
  // Dimensions de la grille annuelle
  static const int yearGridColumns = 4;
  static const int yearGridRows = 3;
  
  // Z-index
  static const int zIndexBottom = 0;
  static const int zIndexMiddle = 1;
  static const int zIndexTop = 2;
  static const int zIndexOverlay = 1000;
  static const int zIndexModal = 2000;
  static const int zIndexToast = 3000;
  
  // Dimensions responsives
  static double getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < breakpointMobile) {
      return spacingMedium;
    } else if (width < breakpointTablet) {
      return spacingLarge;
    } else {
      return spacingXLarge;
    }
  }
  
  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width > breakpointDesktop) {
      return baseSize * 1.2;
    } else if (width < breakpointMobile) {
      return baseSize * 0.9;
    }
    return baseSize;
  }
  
  static double getDayCellSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final availableWidth = width - (2 * spacingLarge);
    final cellSize = availableWidth / calendarDaysPerWeek - spacingSmall;
    return cellSize.clamp(dayCellSize, dayCellSizeLarge);
  }
  
  // Méthode utilitaire pour créer un BorderRadius
  static BorderRadius borderRadiusAll(double radius) {
    return BorderRadius.all(Radius.circular(radius));
  }
  
  static BorderRadius borderRadiusTop(double radius) {
    return BorderRadius.vertical(top: Radius.circular(radius));
  }
  
  static BorderRadius borderRadiusBottom(double radius) {
    return BorderRadius.vertical(bottom: Radius.circular(radius));
  }
  
  static BorderRadius borderRadiusLeft(double radius) {
    return BorderRadius.horizontal(left: Radius.circular(radius));
  }
  
  static BorderRadius borderRadiusRight(double radius) {
    return BorderRadius.horizontal(right: Radius.circular(radius));
  }
}