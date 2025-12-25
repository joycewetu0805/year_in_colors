import 'package:hive/hive.dart';
import '../models/settings_model.dart';
import '../../domain/entities/app_settings_entity.dart';

/// Stockage local pour les paramètres avec Hive
class SettingsLocalStorage {
  static const String _settingsKey = 'app_settings';
  final Box<SettingsModel> _box;
  
  SettingsLocalStorage(this._box);
  
  factory SettingsLocalStorage.getInstance() {
    return SettingsLocalStorage(HiveConfig.settingsBox);
  }
  
  // Sauvegarder les paramètres
  Future<void> saveSettings(AppSettingsEntity settings) async {
    final model = SettingsModel.fromEntity(settings);
    await _box.put(_settingsKey, model);
  }
  
  // Obtenir les paramètres
  Future<AppSettingsEntity?> getSettings() async {
    final model = _box.get(_settingsKey);
    return model?.toEntity();
  }
  
  // Obtenir les paramètres ou les créer par défaut
  Future<AppSettingsEntity> getSettingsOrDefault() async {
    final settings = await getSettings();
    
    if (settings == null) {
      final defaultSettings = AppSettingsEntity.defaultSettings();
      await saveSettings(defaultSettings);
      return defaultSettings;
    }
    
    return settings;
  }
  
  // Mettre à jour partiellement les paramètres
  Future<AppSettingsEntity> updateSettings(Map<String, dynamic> updates) async {
    final current = await getSettingsOrDefault();
    final newSettings = _applyUpdates(current, updates);
    await saveSettings(newSettings);
    return newSettings;
  }
  
  // Réinitialiser les paramètres
  Future<void> resetSettings() async {
    final defaultSettings = AppSettingsEntity.defaultSettings();
    await saveSettings(defaultSettings);
  }
  
  // Supprimer les paramètres
  Future<void> deleteSettings() async {
    await _box.delete(_settingsKey);
  }
  
  // Appliquer les mises à jour
  AppSettingsEntity _applyUpdates(
    AppSettingsEntity current,
    Map<String, dynamic> updates,
  ) {
    var newSettings = current;
    
    if (updates.containsKey('themeMode')) {
      newSettings = newSettings.copyWith(
        themeMode: ThemeMode.values.firstWhere(
          (mode) => mode.toString() == updates['themeMode'],
          orElse: () => ThemeMode.system,
        ),
      );
    }
    
    if (updates.containsKey('languageCode')) {
      newSettings = newSettings.copyWith(
        languageCode: updates['languageCode'] as String,
      );
    }
    
    if (updates.containsKey('showEmojis')) {
      newSettings = newSettings.copyWith(
        showEmojis: updates['showEmojis'] as bool,
      );
    }
    
    if (updates.containsKey('showAnimations')) {
      newSettings = newSettings.copyWith(
        showAnimations: updates['showAnimations'] as bool,
      );
    }
    
    if (updates.containsKey('showConfetti')) {
      newSettings = newSettings.copyWith(
        showConfetti: updates['showConfetti'] as bool,
      );
    }
    
    if (updates.containsKey('lastBackupDate')) {
      newSettings = newSettings.copyWith(
        lastBackupDate: updates['lastBackupDate'] as DateTime?,
      );
    }
    
    if (updates.containsKey('autoBackupEnabled')) {
      newSettings = newSettings.copyWith(
        autoBackupEnabled: updates['autoBackupEnabled'] as bool,
      );
    }
    
    if (updates.containsKey('notificationsEnabled')) {
      newSettings = newSettings.copyWith(
        notificationsEnabled: updates['notificationsEnabled'] as bool,
      );
    }
    
    if (updates.containsKey('notificationTime')) {
      final time = updates['notificationTime'] as TimeOfDay;
      newSettings = newSettings.copyWith(notificationTime: time);
    }
    
    if (updates.containsKey('firstLaunchCompleted')) {
      newSettings = newSettings.copyWith(
        firstLaunchCompleted: updates['firstLaunchCompleted'] as bool,
      );
    }
    
    return newSettings;
  }
  
  // Vérifier si les paramètres existent
  Future<bool> settingsExist() async {
    return _box.containsKey(_settingsKey);
  }
  
  // Obtenir la date de dernière modification
  Future<DateTime?> getLastModified() async {
    final model = _box.get(_settingsKey);
    return model?.lastBackupDate;
  }
}