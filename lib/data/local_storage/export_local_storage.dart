import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/export_model.dart';
import '../../domain/entities/export_data_entity.dart';
import 'hive_config.dart';

/// Stockage local pour les exports avec Hive
class ExportLocalStorage {
  Box<ExportModel>? _boxInstance;

  Box<ExportModel> get _box {
    _boxInstance ??= HiveConfig.exportsBox;
    return _boxInstance!;
  }

  /// Constructeur par défaut
  ExportLocalStorage();

  /// Constructeur avec injection de box (pour tests)
  ExportLocalStorage.withBox(Box<ExportModel> box) : _boxInstance = box;

  // Sauvegarder un export
  Future<String> saveExport(ExportDataEntity export) async {
    final model = ExportModel.fromEntity(export);
    final key = 'export_${export.exportDate.millisecondsSinceEpoch}';
    await _box.put(key, model);
    return key;
  }

  // Sauvegarder un export avec une clé spécifique
  Future<void> saveExportWithKey(String key, ExportDataEntity export) async {
    final model = ExportModel.fromEntity(export);
    await _box.put(key, model);
  }

  // Obtenir un export par clé
  Future<ExportDataEntity?> getExport(String key) async {
    final model = _box.get(key);
    return model?.toEntity();
  }

  // Obtenir tous les exports
  Future<List<ExportDataEntity>> getAllExports() async {
    final models = _box.values.toList();
    return models.map((model) => model.toEntity()).toList();
  }

  // Obtenir les exports d'une année
  Future<List<ExportDataEntity>> getExportsForYear(int year) async {
    final models = _box.values
        .where((model) => model.year == year)
        .toList();
    return models.map((model) => model.toEntity()).toList();
  }

  // Supprimer un export
  Future<void> deleteExport(String key) async {
    await _box.delete(key);
  }

  // Supprimer plusieurs exports
  Future<void> deleteExports(List<String> keys) async {
    await _box.deleteAll(keys);
  }

  // Effacer tous les exports
  Future<void> clearAllExports() async {
    await _box.clear();
  }

  // Exporter en JSON string
  Future<String> exportToJson(ExportDataEntity export) async {
    final model = ExportModel.fromEntity(export);
    final json = model.toJson();
    return jsonEncode(json);
  }

  // Importer depuis JSON string
  Future<ExportDataEntity> importFromJson(String jsonString) async {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final model = ExportModel.fromJson(json);

    if (!model.validate()) {
      throw const FormatException('Export data is corrupted or invalid');
    }

    return model.toEntity();
  }

  // Obtenir le dernier export
  Future<ExportDataEntity?> getLastExport() async {
    final models = _box.values.toList();

    if (models.isEmpty) return null;

    models.sort((a, b) => b.exportDate.compareTo(a.exportDate));
    return models.first.toEntity();
  }

  // Vérifier si des exports existent
  Future<bool> exportsExist() async {
    return _box.isNotEmpty;
  }

  // Obtenir les statistiques d'export
  Future<Map<String, dynamic>> getExportStats() async {
    final models = _box.values.toList();
    final totalSize = models.fold(0, (sum, model) {
      return sum + jsonEncode(model.toJson()).length;
    });

    return {
      'count': models.length,
      'totalSizeBytes': totalSize,
      'averageSizeBytes': models.isNotEmpty ? totalSize ~/ models.length : 0,
      'lastExportDate': models.isNotEmpty
          ? models.map((m) => m.exportDate).reduce((a, b) => a.isAfter(b) ? a : b)
          : null,
    };
  }

  // Rechercher des exports par critères
  Future<List<ExportDataEntity>> searchExports({
    int? year,
    DateTime? startDate,
    DateTime? endDate,
    String? version,
  }) async {
    var models = _box.values.toList();

    if (year != null) {
      models = models.where((model) => model.year == year).toList();
    }

    if (startDate != null) {
      models = models.where((model) => model.exportDate.isAfter(startDate)).toList();
    }

    if (endDate != null) {
      models = models.where((model) => model.exportDate.isBefore(endDate)).toList();
    }

    if (version != null) {
      models = models.where((model) => model.version == version).toList();
    }

    return models.map((model) => model.toEntity()).toList();
  }
}
