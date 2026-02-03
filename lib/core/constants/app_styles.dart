import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';


/// Styles de texte et de thème réutilisables dans toute l'application
class AppStyles {
  // TextStyles pour iOS-like typography
  
  // Large Display
  static TextStyle displayLarge(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('displayLarge'),
      fontWeight: FontWeight.w100, // Ultra light pour les grands titres iOS
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: -0.5,
    );
  }
  
  // Display Medium
  static TextStyle displayMedium(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('displayMedium'),
      fontWeight: FontWeight.w300,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: -0.25,
    );
  }
  
  // Display Small
  static TextStyle displaySmall(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('displaySmall'),
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
    );
  }
  
  // Headline Large (pour les titres de page)
  static TextStyle headlineLarge(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('xxxLarge'),
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: 0.25,
    );
  }
  
  // Headline Medium
  static TextStyle headlineMedium(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('xxLarge'),
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
    );
  }
  
  // Headline Small
  static TextStyle headlineSmall(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('xLarge'),
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
    );
  }
  
  // Title Large
  static TextStyle titleLarge(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('large'),
      fontWeight: FontWeight.w500,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: 0.15,
    );
  }
  
  // Title Medium (pour les sous-titres)
  static TextStyle titleMedium(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('medium'),
      fontWeight: FontWeight.w500,
      color: _getTextSecondaryColor(context),
      letterSpacing: 0.1,
    );
  }
  
  // Title Small
  static TextStyle titleSmall(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('small'),
      fontWeight: FontWeight.w500,
      color: _getTextSecondaryColor(context),
      letterSpacing: 0.1,
    );
  }
  
  // Body Large (texte principal)
  static TextStyle bodyLarge(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('medium'),
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: 0.5,
      height: 1.6,
    );
  }
  
  // Body Medium
  static TextStyle bodyMedium(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('small'),
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: 0.25,
      height: 1.5,
    );
  }
  
  // Body Small
  static TextStyle bodySmall(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('micro'),
      fontWeight: FontWeight.w400,
      color: _getTextSecondaryColor(context),
      letterSpacing: 0.4,
    );
  }
  
  // Label Large (pour les boutons)
  static TextStyle labelLarge(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('medium'),
      fontWeight: FontWeight.w500,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: 0.5,
    );
  }
  
  // Label Medium
  static TextStyle labelMedium(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('small'),
      fontWeight: FontWeight.w500,
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: 0.5,
    );
  }
  
  // Label Small
  static TextStyle labelSmall(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('micro'),
      fontWeight: FontWeight.w500,
      color: _getTextSecondaryColor(context),
      letterSpacing: 0.5,
    );
  }
  
  // Styles spécifiques à l'application
  
  // Style pour la date du jour
  static TextStyle todayDateStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('xxxLarge'),
      fontWeight: FontWeight.w300, // Light comme iOS
      color: AppColors.adaptiveTextPrimary(context),
      letterSpacing: -0.5,
    );
  }
  
  // Style pour le nom du jour
  static TextStyle dayNameStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('large'),
      fontWeight: FontWeight.w400,
      color: _getTextSecondaryColor(context),
      letterSpacing: 0.25,
    );
  }
  
  // Style pour le statut du jour (Bon/Mauvais/Neutre)
  static TextStyle dayStatusStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('xLarge'),
      fontWeight: FontWeight.w500,
      color: AppColors.adaptiveTextPrimary(context),
    );
  }
  
  // Style pour les cellules du calendrier
  static TextStyle calendarCellStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('small'),
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    );
  }
  
  // Style pour les en-têtes de calendrier
  static TextStyle calendarHeaderStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('small'),
      fontWeight: FontWeight.w500,
      color: _getTextSecondaryColor(context),
      letterSpacing: 0.5,
    );
  }
  
  // Style pour les statistiques
  static TextStyle statsTitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('large'),
      fontWeight: FontWeight.w600,
      color: AppColors.adaptiveTextPrimary(context),
    );
  }
  
  static TextStyle statsValueStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('xxLarge'),
      fontWeight: FontWeight.w300,
      color: AppColors.adaptiveTextPrimary(context),
    );
  }
  
  static TextStyle statsLabelStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('small'),
      fontWeight: FontWeight.w400,
      color: _getTextSecondaryColor(context),
    );
  }
  
  // Style pour les pourcentages
  static TextStyle percentageStyle(BuildContext context, double percentage) {
    Color color;
    if (percentage >= 70) {
      color = _getGoodDayColor();
    } else if (percentage >= 40) {
      color = _getSystemYellowColor();
    } else {
      color = _getBadDayColor();
    }
    
    return TextStyle(
      fontSize: _getFontSize('large'),
      fontWeight: FontWeight.w600,
      color: color,
    );
  }
  
  // Style pour les messages annuels
  static TextStyle yearMessageStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('large'),
      fontWeight: FontWeight.w400,
      color: AppColors.adaptiveTextPrimary(context),
      height: 1.8,
    );
  }
  
  // Style pour les boutons d'action
  static TextStyle actionButtonStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('medium'),
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
    );
  }
  
  // Style pour les tooltips
  static TextStyle tooltipStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('micro'),
      fontWeight: FontWeight.w400,
      color: _getTextPrimaryDarkColor(),
    );
  }
  
  // Style pour les messages d'erreur
  static TextStyle errorStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('medium'),
      fontWeight: FontWeight.w400,
      color: _getBadDayColor(),
    );
  }
  
  // Style pour les messages de succès
  static TextStyle successStyle(BuildContext context) {
    return TextStyle(
      fontSize: _getFontSize('medium'),
      fontWeight: FontWeight.w400,
      color: _getGoodDayColor(),
    );
  }
  
  // Décorations de boîtes
  
  // Décoration pour les cartes
  static BoxDecoration cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: _getAdaptiveSurfaceColor(context),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: _getAdaptiveShadowColor(context),
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
    final color = _getStatusColor(value);
    
    return BoxDecoration(
      color: isSelected ? color : color.withOpacity(0.1),
      shape: BoxShape.circle,
      border: Border.all(
        color: color,
        width: isSelected ? 3.0 : 1.0,
      ),
    );
  }
  
  // Décoration pour les cellules de jour
  static BoxDecoration dayCellDecoration(
    BuildContext context, 
    int value, 
    bool isToday,
  ) {
    final color = _getStatusColor(value);
    
    return BoxDecoration(
      color: value != 0 ? color : Colors.transparent,
      shape: BoxShape.circle,
      border: Border.all(
        color: isToday ? _getAccentBlueColor() : Colors.transparent,
        width: 3.0,
      ),
    );
  }
  
  // Décoration pour les cellules de mois
  static BoxDecoration monthCellDecoration(BuildContext context) {
    return BoxDecoration(
      color: _getAdaptiveSurfaceColor(context),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: _getAdaptiveSeparatorColor(context),
        width: 1.0,
      ),
    );
  }
  
  // Décoration pour les indicateurs de statut
  static BoxDecoration statusIndicatorDecoration(BuildContext context, int value) {
    final color = _getStatusColor(value);
    
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
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: hasError ? _getBadDayColor() : _getAdaptiveSeparatorColor(context),
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: _getAdaptiveSeparatorColor(context),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: _getAccentBlueColor(),
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: _getBadDayColor(),
          width: 1.0,
        ),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      filled: true,
      fillColor: _getAdaptiveSurfaceColor(context),
    );
  }
  
  // Configuration du thème pour les boutons
  static ButtonStyle primaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: _getAccentBlueColor(),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(16.0),
      minimumSize: const Size(64.0, 48.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      textStyle: actionButtonStyle(context),
    );
  }
  
  static ButtonStyle secondaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: _getAdaptiveSurfaceColor(context),
      foregroundColor: AppColors.adaptiveTextPrimary(context),
      padding: const EdgeInsets.all(16.0),
      minimumSize: const Size(64.0, 48.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: _getAdaptiveSeparatorColor(context),
          width: 1.0,
        ),
      ),
      elevation: 0,
      textStyle: actionButtonStyle(context),
    );
  }
  
  static ButtonStyle textButtonStyle(BuildContext context) {
    return TextButton.styleFrom(
      foregroundColor: _getAccentBlueColor(),
      padding: const EdgeInsets.all(12.0),
      minimumSize: const Size(64.0, 40.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      textStyle: actionButtonStyle(context),
    );
  }
  
  // Animation curves pour une sensation iOS
  static Curve iosAnimationCurve = Curves.easeInOutCubic;
  static Duration iosAnimationDuration = const Duration(milliseconds: 300);
  
  // ===== MÉTHODES D'ASSISTANCE =====
  
  // Méthode pour obtenir la taille de police
  static double _getFontSize(String sizeName) {
    switch (sizeName) {
      case 'displayLarge':
        return 57.0;
      case 'displayMedium':
        return 45.0;
      case 'displaySmall':
        return 36.0;
      case 'xxxLarge':
        return 34.0;
      case 'xxLarge':
        return 28.0;
      case 'xLarge':
        return 24.0;
      case 'large':
        return 20.0;
      case 'medium':
        return 16.0;
      case 'small':
        return 14.0;
      case 'micro':
        return 12.0;
      default:
        return 16.0;
    }
  }
  
  // Méthode pour obtenir la couleur de statut
  static Color _getStatusColor(int value) {
    if (value == 1) {
      return _getGoodDayColor();
    } else if (value == 2) {
      return _getNeutralDayColor();
    } else if (value == 3) {
      return _getBadDayColor();
    } else {
      return Colors.grey.shade300;
    }
  }
  
  // Méthode pour obtenir la couleur d'ombre adaptative
  static Color _getAdaptiveShadowColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (brightness == Brightness.light) {
      return Colors.black.withOpacity(0.05);
    } else {
      return Colors.black.withOpacity(0.2);
    }
  }
  
  // Méthodes pour obtenir les couleurs (avec fallback si AppColors n'existe pas)
  static Color _getAdaptiveSurfaceColor(BuildContext context) {
    try {
      return AppColors.adaptiveSurface(context);
    } catch (e) {
      final brightness = Theme.of(context).brightness;
      return brightness == Brightness.light 
          ? Colors.white 
          : Colors.grey.shade900;
    }
  }
  
  static Color _getAdaptiveSeparatorColor(BuildContext context) {
    try {
      return AppColors.adaptiveSeparator(context);
    } catch (e) {
      final brightness = Theme.of(context).brightness;
      return brightness == Brightness.light 
          ? Colors.grey.shade300 
          : Colors.grey.shade700;
    }
  }
  
  static Color _getTextSecondaryColor(BuildContext context) {
    try {
      return AppColors.textSecondaryLight;
    } catch (e) {
      final brightness = Theme.of(context).brightness;
      return brightness == Brightness.light 
          ? Colors.grey.shade600 
          : Colors.grey.shade400;
    }
  }
  
  static Color _getTextPrimaryDarkColor() {
    try {
      return AppColors.textPrimaryDark;
    } catch (e) {
      return Colors.grey.shade900;
    }
  }
  
  static Color _getGoodDayColor() {
    try {
      return AppColors.goodDay;
    } catch (e) {
      return const Color(0xFF34C759); // Vert iOS
    }
  }
  
  static Color _getBadDayColor() {
    try {
      return AppColors.badDay;
    } catch (e) {
      return const Color(0xFFFF3B30); // Rouge iOS
    }
  }
  
  static Color _getNeutralDayColor() {
    try {
      return AppColors.systemYellow;
    } catch (e) {
      return const Color(0xFFFFCC00); // Jaune iOS
    }
  }
  
  static Color _getSystemYellowColor() {
    try {
      return AppColors.systemYellow;
    } catch (e) {
      return const Color(0xFFFF9500); // Orange iOS
    }
  }
  
  static Color _getAccentBlueColor() {
    try {
      return AppColors.accentBlue;
    } catch (e) {
      return const Color(0xFF007AFF); // Bleu iOS
    }
  }
}