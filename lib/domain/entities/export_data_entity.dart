import 'dart:convert';

/// Données d'export pour sauvegarde ou partage
class ExportDataEntity {
  final int year;
  final List<DayEntity> days;
  final AppSettingsEntity settings;
  final DateTime exportDate;
  final String version;

  const ExportDataEntity({
    required this.year,
    required this.days,
    required this.settings,
    required this.exportDate,
    this.version = '1.0',
  });

  /// Crée un export à partir des données actuelles
  factory ExportDataEntity.create({
    required int year,
    required List<DayEntity> days,
    required AppSettingsEntity settings,
  }) {
    return ExportDataEntity(
      year: year,
      days: days,
      settings: settings,
      exportDate: DateTime.now(),
      version: '1.0',
    );
  }

  /// Convertit en JSON pour le stockage
  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'days': days.map((day) => _dayToJson(day)).toList(),
      'settings': _settingsToJson(settings),
      'exportDate': exportDate.toIso8601String(),
      'version': version,
      'checksum': _calculateChecksum(),
    };
  }

  /// Crée depuis JSON
  factory ExportDataEntity.fromJson(Map<String, dynamic> json) {
    return ExportDataEntity(
      year: json['year'] as int,
      days: (json['days'] as List).map((dayJson) => _dayFromJson(dayJson)).toList(),
      settings: _settingsFromJson(json['settings']),
      exportDate: DateTime.parse(json['exportDate']),
      version: json['version'] ?? '1.0',
    );
  }

  /// Convertit en JSON string pour le partage
  String toJsonString() {
    return jsonEncode(toJson());
  }

  /// Crée depuis JSON string
  factory ExportDataEntity.fromJsonString(String jsonString) {
    return ExportDataEntity.fromJson(jsonDecode(jsonString));
  }

  /// Convertit en CSV pour l'export
  String toCsv() {
    final csv = StringBuffer();
    
    // En-tête
    csv.writeln('Date,Valeur,Emoji,Statut');
    
    // Données
    for (final day in days) {
      csv.writeln('${day.date.toIso8601String()},'
          '${day.value.toInt()},'
          '${day.value.emoji},'
          '${day.value.label}');
    }
    
    return csv.toString();
  }

  /// Statistiques de l'export
  Map<String, dynamic> get stats {
    final markedDays = days.where((day) => day.isMarked).length;
    final goodDays = days.where((day) => day.isGoodDay).length;
    final badDays = days.where((day) => day.isBadDay).length;
    
    return {
      'totalDays': days.length,
      'markedDays': markedDays,
      'goodDays': goodDays,
      'badDays': badDays,
      'exportSize': toJsonString().length,
      'isValid': _validateData(),
    };
  }

  /// Vérifie l'intégrité des données
  bool _validateData() {
    try {
      // Vérifie que toutes les dates sont dans l'année spécifiée
      for (final day in days) {
        if (day.date.year != year) return false;
      }
      
      // Vérifie le checksum si présent
      final storedChecksum = toJson()['checksum'];
      final calculatedChecksum = _calculateChecksum();
      
      return storedChecksum == null || storedChecksum == calculatedChecksum;
    } catch (e) {
      return false;
    }
  }

  /// Calcule un checksum simple pour vérifier l'intégrité
  String _calculateChecksum() {
    final data = '${year}${days.length}${exportDate.millisecondsSinceEpoch}';
    final bytes = utf8.encode(data);
    return sha256.convert(bytes).toString();
  }

  // Méthodes de conversion helper
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

  static Map<String, dynamic> _settingsToJson(AppSettingsEntity settings) {
    return {
      'themeMode': settings.themeMode.toStorageString(),
      'languageCode': settings.languageCode,
      'showEmojis': settings.showEmojis,
      'showAnimations': settings.showAnimations,
      'showConfetti': settings.showConfetti,
      'lastBackupDate': settings.lastBackupDate?.toIso8601String(),
      'autoBackupEnabled': settings.autoBackupEnabled,
      'notificationsEnabled': settings.notificationsEnabled,
      'notificationTime': '${settings.notificationTime.hour}:${settings.notificationTime.minute}',
      'firstLaunchCompleted': settings.firstLaunchCompleted,
    };
  }

  static AppSettingsEntity _settingsFromJson(Map<String, dynamic> json) {
    return AppSettingsEntity(
      themeMode: ThemeMode.fromString(json['themeMode']),
      languageCode: json['languageCode'],
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

// Import pour SHA256
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';