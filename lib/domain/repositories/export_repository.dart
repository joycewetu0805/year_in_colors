import '../entities/export_data_entity.dart';
import '../entities/result_entity.dart';

/// Interface abstraite pour le repository d'export
abstract class ExportRepository {
  /// Sauvegarde un export
  Future<ResultEntity<String>> saveExport(ExportDataEntity export);

  /// Récupère un export par clé
  Future<ResultEntity<ExportDataEntity?>> getExport(String key);

  /// Récupère tous les exports
  Future<ResultEntity<List<ExportDataEntity>>> getAllExports();

  /// Récupère les exports d'une année
  Future<ResultEntity<List<ExportDataEntity>>> getExportsForYear(int year);

  /// Supprime un export
  Future<ResultEntity<void>> deleteExport(String key);

  /// Efface tous les exports
  Future<ResultEntity<void>> clearAllExports();

  /// Exporte les données en JSON
  Future<ResultEntity<String>> exportToJson(ExportDataEntity export);

  /// Importe depuis JSON
  Future<ResultEntity<ExportDataEntity>> importFromJson(String jsonString);

  /// Récupère le dernier export
  Future<ResultEntity<ExportDataEntity?>> getLastExport();
}
