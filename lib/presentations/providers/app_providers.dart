import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/day_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/export_repository_impl.dart';
import '../../data/local_storage/day_local_storage.dart';
import '../../data/local_storage/settings_local_storage.dart';
import '../../data/local_storage/export_local_storage.dart';

/// Fournisseurs de repositories
final dayRepositoryProvider = Provider<DayRepositoryImpl>((ref) {
  return DayRepositoryImpl(
    localStorage: DayLocalStorage.getInstance(),
  );
});

final settingsRepositoryProvider = Provider<SettingsRepositoryImpl>((ref) {
  return SettingsRepositoryImpl(
    localStorage: SettingsLocalStorage.getInstance(),
  );
});

final exportRepositoryProvider = Provider<ExportRepositoryImpl>((ref) {
  return ExportRepositoryImpl(
    localStorage: ExportLocalStorage.getInstance(),
  );
});

/// Provider pour initialiser l'application
final appInitializationProvider = FutureProvider<void>((ref) async {
  // Ici on pourrait initialiser d'autres services
  await Future.delayed(const Duration(milliseconds: 500));
});

/// Provider pour gérer les erreurs globales
final errorProvider = StateProvider<String?>((ref) => null);

/// Provider pour gérer le chargement global
final loadingProvider = StateProvider<bool>((ref) => false);

/// Provider pour gérer les succès globaux
final successProvider = StateProvider<String?>((ref) => null);

/// Provider pour suivre la date actuelle (pour les mises à jour en temps réel)
final currentDateProvider = Provider<DateTime>((ref) {
  return DateTime.now();
});

/// Provider pour le thème de l'application
final themeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

/// Extension pour accéder facilement aux providers
extension ProviderExtensions on WidgetRef {
  // Gestion des erreurs
  void setError(String? error) {
    read(errorProvider.notifier).state = error;
  }

  void clearError() {
    read(errorProvider.notifier).state = null;
  }

  // Gestion du chargement
  void setLoading(bool isLoading) {
    read(loadingProvider.notifier).state = isLoading;
  }

  // Gestion des succès
  void setSuccess(String? message) {
    read(successProvider.notifier).state = message;
  }

  void clearSuccess() {
    read(successProvider.notifier).state = null;
  }

  // Vérifications
  bool get isLoading => read(loadingProvider);
  String? get currentError => read(errorProvider);
  String? get currentSuccess => read(successProvider);
}