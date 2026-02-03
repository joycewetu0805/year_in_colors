import 'package:hive/hive.dart';
import '../models/day_model.dart';
import '../../domain/entities/day_entity.dart';
import 'hive_config.dart';

/// Stockage local pour les jours avec Hive
class DayLocalStorage {
  Box<DayModel>? _boxInstance;

  Box<DayModel> get _box {
    _boxInstance ??= HiveConfig.daysBox;
    return _boxInstance!;
  }

  /// Constructeur par défaut
  DayLocalStorage();

  /// Constructeur avec injection de box (pour tests)
  DayLocalStorage.withBox(Box<DayModel> box) : _boxInstance = box;

  // Sauvegarder un jour
  Future<void> saveDay(DayEntity day) async {
    final model = DayModel.fromEntity(day);
    final key = model.hiveKey;
    await _box.put(key, model);
  }

  // Sauvegarder plusieurs jours
  Future<void> saveDays(List<DayEntity> days) async {
    final Map<String, DayModel> entries = {};
    for (final day in days) {
      final model = DayModel.fromEntity(day);
      entries[model.hiveKey] = model;
    }
    await _box.putAll(entries);
  }

  // Obtenir un jour spécifique
  Future<DayEntity?> getDay(DateTime date) async {
    final key = DayModel.generateKey(date);
    final model = _box.get(key);
    return model?.toEntity();
  }

  // Obtenir tous les jours
  Future<List<DayEntity>> getAllDays() async {
    final models = _box.values.toList();
    return models.map((model) => model.toEntity()).toList();
  }

  // Obtenir les jours d'une année spécifique
  Future<List<DayEntity>> getDaysForYear(int year) async {
    final models = _box.values.where((model) => model.date.year == year).toList();
    return models.map((model) => model.toEntity()).toList();
  }

  // Obtenir les jours d'un mois spécifique
  Future<List<DayEntity>> getDaysForMonth(int year, int month) async {
    final models = _box.values.where((model) {
      return model.date.year == year && model.date.month == month;
    }).toList();
    return models.map((model) => model.toEntity()).toList();
  }

  // Supprimer un jour
  Future<void> deleteDay(DateTime date) async {
    final key = DayModel.generateKey(date);
    await _box.delete(key);
  }

  // Supprimer plusieurs jours
  Future<void> deleteDays(List<DateTime> dates) async {
    final keys = dates.map((date) => DayModel.generateKey(date)).toList();
    await _box.deleteAll(keys);
  }

  // Effacer tous les jours
  Future<void> clearAllDays() async {
    await _box.clear();
  }

  // Obtenir le nombre de jours marqués
  Future<int> getMarkedDaysCount() async {
    final markedModels = _box.values.where((model) => model.value != 0).toList();
    return markedModels.length;
  }

  // Obtenir les statistiques
  Future<Map<String, dynamic>> getStats() async {
    final allModels = _box.values.toList();
    final markedModels = allModels.where((model) => model.value != 0).toList();
    final goodModels = markedModels.where((model) => model.value == 1).toList();
    final badModels = markedModels.where((model) => model.value == -1).toList();

    return {
      'totalDays': allModels.length,
      'markedDays': markedModels.length,
      'goodDays': goodModels.length,
      'badDays': badModels.length,
      'completionRate': allModels.isNotEmpty ? (markedModels.length / allModels.length) * 100 : 0,
    };
  }

  // Vérifier si un jour existe
  Future<bool> dayExists(DateTime date) async {
    final key = DayModel.generateKey(date);
    return _box.containsKey(key);
  }

  // Obtenir la date du dernier jour marqué
  Future<DateTime?> getLastMarkedDay() async {
    final markedModels = _box.values
        .where((model) => model.value != 0)
        .toList();

    if (markedModels.isEmpty) return null;

    markedModels.sort((a, b) => b.date.compareTo(a.date));
    return markedModels.first.date;
  }

  // Obtenir la série actuelle de bons/mauvais jours
  Future<Map<String, dynamic>> getCurrentStreak() async {
    final allModels = _box.values.toList();
    allModels.sort((a, b) => b.date.compareTo(a.date));

    if (allModels.isEmpty) {
      return {'type': 'none', 'length': 0};
    }

    int streak = 0;
    int currentValue = allModels.first.value;

    for (final model in allModels) {
      if (model.value == currentValue && model.value != 0) {
        streak++;
      } else {
        break;
      }
    }

    String type;
    switch (currentValue) {
      case 1:
        type = 'good';
        break;
      case -1:
        type = 'bad';
        break;
      default:
        type = 'none';
        streak = 0;
    }

    return {'type': type, 'length': streak};
  }
}
