import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

/// Styles de texte et de thème réutilisables dans toute l'application
class AppStyles {
  // TextStyles pour iOS-like typography
  
  // Large Display
  static TextStyle displayLarge(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeDisplayLarge,
      fontWeight: FontWeight.w100, // Ultra light pour les grands titres iOS
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: -0.5,
    );
  }
  
  // Display Medium
  static TextStyle displayMedium(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeDisplayMedium,
      fontWeight: FontWeight.w300,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: -0.25,
    );
  }
  
  // Display Small
  static TextStyle displaySmall(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeDisplaySmall,
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
    );
  }
  
  // Headline Large (pour les titres de page)
  static TextStyle headlineLarge(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeXXXLarge,
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: 0.25,
    );
  }
  
  // Headline Medium
  static TextStyle headlineMedium(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeXXLarge,
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
    );
  }
  
  // Headline Small
  static TextStyle headlineSmall(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeXLarge,
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
    );
  }
  
  // Title Large
  static TextStyle titleLarge(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeLarge,
      fontWeight: FontWeight.w500,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: 0.15,
    );
  }
  
  // Title Medium (pour les sous-titres)
  static TextStyle titleMedium(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeMedium,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondaryLight,
      letterSpacing: 0.1,
    );
  }
  
  // Title Small
  static TextStyle titleSmall(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeSmall,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondaryLight,
      letterSpacing: 0.1,
    );
  }
  
  // Body Large (texte principal)
  static TextStyle bodyLarge(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeMedium,
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: 0.5,
      height: AppDimensions.lineHeightLoose,
    );
  }
  
  // Body Medium
  static TextStyle bodyMedium(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeSmall,
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: 0.25,
      height: AppDimensions.lineHeightMedium,
    );
  }
  
  // Body Small
  static TextStyle bodySmall(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeMicro,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryLight,
      letterSpacing: 0.4,
    );
  }
  
  // Label Large (pour les boutons)
  static TextStyle labelLarge(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeMedium,
      fontWeight: FontWeight.w500,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: 0.5,
    );
  }
  
  // Label Medium
  static TextStyle labelMedium(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeSmall,
      fontWeight: FontWeight.w500,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: 0.5,
    );
  }
  
  // Label Small
  static TextStyle labelSmall(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeMicro,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondaryLight,
      letterSpacing: 0.5,
    );
  }
  
  // Styles spécifiques à l'application
  
  // Style pour la date du jour
  static TextStyle todayDateStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeXXXLarge,
      fontWeight: FontWeight.w300, // Light comme iOS
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: -0.5,
    );
  }
  
  // Style pour le nom du jour
  static TextStyle dayNameStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeLarge,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryLight,
      letterSpacing: 0.25,
    );
  }
  
  // Style pour le statut du jour (Bon/Mauvais/Neutre)
  static TextStyle dayStatusStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeXLarge,
      fontWeight: FontWeight.w500,
      color: AppColors.adaptiveTextPrimary(context),
    );
  }
  
  // Style pour les cellules du calendrier
  static TextStyle calendarCellStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeSmall,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    );
  }
  
  // Style pour les en-têtes de calendrier
  static TextStyle calendarHeaderStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeSmall,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondaryLight,
      letterSpacing: 0.5,
    );
  }
  
  // Style pour les statistiques
  static TextStyle statsTitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeLarge,
      fontWeight: FontWeight.w600,
      color: AppColors.adaptiveTextPrimary(context),
    );
  }
  
  static TextStyle statsValueStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeXXLarge,
      fontWeight: FontWeight.w300,
      color: AppColors.adaptiveTextPrimary(context),
    );
  }
  
  static TextStyle statsLabelStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeSmall,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryLight,
    );
  }
  
  // Style pour les pourcentages
  static TextStyle percentageStyle(BuildContext context, double percentage) {
    Color color;
    if (percentage >= 70) {
      color = AppColors.goodDay;
    } else if (percentage >= 40) {
      color = AppColors.systemYellow;
    } else {
      color = AppColors.badDay;
    }
    
    return TextStyle(
      fontSize: AppDimensions.fontSizeLarge,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }
  
  // Style pour les messages annuels
  static TextStyle yearMessageStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeLarge,
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
      height: AppDimensions.lineHeightVeryLoose,
    );
  }
  
  // Style pour les boutons d'action
  static TextStyle actionButtonStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeMedium,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
    );
  }
  
  // Style pour les tooltips
  static TextStyle tooltipStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeMicro,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark,
    );
  }
  
  // Style pour les messages d'erreur
  static TextStyle errorStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeMedium,
      fontWeight: FontWeight.w400,
      color: AppColors.badDay,
    );
  }
  
  // Style pour les messages de succès
  static TextStyle successStyle(BuildContext context) {
    return TextStyle(
      fontSize: AppDimensions.fontSizeMedium,
      fontWeight: FontWeight.w400,
      color: AppColors.goodDay,
    );
  }
  
  // Décorations de boîtes
  
  // Décoration pour les cartes
  static BoxDecoration cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: AppColors.adaptiveSurface(context),
      borderRadius: AppDimensions.borderRadiusAll(AppDimensions.borderRadiusLarge),
      boxShadow: [
        BoxShadow(
          color: AppColors.adaptive(
            light: Colors.black.withOpacity(0.05),
            dark: Colors.black.withOpacity(0.2),
            context: context,
          ),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
  
  // Décoration pour les boutons de statut
  static BoxDecoration statusButtonDecoration(
    BuildContext context, 
    int value, 
    bool isSelected,
  ) {
    final color = AppColors.getStatusColor(value);
    
    return BoxDecoration(
      color: isSelected ? color : color.withOpacity(0.1),
      shape: BoxShape.circle,
      border: Border.all(
        color: color,
        width: isSelected ? AppDimensions.borderWidthThick : AppDimensions.borderWidthNormal,
      ),
    );
  }
  
  // Décoration pour les cellules de jour
  static BoxDecoration dayCellDecoration(
    BuildContext context, 
    int value, 
    bool isToday,
  ) {
    final color = AppColors.getStatusColor(value);
    
    return BoxDecoration(
      color: value != 0 ? color : Colors.transparent,
      shape: BoxShape.circle,
      border: Border.all(
        color: isToday ? AppColors.accentBlue : Colors.transparent,
        width: AppDimensions.borderWidthThick,
      ),
    );
  }
  
  // Décoration pour les cellules de mois
  static BoxDecoration monthCellDecoration(BuildContext context) {
    return BoxDecoration(
      color: AppColors.adaptiveSurface(context),
      borderRadius: AppDimensions.borderRadiusAll(AppDimensions.borderRadiusMedium),
      border: Border.all(
        color: AppColors.adaptiveSeparator(context),
        width: AppDimensions.borderWidthNormal,
      ),
    );
  }
  
  // Décoration pour les indicateurs de statut
  static BoxDecoration statusIndicatorDecoration(BuildContext context, int value) {
    final color = AppColors.getStatusColor(value);
    
    return BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.3),
          blurRadius: 8,
          spreadRadius: 2,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
  
  // InputDecoration pour les champs de texte
  static InputDecoration textFieldDecoration(
    BuildContext context, {
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool hasError = false,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: AppDimensions.borderRadiusAll(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: hasError ? AppColors.badDay : AppColors.adaptiveSeparator(context),
          width: AppDimensions.borderWidthNormal,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppDimensions.borderRadiusAll(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.adaptiveSeparator(context),
          width: AppDimensions.borderWidthNormal,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppDimensions.borderRadiusAll(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.accentBlue,
          width: AppDimensions.borderWidthThick,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppDimensions.borderRadiusAll(AppDimensions.borderRadiusMedium),
        borderSide: BorderSide(
          color: AppColors.badDay,
          width: AppDimensions.borderWidthNormal,
        ),
      ),
      contentPadding: AppDimensions.paddingAllMedium,
      filled: true,
      fillColor: AppColors.adaptiveSurface(context),
    );
  }
  
  // Style pour les séparateurs
  static DividerThemeData dividerTheme(BuildContext context) {
    return DividerThemeData(
      color: AppColors.adaptiveSeparator(context),
      thickness: AppDimensions.borderWidthThin,
      space: AppDimensions.spacingMedium,
    );
  }
  
  // Configuration du thème pour les boutons
  static ButtonStyle primaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.accentBlue,
      foregroundColor: Colors.white,
      padding: AppDimensions.paddingAllMedium,
      minimumSize: const Size(AppDimensions.buttonMinWidth, AppDimensions.buttonHeightMedium),
      shape: RoundedRectangleBorder(
        borderRadius: AppDimensions.borderRadiusAll(AppDimensions.borderRadiusMedium),
      ),
      elevation: AppDimensions.elevationNone,
      textStyle: actionButtonStyle(context),
    );
  }
  
  static ButtonStyle secondaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.adaptiveSurface(context),
      foregroundColor: AppColors.adaptiveTextPrimary(context),
      padding: AppDimensions.paddingAllMedium,
      minimumSize: const Size(AppDimensions.buttonMinWidth, AppDimensions.buttonHeightMedium),
      shape: RoundedRectangleBorder(
        borderRadius: AppDimensions.borderRadiusAll(AppDimensions.borderRadiusMedium),
        side: BorderSide(
          color: AppColors.adaptiveSeparator(context),
          width: AppDimensions.borderWidthNormal,
        ),
      ),
      elevation: AppDimensions.elevationNone,
      textStyle: actionButtonStyle(context),
    );
  }
  
  static ButtonStyle textButtonStyle(BuildContext context) {
    return TextButton.styleFrom(
      foregroundColor: AppColors.accentBlue,
      padding: AppDimensions.paddingAllSmall,
      minimumSize: const Size(AppDimensions.buttonMinWidth, AppDimensions.buttonHeightSmall),
      shape: RoundedRectangleBorder(
        borderRadius: AppDimensions.borderRadiusAll(AppDimensions.borderRadiusMedium),
      ),
      textStyle: actionButtonStyle(context),
    );
  }
  
  // Animation curves pour une sensation iOS
  static Curve iosAnimationCurve = Curves.easeInOutCubic;
  static Duration iosAnimationDuration = const Duration(milliseconds: 300);
}