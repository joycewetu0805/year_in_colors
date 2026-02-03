import 'dart:convert';
import 'package:crypto/crypto.dart';
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
    required this.checksum,
    this.version = '1.0',
  });

  factory ExportModel.fromEntity(ExportDataEntity entity) {
    return ExportModel(
      year: entity.year,
      days: entity.days.map(DayModel.fromEntity).toList(),
      settings: SettingsModel.fromEntity(entity.settings),
      exportDate: entity.exportDate,
      version: entity.version,
      checksum: entity.checksum,
    );
  }

  ExportDataEntity toEntity() {
    return ExportDataEntity(
      year: year,
      days: days.map((e) => e.toEntity()).toList(),
      settings: settings.toEntity(),
      exportDate: exportDate,
      version: version,
      checksum: checksum,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'days': days.map((d) => d.toJson()).toList(),
      'settings': settings.toJson(),
      'exportDate': exportDate.toIso8601String(),
      'version': version,
      'checksum': checksum,
    };
  }

  factory ExportModel.fromJson(Map<String, dynamic> json) {
    return ExportModel(
      year: json['year'],
      days: (json['days'] as List)
          .map((e) => DayModel.fromJson(e))
          .toList(),
      settings: SettingsModel.fromJson(json['settings']),
      exportDate: DateTime.parse(json['exportDate']),
      version: json['version'] ?? '1.0',
      checksum: json['checksum'],
    );
  }

  static String calculateChecksum({
    required int year,
    required int daysCount,
    required DateTime exportDate,
  }) {
    final data = '$year$daysCount${exportDate.millisecondsSinceEpoch}';
    return sha256.convert(utf8.encode(data)).toString();
  }

  /// Valide l'intégrité de l'export
  bool validate() {
    final expectedChecksum = calculateChecksum(
      year: year,
      daysCount: days.length,
      exportDate: exportDate,
    );
    return checksum == expectedChecksum;
  }
}