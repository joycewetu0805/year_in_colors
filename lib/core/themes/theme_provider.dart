import 'package:flutter/material.dart';
import 'theme_manager.dart';

/// Provider pour injecter le gestionnaire de thème dans l'arbre widget
class ThemeProvider extends InheritedWidget {
  final ThemeManager themeManager;
  
  const ThemeProvider({
    Key? key,
    required this.themeManager,
    required Widget child,
  }) : super(key: key, child: child);
  
  static ThemeManager of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ThemeProvider>();
    if (provider == null) {
      throw FlutterError('ThemeProvider not found in the widget tree');
    }
    return provider.themeManager;
  }
  
  @override
  bool updateShouldNotify(ThemeProvider oldWidget) {
    return themeManager != oldWidget.themeManager;
  }
}

/// Hook personnalisé pour accéder facilement au gestionnaire de thème
ThemeManager useTheme(BuildContext context) {
  return ThemeProvider.of(context);
}

/// Hook personnalisé pour accéder au ThemeData actuel
ThemeData useAppTheme(BuildContext context) {
  final themeManager = ThemeProvider.of(context);
  return themeManager.getCurrentTheme(context);
}

/// Hook personnalisé pour vérifier si le thème est sombre
bool useIsDarkMode(BuildContext context) {
  final themeManager = ThemeProvider.of(context);
  return themeManager.isDarkMode(context);
}