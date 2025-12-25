import 'package:flutter/material.dart';

/// Palette de couleurs principale - Minimaliste noir & blanc avec couleurs d'état douces
class AppColors {
  // Couleurs d'état principales
  static const Color goodDay = Color(0xFF34C759); // Vert iOS doux
  static const Color badDay = Color(0xFFFF3B30);  // Rouge iOS doux
  static const Color neutralDay = Color(0xFF8E8E93); // Gris iOS clair
  
  // Variantes des couleurs d'état
  static const Color goodDayLight = Color(0xFFDDF7E3);
  static const Color goodDayDark = Color(0xFF1D5B2A);
  static const Color badDayLight = Color(0xFFFFE5E5);
  static const Color badDayDark = Color(0xFF7A1C1C);
  static const Color neutralDayLight = Color(0xFFF2F2F7);
  static const Color neutralDayDark = Color(0xFF3A3A3C);
  
  // Couleurs de fond
  static const Color backgroundLight = Colors.white;
  static const Color backgroundDark = Color(0xFF000000);
  static const Color surfaceLight = Color(0xFFF2F2F7);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color elevatedSurfaceLight = Color(0xFFFFFFFF);
  static const Color elevatedSurfaceDark = Color(0xFF2C2C2E);
  
  // Couleurs de texte
  static const Color textPrimaryLight = Color(0xFF000000);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryLight = Color(0xFF8E8E93);
  static const Color textSecondaryDark = Color(0xFF8E8E93);
  static const Color textTertiaryLight = Color(0xFFC7C7CC);
  static const Color textTertiaryDark = Color(0xFF48484A);
  
  // Couleurs d'accent et d'interaction
  static const Color accentBlue = Color(0xFF007AFF);
  static const Color accentBlueLight = Color(0xFFD0E7FF);
  static const Color separatorLight = Color(0xFFC6C6C8);
  static const Color separatorDark = Color(0xFF38383A);
  static const Color overlayLight = Color.fromRGBO(0, 0, 0, 0.1);
  static const Color overlayDark = Color.fromRGBO(255, 255, 255, 0.1);
  
  // Couleurs de système
  static const Color systemRed = Color(0xFFFF3B30);
  static const Color systemOrange = Color(0xFFFF9500);
  static const Color systemYellow = Color(0xFFFFCC00);
  static const Color systemGreen = Color(0xFF34C759);
  static const Color systemTeal = Color(0xFF5AC8FA);
  static const Color systemBlue = Color(0xFF007AFF);
  static const Color systemIndigo = Color(0xFF5856D6);
  static const Color systemPurple = Color(0xFFAF52DE);
  static const Color systemPink = Color(0xFFFF2D55);
  
  // Couleurs de feedback
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
  static const Color error = Color(0xFFFF3B30);
  static const Color info = Color(0xFF007AFF);
  
  // Couleurs de graphiques (pour les statistiques)
  static const List<Color> chartColors = [
    Color(0xFF34C759), // Vert - Bons jours
    Color(0xFFFF3B30), // Rouge - Mauvais jours
    Color(0xFF8E8E93), // Gris - Neutres
    Color(0xFF007AFF), // Bleu - Remplis
    Color(0xFFFF9500), // Orange - Non remplis
  ];
  
  // Dégradés
  static const LinearGradient goodGradient = LinearGradient(
    colors: [Color(0xFF34C759), Color(0xFF4CD964)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient badGradient = LinearGradient(
    colors: [Color(0xFFFF3B30), Color(0xFFFF453A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Couleurs avec opacité
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
  
  // Méthode pour obtenir la couleur adaptée au thème
  static Color adaptive({
    required Color light,
    required Color dark,
    required BuildContext context,
  }) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.light ? light : dark;
  }
  
  // Couleur adaptative pour le fond
  static Color adaptiveBackground(BuildContext context) {
    return adaptive(
      light: backgroundLight,
      dark: backgroundDark,
      context: context,
    );
  }
  
  // Couleur adaptative pour la surface
  static Color adaptiveSurface(BuildContext context) {
    return adaptive(
      light: surfaceLight,
      dark: surfaceDark,
      context: context,
    );
  }
  
  // Couleur adaptative pour le texte primaire
  static Color adaptiveTextPrimary(BuildContext context) {
    return adaptive(
      light: textPrimaryLight,
      dark: textPrimaryDark,
      context: context,
    );
  }
  
  // Couleur adaptative pour le séparateur
  static Color adaptiveSeparator(BuildContext context) {
    return adaptive(
      light: separatorLight,
      dark: separatorDark,
      context: context,
    );
  }
}