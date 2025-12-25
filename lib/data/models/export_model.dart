import 'dart:convert';
import 'package:hive/hive.dart';
import 'day_model.dart';
import 'settings_model.dart';
import '../../domain/entities/export_data_entity.dart';

part 'export_model.g.dart';

@HiveType(typeId: 3)
class ExportModel {
  @HiveField(0)
  final int year;
  
  @HiveField(1)
  final List<DayModel> days;
  
  @HiveField(2)
  final SettingsModel settings;
  
  @HiveField(3)
  final DateTime exportDate;
  
  @HiveField(4)
  final String version;
  
  @HiveField(5)
  final String checksum;
  
  ExportModel({
    required this.year,
    required this.days,
    required this.settings,
    required this.exportDate,
    this.version = '1.0',
    required this.checksum,
  });
  
  // Convertir depuis l'entité métier
  factory ExportModel.fromEntity(ExportDataEntity entity) {
    return ExportModel(
      year: entity.year,
      days: entity.days.map((day) => DayModel.fromEntity(day)).toList(),
      settings: SettingsModel.fromEntity(entity.settings),
      exportDate: entity.exportDate,
      version: entity.version,
      checksum: entity.toJson()['checksum'] ?? '',
    );
  }
  
  // Convertir vers l'entité métier
  ExportDataEntity toEntity() {
    return ExportDataEntity(
      year: year,
      days: days.map((day) => day.toEntity()).toList(),
      settings: settings.toEntity(),
      exportDate: exportDate,
      version: version,
    );
  }
  
  // Convertir en JSON
  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'days': days.map((day) => day.toJson()).toList(),
      'settings': settings.toJson(),
      'exportDate': exportDate.toIso8601String(),
      'version': version,
      'checksum': checksum,
    };
  }
  
  // Créer depuis JSON
  factory ExportModel.fromJson(Map<String, dynamic> json) {
    return ExportModel(
      year: json['year'] as int,
      days: (json['days'] as List)
          .map((dayJson) => DayModel.fromJson(dayJson))
          .toList(),
      settings: SettingsModel.fromJson(json['settings']),
      exportDate: DateTime.parse(json['exportDate']),
      version: json['version'] ?? '1.0',
      checksum: json['checksum'] ?? '',
    );
  }
  
  // Vérifier l'intégrité
  bool validate() {
    final expectedChecksum = _calculateChecksum();
    return checksum == expectedChecksum;
  }
  
  String _calculateChecksum() {
    final data = '${year}${days.length}${exportDate.millisecondsSinceEpoch}';
    final bytes = utf8.encode(data);
    return sha256.convert(bytes).toString();
  }
  
  @override
  String toString() {
    return 'ExportModel(year: $year, days: ${days.length}, date: $exportDate)';
  }
}

// Ajouter les méthodes toJson/fromJson aux modèles DayModel et SettingsModel

// Dans DayModel
extension DayModelJson on DayModel {
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'value': value,
    };
  }
  
  static DayModel fromJson(Map<String, dynamic> json) {
    return DayModel(
      date: DateTime.parse(json['date']),
      value: json['value'] as int,
    );
  }
}

// Dans SettingsModel
extension SettingsModelJson on SettingsModel {
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
  
  static SettingsModel fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      themeMode: json['themeMode'] as String,
      languageCode: json['languageCode'] as String,
      showEmojis: json['showEmojis'] as bool,
      showAnimations: json['showAnimations'] as bool,
      showConfetti: json['showConfetti'] as bool,
      lastBackupDate: json['lastBackupDate'] != null
          ? DateTime.parse(json['lastBackupDate'] as String)
          : null,
      autoBackupEnabled: json['autoBackupEnabled'] as bool,
      notificationsEnabled: json['notificationsEnabled'] as bool,
      notificationTime: json['notificationTime'] as String,
      firstLaunchCompleted: json['firstLaunchCompleted'] as bool,
    );
  }
}

// Import pour SHA256
import 'package:crypto/crypto.dart';