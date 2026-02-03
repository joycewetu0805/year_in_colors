import '../entities/day_entity.dart';
import '../entities/month_summary_entity.dart';
import '../entities/year_summary_entity.dart';
import '../entities/result_entity.dart';

/// Interface abstraite pour le repository des jours
/// Définit le contrat que toute implémentation doit respecter
abstract class DayRepository {
  /// Sauvegarde un jour
  Future<ResultEntity<void>> saveDay(DayEntity day);

  /// Sauvegarde plusieurs jours en batch
  Future<ResultEntity<void>> saveDays(List<DayEntity> days);

  /// Récupère un jour spécifique par date
  Future<ResultEntity<DayEntity?>> getDay(DateTime date);

  /// Récupère tous les jours d'un mois
  Future<ResultEntity<List<DayEntity>>> getDaysForMonth(int year, int month);

  /// Récupère tous les jours d'une année
  Future<ResultEntity<List<DayEntity>>> getDaysForYear(int year);

  /// Génère le résumé statistique d'un mois
  Future<ResultEntity<MonthSummaryEntity>> getMonthSummary(int year, int month);

  /// Génère le résumé statistique d'une année
  Future<ResultEntity<YearSummaryEntity>> getYearSummary(int year);

  /// Supprime un jour
  Future<ResultEntity<void>> deleteDay(DateTime date);

  /// Récupère les statistiques globales
  Future<ResultEntity<Map<String, dynamic>>> getStats();

  /// Récupère la série actuelle (streak)
  Future<ResultEntity<Map<String, dynamic>>> getCurrentStreak();

  /// Efface tous les jours
  Future<ResultEntity<void>> clearAllDays();

  /// Vérifie si un jour existe
  Future<ResultEntity<bool>> dayExists(DateTime date);

  /// Récupère la date du dernier jour marqué
  Future<ResultEntity<DateTime?>> getLastMarkedDay();
}
