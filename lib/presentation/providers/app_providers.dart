import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/day_repository_impl.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../data/repositories/export_repository_impl.dart';

import '../../data/local_storage/day_local_storage.dart';
import '../../data/local_storage/settings_local_storage.dart';
import '../../data/local_storage/export_local_storage.dart';

/// =======================
/// LOCAL STORAGE PROVIDERS
/// =======================

final dayLocalStorageProvider = Provider<DayLocalStorage>((ref) {
  return DayLocalStorage();
});

final settingsLocalStorageProvider = Provider<SettingsLocalStorage>((ref) {
  return SettingsLocalStorage();
});

final exportLocalStorageProvider = Provider<ExportLocalStorage>((ref) {
  return ExportLocalStorage();
});

/// =======================
/// REPOSITORY PROVIDERS
/// =======================

final dayRepositoryProvider = Provider<DayRepositoryImpl>((ref) {
  return DayRepositoryImpl(
    localStorage: ref.read(dayLocalStorageProvider),
  );
});

final settingsRepositoryProvider = Provider<SettingsRepositoryImpl>((ref) {
  return SettingsRepositoryImpl(
    localStorage: ref.read(settingsLocalStorageProvider),
  );
});

final exportRepositoryProvider = Provider<ExportRepositoryImpl>((ref) {
  return ExportRepositoryImpl(
    localStorage: ref.read(exportLocalStorageProvider),
  );
});

/// =======================
/// GLOBAL APP STATE
/// =======================

final loadingProvider = StateProvider<bool>((ref) => false);

final errorProvider = StateProvider<String?>((ref) => null);

final successProvider = StateProvider<String?>((ref) => null);

// Note: themeModeProvider est défini dans settings_provider.dart
// Il dérive du SettingsState pour cohérence avec les paramètres persistés

final currentDateProvider = Provider<DateTime>((ref) {
  return DateTime.now();
});

/// =======================
/// APP INITIALIZATION
/// =======================

final appInitializationProvider = FutureProvider<void>((ref) async {
  await Future.delayed(const Duration(milliseconds: 300));
});

/// =======================
/// WIDGET REF EXTENSIONS
/// =======================

extension GlobalAppActions on WidgetRef {
  void setLoading(bool value) {
    read(loadingProvider.notifier).state = value;
  }

  void setError(String? message) {
    read(errorProvider.notifier).state = message;
  }

  void clearError() {
    read(errorProvider.notifier).state = null;
  }

  void setSuccess(String? message) {
    read(successProvider.notifier).state = message;
  }

  void clearSuccess() {
    read(successProvider.notifier).state = null;
  }

  bool get isLoading => read(loadingProvider);
  String? get error => read(errorProvider);
  String? get success => read(successProvider);
}

/// Extension pour Ref (utilisé dans les StateNotifier)
extension RefGlobalAppActions on Ref {
  void setLoading(bool value) {
    read(loadingProvider.notifier).state = value;
  }

  void setError(String? message) {
    read(errorProvider.notifier).state = message;
  }

  void clearError() {
    read(errorProvider.notifier).state = null;
  }

  void setSuccess(String? message) {
    read(successProvider.notifier).state = message;
  }

  void clearSuccess() {
    read(successProvider.notifier).state = null;
  }
}