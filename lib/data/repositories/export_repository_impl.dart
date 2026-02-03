import 'package:meta/meta.dart';
import '../../domain/entities/export_data_entity.dart';
import '../../domain/entities/result_entity.dart';
import '../../domain/repositories/export_repository.dart';
import '../local_storage/export_local_storage.dart';

/// Implémentation concrète du repository des exports
class ExportRepositoryImpl implements ExportRepository {
  final ExportLocalStorage _localStorage;
  
  ExportRepositoryImpl({required ExportLocalStorage localStorage})
      : _localStorage = localStorage;
  
  @override
  Future<ResultEntity<String>> saveExport(ExportDataEntity export) async {
    try {
      final key = await _localStorage.saveExport(export);
      return ResultEntity.success(key);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la sauvegarde de l\'export',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<void>> saveExportWithKey(String key, ExportDataEntity export) async {
    try {
      await _localStorage.saveExportWithKey(key, export);
      return const ResultEntity.success(null);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la sauvegarde de l\'export avec clé',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<ExportDataEntity?>> getExport(String key) async {
    try {
      final export = await _localStorage.getExport(key);
      return ResultEntity.success(export);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération de l\'export',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<List<ExportDataEntity>>> getAllExports() async {
    try {
      final exports = await _localStorage.getAllExports();
      return ResultEntity.success(exports);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération de tous les exports',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<ResultEntity<List<ExportDataEntity>>> getExportsForYear(int year) async {
    try {
      final exports = await _localStorage.getExportsForYear(year);
      return ResultEntity.success(exports);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération des exports pour l\'année $year',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<ExportDataEntity?>> getLastExport() async {
    try {
      final lastExport = await _localStorage.getLastExport();
      return ResultEntity.success(lastExport);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération du dernier export',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<String>> exportToJson(ExportDataEntity export) async {
    try {
      final jsonString = await _localStorage.exportToJson(export);
      return ResultEntity.success(jsonString);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de l\'export en JSON',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<ExportDataEntity>> importFromJson(String jsonString) async {
    try {
      final export = await _localStorage.importFromJson(jsonString);
      return ResultEntity.success(export);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de l\'import depuis JSON',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<void>> deleteExport(String key) async {
    try {
      await _localStorage.deleteExport(key);
      return const ResultEntity.success(null);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la suppression de l\'export',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<void>> clearAllExports() async {
    try {
      await _localStorage.clearAllExports();
      return const ResultEntity.success(null);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de l\'effacement des exports',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<Map<String, dynamic>>> getExportStats() async {
    try {
      final stats = await _localStorage.getExportStats();
      return ResultEntity.success(stats);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération des statistiques d\'export',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<List<ExportDataEntity>>> searchExports({
    int? year,
    DateTime? startDate,
    DateTime? endDate,
    String? version,
  }) async {
    try {
      final exports = await _localStorage.searchExports(
        year: year,
        startDate: startDate,
        endDate: endDate,
        version: version,
      );
      return ResultEntity.success(exports);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la recherche des exports',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<bool>> exportsExist() async {
    try {
      final exists = await _localStorage.exportsExist();
      return ResultEntity.success(exists);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la vérification des exports',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}