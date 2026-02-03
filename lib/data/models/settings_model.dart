import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/app_settings_entity.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 2)
class SettingsModel {
  @HiveField(0)
  final String themeMode; // 'light' | 'dark' | 'system'

  @HiveField(1)
  final String languageCode;

  @HiveField(2)
  final bool showEmojis;

  @HiveField(3)
  final bool showAnimations;

  @HiveField(4)
  final bool showConfetti;

  @HiveField(5)
  final DateTime? lastBackupDate;

  @HiveField(6)
  final bool autoBackupEnabled;

  @HiveField(7)
  final bool notificationsEnabled;

  @HiveField(8)
  final String notificationTime; // "HH:mm"

  @HiveField(9)
  final bool firstLaunchCompleted;

  const SettingsModel({
    required this.themeMode,
    required this.languageCode,
    required this.showEmojis,
    required this.showAnimations,
    required this.showConfetti,
    this.lastBackupDate,
    required this.autoBackupEnabled,
    required this.notificationsEnabled,
    required this.notificationTime,
    required this.firstLaunchCompleted,
  });

  /* ============================
     ENTITY → MODEL
  ============================ */

  factory SettingsModel.fromEntity(AppSettingsEntity entity) {
    return SettingsModel(
      themeMode: _themeModeToString(entity.themeMode),
      languageCode: entity.languageCode,
      showEmojis: entity.showEmojis,
      showAnimations: entity.showAnimations,
      showConfetti: entity.showConfetti,
      lastBackupDate: entity.lastBackupDate,
      autoBackupEnabled: entity.autoBackupEnabled,
      notificationsEnabled: entity.notificationsEnabled,
      notificationTime:
          '${entity.notificationTime.hour.toString().padLeft(2, '0')}:'
          '${entity.notificationTime.minute.toString().padLeft(2, '0')}',
      firstLaunchCompleted: entity.firstLaunchCompleted,
    );
  }

  /* ============================
     MODEL → ENTITY
  ============================ */

  AppSettingsEntity toEntity() {
    final parts = notificationTime.split(':');

    return AppSettingsEntity(
      themeMode: _stringToThemeMode(themeMode),
      languageCode: languageCode,
      showEmojis: showEmojis,
      showAnimations: showAnimations,
      showConfetti: showConfetti,
      lastBackupDate: lastBackupDate,
      autoBackupEnabled: autoBackupEnabled,
      notificationsEnabled: notificationsEnabled,
      notificationTime: TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      ),
      firstLaunchCompleted: firstLaunchCompleted,
    );
  }

  /* ============================
     COPY
  ============================ */

  SettingsModel copyWith({
    String? themeMode,
    String? languageCode,
    bool? showEmojis,
    bool? showAnimations,
    bool? showConfetti,
    DateTime? lastBackupDate,
    bool? autoBackupEnabled,
    bool? notificationsEnabled,
    String? notificationTime,
    bool? firstLaunchCompleted,
  }) {
    return SettingsModel(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      showEmojis: showEmojis ?? this.showEmojis,
      showAnimations: showAnimations ?? this.showAnimations,
      showConfetti: showConfetti ?? this.showConfetti,
      lastBackupDate: lastBackupDate ?? this.lastBackupDate,
      autoBackupEnabled: autoBackupEnabled ?? this.autoBackupEnabled,
      notificationsEnabled:
          notificationsEnabled ?? this.notificationsEnabled,
      notificationTime: notificationTime ?? this.notificationTime,
      firstLaunchCompleted:
          firstLaunchCompleted ?? this.firstLaunchCompleted,
    );
  }

  /* ============================
     DEFAULT
  ============================ */

  factory SettingsModel.defaultSettings() {
    return const SettingsModel(
      themeMode: 'system',
      languageCode: 'fr',
      showEmojis: true,
      showAnimations: true,
      showConfetti: true,
      lastBackupDate: null,
      autoBackupEnabled: false,
      notificationsEnabled: false,
      notificationTime: '20:00',
      firstLaunchCompleted: false,
    );
  }

  /* ============================
     HELPERS
  ============================ */

  static String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  static ThemeMode _stringToThemeMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsModel &&
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
  String toString() =>
      'SettingsModel(themeMode: $themeMode, language: $languageCode)';

  /// Sérialisation JSON
  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode,
      'languageCode': languageCode,
      'showEmojis': showEmojis,
      'showAnimations': showAnimations,
      'showConfetti': showConfetti,
      'lastBackupDate': lastBackupDate?.toIso8601String(),
      'autoBackupEnabled': autoBackupEnabled,
      'notificationsEnabled': notificationsEnabled,
      'notificationTime': notificationTime,
      'firstLaunchCompleted': firstLaunchCompleted,
    };
  }

  /// Désérialisation JSON
  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      themeMode: json['themeMode'] ?? 'system',
      languageCode: json['languageCode'] ?? 'fr',
      showEmojis: json['showEmojis'] ?? true,
      showAnimations: json['showAnimations'] ?? true,
      showConfetti: json['showConfetti'] ?? true,
      lastBackupDate: json['lastBackupDate'] != null
          ? DateTime.parse(json['lastBackupDate'])
          : null,
      autoBackupEnabled: json['autoBackupEnabled'] ?? false,
      notificationsEnabled: json['notificationsEnabled'] ?? false,
      notificationTime: json['notificationTime'] ?? '20:00',
      firstLaunchCompleted: json['firstLaunchCompleted'] ?? false,
    );
  }
}