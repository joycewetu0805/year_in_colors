import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../models/day_model.dart';
import '../models/settings_model.dart';
import '../models/export_model.dart';

/// Configuration et initialisation de Hive
class HiveConfig {
  static const String _daysBoxName = 'days_box';
  static const String _settingsBoxName = 'settings_box';
  static const String _exportsBoxName = 'exports_box';
  
  static Future<void> initialize() async {
    // Initialiser Hive avec le chemin de l'application
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    
    // Enregistrer les adaptateurs
    Hive.registerAdapter(DayModelAdapter());
    Hive.registerAdapter(SettingsModelAdapter());
    Hive.registerAdapter(ExportModelAdapter());
    
    // Ouvrir les boxes
    await Hive.openBox<DayModel>(_daysBoxName);
    await Hive.openBox<SettingsModel>(_settingsBoxName);
    await Hive.openBox<ExportModel>(_exportsBoxName);
  }
  
  static Box<DayModel> get daysBox => Hive.box<DayModel>(_daysBoxName);
  static Box<SettingsModel> get settingsBox => Hive.box<SettingsModel>(_settingsBoxName);
  static Box<ExportModel> get exportsBox => Hive.box<ExportModel>(_exportsBoxName);
  
  static Future<void> close() async {
    await Hive.close();
  }
  
  static Future<void> clearAllData() async {
    await daysBox.clear();
    await settingsBox.clear();
    await exportsBox.clear();
  }
  
  static Future<int> getDatabaseSize() async {
    final daysSize = daysBox.length;
    final settingsSize = settingsBox.length;
    final exportsSize = exportsBox.length;

    return daysSize + settingsSize + exportsSize;
  }
  
  static Map<String, dynamic> getDatabaseStats() {
    return {
      'daysCount': daysBox.length,
      'settingsCount': settingsBox.length,
      'exportsCount': exportsBox.length,
      'daysKeys': daysBox.keys.toList(),
      'isOpen': Hive.isBoxOpen(_daysBoxName),
    };
  }
}