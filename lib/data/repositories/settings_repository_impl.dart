import 'package:meta/meta.dart';
import '../../domain/entities/app_settings_entity.dart';
import '../../domain/entities/result_entity.dart';
import '../../domain/repositories/settings_repository.dart';
import '../local_storage/settings_local_storage.dart';

/// Implémentation concrète du repository des paramètres
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalStorage _localStorage;
  
  SettingsRepositoryImpl({required SettingsLocalStorage localStorage})
      : _localStorage = localStorage;
  
  @override
  Future<ResultEntity<AppSettingsEntity>> getSettings() async {
    try {
      final settings = await _localStorage.getSettingsOrDefault();
      return ResultEntity.success(settings);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération des paramètres',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<void>> saveSettings(AppSettingsEntity settings) async {
    try {
      await _localStorage.saveSettings(settings);
      return const ResultEntity.success(null);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la sauvegarde des paramètres',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<AppSettingsEntity>> updateSettings(Map<String, dynamic> updates) async {
    try {
      final updatedSettings = await _localStorage.updateSettings(updates);
      return ResultEntity.success(updatedSettings);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la mise à jour des paramètres',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<void>> resetSettings() async {
    try {
      await _localStorage.resetSettings();
      return const ResultEntity.success(null);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la réinitialisation des paramètres',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<bool>> settingsExist() async {
    try {
      final exists = await _localStorage.settingsExist();
      return ResultEntity.success(exists);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la vérification des paramètres',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<DateTime?>> getLastModified() async {
    try {
      final lastModified = await _localStorage.getLastModified();
      return ResultEntity.success(lastModified);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération de la date de modification',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}