import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';

import 'day_entity.dart';
import 'app_settings_entity.dart';

class ExportDataEntity {
  final int year;
  final List<DayEntity> days;
  final AppSettingsEntity settings;
  final DateTime exportDate;
  final String version;
  final String checksum;

  const ExportDataEntity({
    required this.year,
    required this.days,
    required this.settings,
    required this.exportDate,
    required this.checksum,
    this.version = '1.0',
  });

  factory ExportDataEntity.create({
    required int year,
    required List<DayEntity> days,
    required AppSettingsEntity settings,
  }) {
    final exportDate = DateTime.now();
    final checksum = _calculateChecksumStatic(
      year: year,
      daysCount: days.length,
      exportDate: exportDate,
    );

    return ExportDataEntity(
      year: year,
      days: days,
      settings: settings,
      exportDate: exportDate,
      version: '1.0',
      checksum: checksum,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'days': days.map(_dayToJson).toList(),
      'settings': _settingsToJson(settings),
      'exportDate': exportDate.toIso8601String(),
      'version': version,
      'checksum': checksum,
    };
  }

  factory ExportDataEntity.fromJson(Map<String, dynamic> json) {
    return ExportDataEntity(
      year: json['year'],
      days: (json['days'] as List).map((e) => _dayFromJson(e)).toList(),
      settings: _settingsFromJson(json['settings']),
      exportDate: DateTime.parse(json['exportDate']),
      version: json['version'] ?? '1.0',
      checksum: json['checksum'],
    );
  }

  String toJsonString() => jsonEncode(toJson());

  /// Convertit les données en format CSV
  String toCsv() {
    final buffer = StringBuffer();
    buffer.writeln('Date,Value,Status');
    for (final day in days) {
      final status = day.isGoodDay ? 'good' : (day.isBadDay ? 'bad' : 'neutral');
      buffer.writeln('${day.date.toIso8601String().split('T')[0]},${day.value.toInt()},$status');
    }
    return buffer.toString();
  }

  static String _calculateChecksumStatic({
    required int year,
    required int daysCount,
    required DateTime exportDate,
  }) {
    final data = '$year$daysCount${exportDate.millisecondsSinceEpoch}';
    return sha256.convert(utf8.encode(data)).toString();
  }

  static Map<String, dynamic> _dayToJson(DayEntity day) {
    return {
      'date': day.date.toIso8601String(),
      'value': day.value.toInt(),
    };
  }

  static DayEntity _dayFromJson(Map<String, dynamic> json) {
    return DayEntity(
      date: DateTime.parse(json['date']),
      value: DayStatusValue.fromInt(json['value']),
    );
  }

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

  static Map<String, dynamic> _settingsToJson(AppSettingsEntity settings) {
    return {
      'themeMode': _themeModeToString(settings.themeMode),
      'languageCode': settings.languageCode,
      'showEmojis': settings.showEmojis,
      'showAnimations': settings.showAnimations,
      'showConfetti': settings.showConfetti,
      'lastBackupDate': settings.lastBackupDate?.toIso8601String(),
      'autoBackupEnabled': settings.autoBackupEnabled,
      'notificationsEnabled': settings.notificationsEnabled,
      'notificationTime':
          '${settings.notificationTime.hour}:${settings.notificationTime.minute}',
      'firstLaunchCompleted': settings.firstLaunchCompleted,
    };
  }

  static AppSettingsEntity _settingsFromJson(Map<String, dynamic> json) {
    return AppSettingsEntity(
      themeMode: _stringToThemeMode(json['themeMode'] ?? 'system'),
      languageCode: json['languageCode'] ?? 'fr',
      showEmojis: json['showEmojis'] ?? true,
      showAnimations: json['showAnimations'] ?? true,
      showConfetti: json['showConfetti'] ?? true,
      lastBackupDate: json['lastBackupDate'] != null
          ? DateTime.parse(json['lastBackupDate'])
          : null,
      autoBackupEnabled: json['autoBackupEnabled'] ?? false,
      notificationsEnabled: json['notificationsEnabled'] ?? false,
      notificationTime: json['notificationTime'] != null
          ? TimeOfDay(
              hour: int.parse(json['notificationTime'].split(':')[0]),
              minute: int.parse(json['notificationTime'].split(':')[1]),
            )
          : const TimeOfDay(hour: 20, minute: 0),
      firstLaunchCompleted: json['firstLaunchCompleted'] ?? false,
    );
  }
}
