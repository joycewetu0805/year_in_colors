import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_theme.dart';

/// Gestionnaire de thème avec support de persistance et changement dynamique
class ThemeManager with ChangeNotifier {
  static const String _themePreferenceKey = 'app_theme_preference';
  
  ThemeMode _themeMode = ThemeMode.system;
  late SharedPreferences _prefs;
  
  ThemeManager() {
    _loadThemePreference();
  }
  
  ThemeMode get themeMode => _themeMode;
  
  /// Charger la préférence de thème depuis le stockage local
  Future<void> _loadThemePreference() async {
    _prefs = await SharedPreferences.getInstance();
    final savedTheme = _prefs.getString(_themePreferenceKey);
    
    if (savedTheme != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedTheme,
        orElse: () => ThemeMode.system,
      );
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }
  
  /// Sauvegarder la préférence de thème
  Future<void> _saveThemePreference() async {
    await _prefs.setString(_themePreferenceKey, _themeMode.toString());
  }
  
  /// Changer le thème
  Future<void> setThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    await _saveThemePreference();
    notifyListeners();
  }
  
  /// Basculer entre clair et sombre
  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.system) {
      // Si le thème est système, on détermine le thème actuel
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      _themeMode = brightness == Brightness.light ? ThemeMode.dark : ThemeMode.light;
    } else if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    await _saveThemePreference();
    notifyListeners();
  }
  
  /// Réinitialiser au thème système
  Future<void> resetToSystem() async {
    _themeMode = ThemeMode.system;
    await _saveThemePreference();
    notifyListeners();
  }
  
  /// Obtenir le ThemeData basé sur le mode actuel
  ThemeData getCurrentTheme(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return AppTheme.lightTheme;
      case ThemeMode.dark:
        return AppTheme.darkTheme;
      case ThemeMode.system:
      default:
        final brightness = MediaQuery.of(context).platformBrightness;
        return brightness == Brightness.dark ? AppTheme.darkTheme : AppTheme.lightTheme;
    }
  }
  
  /// Vérifier si le thème est en mode sombre
  bool isDarkMode(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
      default:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }
  
  /// Obtenir le nom du thème actuel pour l'affichage
  String getThemeName() {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Clair';
      case ThemeMode.dark:
        return 'Sombre';
      case ThemeMode.system:
      default:
        return 'Système';
    }
  }
  
  /// Obtenir l'icône du thème actuel
  IconData getThemeIcon() {
    switch (_themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
      default:
        return Icons.brightness_auto;
    }
  }
}