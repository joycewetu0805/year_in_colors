import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import '../../domain/entities/day_entity.dart';
import '../../domain/entities/month_summary_entity.dart';
import '../../domain/entities/year_summary_entity.dart';
import '../../domain/entities/result_entity.dart';
import '../../data/repositories/day_repository_impl.dart';
import '../providers/app_providers.dart';

/// État pour la gestion des jours
class DayState {
  final List<DayEntity> days;
  final DateTime selectedDate;
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? stats;
  final Map<String, dynamic>? currentStreak;

  const DayState({
    required this.days,
    required this.selectedDate,
    this.isLoading = false,
    this.error,
    this.stats,
    this.currentStreak,
  });

  DayState copyWith({
    List<DayEntity>? days,
    DateTime? selectedDate,
    bool? isLoading,
    String? error,
    Map<String, dynamic>? stats,
    Map<String, dynamic>? currentStreak,
  }) {
    return DayState(
      days: days ?? this.days,
      selectedDate: selectedDate ?? this.selectedDate,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      stats: stats ?? this.stats,
      currentStreak: currentStreak ?? this.currentStreak,
    );
  }

  // Helper methods
  DayEntity getSelectedDay() {
    return days.firstWhere(
      (day) => day.date.isAtSameMomentAs(selectedDate),
      orElse: () => DayEntity.empty(selectedDate),
    );
  }

  List<DayEntity> getDaysForMonth(int year, int month) {
    return days.where((day) {
      return day.date.year == year && day.date.month == month;
    }).toList();
  }

  List<DayEntity> getDaysForYear(int year) {
    return days.where((day) => day.date.year == year).toList();
  }

  bool isDayMarked(DateTime date) {
    return days.any((day) => day.date.isAtSameMomentAs(date));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DayState &&
        const ListEquality().equals(other.days, days) &&
        other.selectedDate == selectedDate &&
        other.isLoading == isLoading &&
        other.error == error &&
        const MapEquality().equals(other.stats, stats) &&
        const MapEquality().equals(other.currentStreak, currentStreak);
  }

  @override
  int get hashCode {
    return Object.hash(
      const ListEquality().hash(days),
      selectedDate,
      isLoading,
      error,
      const MapEquality().hash(stats),
      const MapEquality().hash(currentStreak),
    );
  }
}

/// Notifier pour la gestion des jours
class DayNotifier extends StateNotifier<DayState> {
  final DayRepositoryImpl _repository;
  final Ref _ref;

  DayNotifier(this._repository, this._ref)
      : super(DayState(
          days: [],
          selectedDate: DateTime.now(),
        ));

  // Charger tous les jours
  Future<void> loadDays() async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _repository.getDaysForYear(2026);
    
    result.when(
      success: (days) {
        state = state.copyWith(
          days: days,
          isLoading: false,
        );
        _loadStats();
        _loadCurrentStreak();
      },
      error: (message, error, stackTrace) {
        state = state.copyWith(
          isLoading: false,
          error: message,
        );
        _ref.setError(message);
      },
      loading: () {
        state = state.copyWith(isLoading: true);
      },
    );
  }

  // Sauvegarder un jour
  Future<void> saveDay(DayEntity day) async {
    final result = await _repository.saveDay(day);
    
    result.when(
      success: (_) {
        // Mettre à jour la liste locale
        final index = state.days.indexWhere((d) => d.date.isAtSameMomentAs(day.date));
        final newDays = List<DayEntity>.from(state.days);
        
        if (index != -1) {
          newDays[index] = day;
        } else {
          newDays.add(day);
        }
        
        state = state.copyWith(days: newDays);
        _loadStats();
        _loadCurrentStreak();
        _ref.setSuccess('Jour sauvegardé avec succès');
      },
      error: (message, error, stackTrace) {
        _ref.setError(message);
      },
      loading: () {},
    );
  }

  // Sauvegarder plusieurs jours
  Future<void> saveDays(List<DayEntity> days) async {
    final result = await _repository.saveDays(days);
    
    result.when(
      success: (_) {
        final newDays = List<DayEntity>.from(state.days);
        for (final day in days) {
          final index = newDays.indexWhere((d) => d.date.isAtSameMomentAs(day.date));
          if (index != -1) {
            newDays[index] = day;
          } else {
            newDays.add(day);
          }
        }
        
        state = state.copyWith(days: newDays);
        _loadStats();
        _loadCurrentStreak();
        _ref.setSuccess('Jours sauvegardés avec succès');
      },
      error: (message, error, stackTrace) {
        _ref.setError(message);
      },
      loading: () {},
    );
  }

  // Obtenir un jour spécifique
  Future<DayEntity?> getDay(DateTime date) async {
    final result = await _repository.getDay(date);
    
    return result.when(
      success: (day) => day,
      error: (message, error, stackTrace) {
        _ref.setError(message);
        return null;
      },
      loading: () => null,
    );
  }

  // Obtenir le résumé du mois
  Future<MonthSummaryEntity?> getMonthSummary(int year, int month) async {
    final result = await _repository.getMonthSummary(year, month);
    
    return result.when(
      success: (summary) => summary,
      error: (message, error, stackTrace) {
        _ref.setError(message);
        return null;
      },
      loading: () => null,
    );
  }

  // Obtenir le résumé de l'année
  Future<YearSummaryEntity?> getYearSummary(int year) async {
    final result = await _repository.getYearSummary(year);
    
    return result.when(
      success: (summary) => summary,
      error: (message, error, stackTrace) {
        _ref.setError(message);
        return null;
      },
      loading: () => null,
    );
  }

  // Supprimer un jour
  Future<void> deleteDay(DateTime date) async {
    final result = await _repository.deleteDay(date);
    
    result.when(
      success: (_) {
        final newDays = state.days.where((d) => !d.date.isAtSameMomentAs(date)).toList();
        state = state.copyWith(days: newDays);
        _loadStats();
        _loadCurrentStreak();
        _ref.setSuccess('Jour supprimé avec succès');
      },
      error: (message, error, stackTrace) {
        _ref.setError(message);
      },
      loading: () {},
    );
  }

  // Effacer tous les jours
  Future<void> clearAllDays() async {
    final result = await _repository.clearAllDays();
    
    result.when(
      success: (_) {
        state = state.copyWith(days: []);
        _loadStats();
        _loadCurrentStreak();
        _ref.setSuccess('Tous les jours ont été effacés');
      },
      error: (message, error, stackTrace) {
        _ref.setError(message);
      },
      loading: () {},
    );
  }

  // Changer la date sélectionnée
  void setSelectedDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  // Charger les statistiques
  Future<void> _loadStats() async {
    final result = await _repository.getStats();
    
    result.when(
      success: (stats) {
        state = state.copyWith(stats: stats);
      },
      error: (message, error, stackTrace) {
        // Ne pas afficher l'erreur, juste la logger
        debugPrint('Erreur lors du chargement des stats: $message');
      },
      loading: () {},
    );
  }

  // Charger la série actuelle
  Future<void> _loadCurrentStreak() async {
    final result = await _repository.getCurrentStreak();
    
    result.when(
      success: (streak) {
        state = state.copyWith(currentStreak: streak);
      },
      error: (message, error, stackTrace) {
        debugPrint('Erreur lors du chargement de la série: $message');
      },
      loading: () {},
    );
  }

  // Obtenir le dernier jour marqué
  Future<DateTime?> getLastMarkedDay() async {
    final result = await _repository.getLastMarkedDay();
    
    return result.when(
      success: (date) => date,
      error: (message, error, stackTrace) {
        debugPrint('Erreur: $message');
        return null;
      },
      loading: () => null,
    );
  }

  // Vérifier si un jour existe
  Future<bool> dayExists(DateTime date) async {
    final result = await _repository.dayExists(date);
    
    return result.when(
      success: (exists) => exists,
      error: (message, error, stackTrace) {
        debugPrint('Erreur: $message');
        return false;
      },
      loading: () => false,
    );
  }

  // Marquer le jour actuel
  void markToday(DayStatusValue value) {
    final today = DateTime.now();
    final day = DayEntity(date: today, value: value);
    saveDay(day);
    setSelectedDate(today);
  }

  // Obtenir le pourcentage de bons jours
  double getGoodPercentage(int year) {
    final yearDays = state.getDaysForYear(year);
    final markedDays = yearDays.where((day) => day.isMarked).toList();
    
    if (markedDays.isEmpty) return 0;
    
    final goodDays = markedDays.where((day) => day.isGoodDay).length;
    return (goodDays / markedDays.length) * 100;
  }
}

/// Providers Riverpod
final dayProvider = StateNotifierProvider<DayNotifier, DayState>((ref) {
  final repository = ref.watch(dayRepositoryProvider);
  return DayNotifier(repository, ref)..loadDays();
});

final selectedDayProvider = Provider<DayEntity>((ref) {
  final state = ref.watch(dayProvider);
  return state.getSelectedDay();
});

final monthDaysProvider = Provider.family<List<DayEntity>, DateTime>((ref, date) {
  final state = ref.watch(dayProvider);
  return state.getDaysForMonth(date.year, date.month);
});

final yearDaysProvider = Provider.family<List<DayEntity>, int>((ref, year) {
  final state = ref.watch(dayProvider);
  return state.getDaysForYear(year);
});

final monthSummaryProvider = FutureProvider.family<MonthSummaryEntity?, DateTime>((ref, date) async {
  final notifier = ref.watch(dayProvider.notifier);
  return await notifier.getMonthSummary(date.year, date.month);
});

final yearSummaryProvider = FutureProvider.family<YearSummaryEntity?, int>((ref, year) async {
  final notifier = ref.watch(dayProvider.notifier);
  return await notifier.getYearSummary(year);
});

final dayExistsProvider = FutureProvider.family<bool, DateTime>((ref, date) async {
  final notifier = ref.watch(dayProvider.notifier);
  return await notifier.dayExists(date);
});

final lastMarkedDayProvider = FutureProvider<DateTime?>((ref) async {
  final notifier = ref.watch(dayProvider.notifier);
  return await notifier.getLastMarkedDay();
});

final goodPercentageProvider = Provider.family<double, int>((ref, year) {
  final notifier = ref.watch(dayProvider.notifier);
  return notifier.getGoodPercentage(year);
});