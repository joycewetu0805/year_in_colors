import '../entities/app_settings_entity.dart';
import '../entities/result_entity.dart';

/// Interface abstraite pour le repository des paramètres
abstract class SettingsRepository {
  /// Récupère les paramètres actuels
  Future<ResultEntity<AppSettingsEntity>> getSettings();

  /// Sauvegarde les paramètres
  Future<ResultEntity<void>> saveSettings(AppSettingsEntity settings);

  /// Réinitialise les paramètres par défaut
  Future<ResultEntity<void>> resetSettings();

  /// Récupère la date de dernière modification
  Future<ResultEntity<DateTime?>> getLastModified();
}
