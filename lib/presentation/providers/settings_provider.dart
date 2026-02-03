import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/app_settings_entity.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../providers/app_providers.dart';

/// État pour les paramètres
class SettingsState {
  final AppSettingsEntity settings;
  final bool isLoading;
  final String? error;

  const SettingsState({
    required this.settings,
    this.isLoading = false,
    this.error,
  });

  SettingsState copyWith({
    AppSettingsEntity? settings,
    bool? isLoading,
    String? error,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SettingsState &&
        other.settings == settings &&
        other.isLoading == isLoading &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(settings, isLoading, error);
}

/// Notifier pour les paramètres
class SettingsNotifier extends StateNotifier<SettingsState> {
  final SettingsRepositoryImpl _repository;
  final Ref _ref;

  SettingsNotifier(this._repository, this._ref)
      : super(SettingsState(
          settings: AppSettingsEntity.defaultSettings(),
        )) {
    _loadSettings();
  }

  // Charger les paramètres
  Future<void> _loadSettings() async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _repository.getSettings();
    
    result.when(
      success: (settings) {
        state = state.copyWith(
          settings: settings,
          isLoading: false,
        );
      },
      error: (message, error, stackTrace) {
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
        _ref.setError(message);
      },
      loading: () {
        state = state.copyWith(isLoading: true);
      },
    );
  }

  // Sauvegarder les paramètres
  Future<void> saveSettings(AppSettingsEntity settings) async {
    final result = await _repository.saveSettings(settings);
    
    result.when(
      success: (_) {
        state = state.copyWith(settings: settings);
        _ref.setSuccess('Paramètres sauvegardés');
      },
      error: (message, error, stackTrace) {
        _ref.setError(message);
      },
      loading: () {},
    );
  }

  // Mettre à jour le thème
  Future<void> updateTheme(ThemeMode themeMode) async {
    final newSettings = state.settings.copyWith(themeMode: themeMode);
    await saveSettings(newSettings);
  }

  // Mettre à jour la langue
  Future<void> updateLanguage(String languageCode) async {
    final newSettings = state.settings.copyWith(languageCode: languageCode);
    await saveSettings(newSettings);
  }

  // Mettre à jour les animations
  Future<void> updateAnimations(bool showAnimations) async {
    final newSettings = state.settings.copyWith(showAnimations: showAnimations);
    await saveSettings(newSettings);
  }

  // Mettre à jour les emojis
  Future<void> updateEmojis(bool showEmojis) async {
    final newSettings = state.settings.copyWith(showEmojis: showEmojis);
    await saveSettings(newSettings);
  }

  // Mettre à jour les notifications
  Future<void> updateNotifications(bool enabled, TimeOfDay time) async {
    final newSettings = state.settings.copyWith(
      notificationsEnabled: enabled,
      notificationTime: time,
    );
    await saveSettings(newSettings);
  }

  // Mettre à jour la sauvegarde automatique
  Future<void> updateAutoBackup(bool enabled) async {
    final newSettings = state.settings.copyWith(autoBackupEnabled: enabled);
    await saveSettings(newSettings);
  }

  // Mettre à jour le premier lancement
  Future<void> markFirstLaunchCompleted() async {
    final newSettings = state.settings.copyWith(firstLaunchCompleted: true);
    await saveSettings(newSettings);
  }

  // Réinitialiser les paramètres
  Future<void> resetSettings() async {
    final result = await _repository.resetSettings();
    
    result.when(
      success: (_) {
        state = state.copyWith(settings: AppSettingsEntity.defaultSettings());
        _ref.setSuccess('Paramètres réinitialisés');
      },
      error: (message, error, stackTrace) {
        _ref.setError(message);
      },
      loading: () {},
    );
  }

  // Mettre à jour la date de dernière sauvegarde
  Future<void> updateLastBackupDate(DateTime date) async {
    final newSettings = state.settings.copyWith(lastBackupDate: date);
    await saveSettings(newSettings);
  }

  // Vérifier si un backup est nécessaire
  bool isBackupNeeded() {
    return state.settings.isBackupNeeded;
  }

  // Obtenir la date de dernière modification
  Future<DateTime?> getLastModified() async {
    final result = await _repository.getLastModified();
    
    return result.when(
      success: (date) => date,
      error: (message, error, stackTrace) {
        debugPrint('Erreur: $message');
        return null;
      },
      loading: () => null,
    );
  }
}

/// Providers Riverpod
final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return SettingsNotifier(repository, ref);
});

final themeModeProvider = Provider<ThemeMode>((ref) {
  final state = ref.watch(settingsProvider);
  return state.settings.themeMode;
});

final languageProvider = Provider<String>((ref) {
  final state = ref.watch(settingsProvider);
  return state.settings.languageCode;
});

final animationsEnabledProvider = Provider<bool>((ref) {
  final state = ref.watch(settingsProvider);
  return state.settings.showAnimations;
});

final emojisEnabledProvider = Provider<bool>((ref) {
  final state = ref.watch(settingsProvider);
  return state.settings.showEmojis;
});

final notificationsEnabledProvider = Provider<bool>((ref) {
  final state = ref.watch(settingsProvider);
  return state.settings.notificationsEnabled;
});

final notificationTimeProvider = Provider<TimeOfDay>((ref) {
  final state = ref.watch(settingsProvider);
  return state.settings.notificationTime;
});

final autoBackupEnabledProvider = Provider<bool>((ref) {
  final state = ref.watch(settingsProvider);
  return state.settings.autoBackupEnabled;
});

final firstLaunchCompletedProvider = Provider<bool>((ref) {
  final state = ref.watch(settingsProvider);
  return state.settings.firstLaunchCompleted;
});

final backupNeededProvider = Provider<bool>((ref) {
  final state = ref.watch(settingsProvider);
  return state.settings.isBackupNeeded;
});