import 'package:meta/meta.dart';
import '../../domain/entities/day_entity.dart';
import '../../domain/entities/month_summary_entity.dart';
import '../../domain/entities/year_summary_entity.dart';
import '../../domain/entities/result_entity.dart';
import '../../domain/repositories/day_repository.dart';
import '../local_storage/day_local_storage.dart';

/// Implémentation concrète du repository des jours
class DayRepositoryImpl implements DayRepository {
  final DayLocalStorage _localStorage;
  
  DayRepositoryImpl({required DayLocalStorage localStorage})
      : _localStorage = localStorage;
  
  @override
  Future<ResultEntity<void>> saveDay(DayEntity day) async {
    try {
      await _localStorage.saveDay(day);
      return const ResultEntity.success(null);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la sauvegarde du jour',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<DayEntity?>> getDay(DateTime date) async {
    try {
      final day = await _localStorage.getDay(date);
      return ResultEntity.success(day);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération du jour',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<List<DayEntity>>> getDaysForMonth(int year, int month) async {
    try {
      final days = await _localStorage.getDaysForMonth(year, month);
      return ResultEntity.success(days);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération des jours du mois',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<List<DayEntity>>> getDaysForYear(int year) async {
    try {
      final days = await _localStorage.getDaysForYear(year);
      return ResultEntity.success(days);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération des jours de l\'année',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<MonthSummaryEntity>> getMonthSummary(int year, int month) async {
    try {
      final days = await _localStorage.getDaysForMonth(year, month);
      final summary = MonthSummaryEntity(
        year: year,
        month: month,
        days: days,
      );
      return ResultEntity.success(summary);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la génération du résumé mensuel',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<YearSummaryEntity>> getYearSummary(int year) async {
    try {
      final days = await _localStorage.getDaysForYear(year);
      final summary = YearSummaryEntity.fromDays(year, days);
      return ResultEntity.success(summary);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la génération du résumé annuel',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<void>> deleteDay(DateTime date) async {
    try {
      await _localStorage.deleteDay(date);
      return const ResultEntity.success(null);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la suppression du jour',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<Map<String, dynamic>>> getStats() async {
    try {
      final stats = await _localStorage.getStats();
      return ResultEntity.success(stats);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération des statistiques',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<Map<String, dynamic>>> getCurrentStreak() async {
    try {
      final streak = await _localStorage.getCurrentStreak();
      return ResultEntity.success(streak);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération de la série',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<void>> clearAllDays() async {
    try {
      await _localStorage.clearAllDays();
      return const ResultEntity.success(null);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de l\'effacement des jours',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<bool>> dayExists(DateTime date) async {
    try {
      final exists = await _localStorage.dayExists(date);
      return ResultEntity.success(exists);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la vérification du jour',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<DateTime?>> getLastMarkedDay() async {
    try {
      final lastDay = await _localStorage.getLastMarkedDay();
      return ResultEntity.success(lastDay);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la récupération du dernier jour marqué',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
  
  @override
  Future<ResultEntity<void>> saveDays(List<DayEntity> days) async {
    try {
      await _localStorage.saveDays(days);
      return const ResultEntity.success(null);
    } catch (error, stackTrace) {
      return ResultEntity.error(
        'Erreur lors de la sauvegarde des jours',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}