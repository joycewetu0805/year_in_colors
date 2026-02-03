import 'package:flutter/material.dart';

/// ===============================
/// PARAMÈTRES DE L'APPLICATION
/// ===============================

class AppSettingsEntity {
  final ThemeMode themeMode; // ✅ Flutter ThemeMode
  final String languageCode;
  final bool showEmojis;
  final bool showAnimations;
  final bool showConfetti;
  final DateTime? lastBackupDate;
  final bool autoBackupEnabled;
  final bool notificationsEnabled;
  final TimeOfDay notificationTime;
  final bool firstLaunchCompleted;

  const AppSettingsEntity({
    this.themeMode = ThemeMode.system,
    this.languageCode = 'fr',
    this.showEmojis = true,
    this.showAnimations = true,
    this.showConfetti = true,
    this.lastBackupDate,
    this.autoBackupEnabled = false,
    this.notificationsEnabled = false,
    this.notificationTime = const TimeOfDay(hour: 20, minute: 0),
    this.firstLaunchCompleted = false,
  });

  /// Paramètres par défaut
  factory AppSettingsEntity.defaultSettings() {
    return const AppSettingsEntity();
  }

  /// Copie avec modifications
  AppSettingsEntity copyWith({
    ThemeMode? themeMode,
    String? languageCode,
    bool? showEmojis,
    bool? showAnimations,
    bool? showConfetti,
    DateTime? lastBackupDate,
    bool? autoBackupEnabled,
    bool? notificationsEnabled,
    TimeOfDay? notificationTime,
    bool? firstLaunchCompleted,
  }) {
    return AppSettingsEntity(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      showEmojis: showEmojis ?? this.showEmojis,
      showAnimations: showAnimations ?? this.showAnimations,
      showConfetti: showConfetti ?? this.showConfetti,
      lastBackupDate: lastBackupDate ?? this.lastBackupDate,
      autoBackupEnabled: autoBackupEnabled ?? this.autoBackupEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      notificationTime: notificationTime ?? this.notificationTime,
      firstLaunchCompleted:
          firstLaunchCompleted ?? this.firstLaunchCompleted,
    );
  }

  /// Backup requis tous les 7 jours
  bool get isBackupNeeded {
    if (lastBackupDate == null || !autoBackupEnabled) return false;
    return DateTime.now().difference(lastBackupDate!).inDays >= 7;
  }

  /// Notifications actives et configurées
  bool get areNotificationsConfigured {
    return notificationsEnabled;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsEntity &&
          themeMode == other.themeMode &&
          languageCode == other.languageCode &&
          showEmojis == other.showEmojis &&
          showAnimations == other.showAnimations &&
          showConfetti == other.showConfetti &&
          lastBackupDate == other.lastBackupDate &&
          autoBackupEnabled == other.autoBackupEnabled &&
          notificationsEnabled == other.notificationsEnabled &&
          notificationTime == other.notificationTime &&
          firstLaunchCompleted == other.firstLaunchCompleted;

  @override
  int get hashCode => Object.hash(
        themeMode,
        languageCode,
        showEmojis,
        showAnimations,
        showConfetti,
        lastBackupDate,
        autoBackupEnabled,
        notificationsEnabled,
        notificationTime,
        firstLaunchCompleted,
      );

  @override
  String toString() {
    return 'AppSettingsEntity(themeMode: $themeMode, language: $languageCode)';
  }
}

/// ===============================
/// UI HELPER (PAS UN ENUM FLUTTER)
/// ===============================

enum AppThemeOption {
  light('Clair', Icons.light_mode),
  dark('Sombre', Icons.dark_mode),
  system('Système', Icons.brightness_auto);

  final String label;
  final IconData icon;

  const AppThemeOption(this.label, this.icon);

  ThemeMode toThemeMode() {
    switch (this) {
      case AppThemeOption.light:
        return ThemeMode.light;
      case AppThemeOption.dark:
        return ThemeMode.dark;
      case AppThemeOption.system:
      default:
        return ThemeMode.system;
    }
  }

  static AppThemeOption fromThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return AppThemeOption.light;
      case ThemeMode.dark:
        return AppThemeOption.dark;
      case ThemeMode.system:
      default:
        return AppThemeOption.system;
    }
  }
}