import 'day_entity.dart';

/// Résumé mensuel - Statistiques et métadonnées pour un mois
class MonthSummaryEntity {
  final int year;
  final int month;
  final List<DayEntity> days;
  final DateTime startDate;
  final DateTime endDate;

  MonthSummaryEntity({
    required this.year,
    required this.month,
    required this.days,
  })  : startDate = DateTime(year, month, 1),
        endDate = DateTime(year, month + 1, 0);

  /// Nom du mois
  String get monthName {
    const months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];
    return months[month - 1];
  }

  /// Nom court du mois
  String get shortMonthName {
    const months = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
      'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    return months[month - 1];
  }

  /// Jours marqués (bons ou mauvais)
  List<DayEntity> get markedDays => days.where((day) => day.isMarked).toList();

  /// Bons jours
  List<DayEntity> get goodDays => days.where((day) => day.isGoodDay).toList();

  /// Mauvais jours
  List<DayEntity> get badDays => days.where((day) => day.isBadDay).toList();

  /// Jours neutres (non marqués ou explicitement neutres)
  List<DayEntity> get neutralDays =>
      days.where((day) => day.value == DayStatusValue.neutral).toList();

  /// Nombre total de jours dans le mois
  int get totalDays => endDate.day;

  /// Nombre de jours marqués
  int get markedDaysCount => markedDays.length;

  /// Nombre de bons jours
  int get goodDaysCount => goodDays.length;

  /// Nombre de mauvais jours
  int get badDaysCount => badDays.length;

  /// Nombre de jours neutres
  int get neutralDaysCount => neutralDays.length;

  /// Pourcentage de jours marqués
  double get markedPercentage {
    return totalDays > 0 ? (markedDaysCount / totalDays) * 100 : 0;
  }

  /// Pourcentage de bons jours parmi les jours marqués
  double get goodPercentage {
    return markedDaysCount > 0 ? (goodDaysCount / markedDaysCount) * 100 : 0;
  }

  /// Pourcentage de mauvais jours parmi les jours marqués
  double get badPercentage {
    return markedDaysCount > 0 ? (badDaysCount / markedDaysCount) * 100 : 0;
  }

  /// Tendance du mois (amélioration, détérioration, stable)
  MonthTrend get trend {
    if (markedDaysCount < 2) return MonthTrend.stable;

    // Analyse des 10 derniers jours marqués
    final recentMarkedDays = markedDays
        .where((day) => day.date.isAfter(endDate.subtract(const Duration(days: 10))))
        .toList();

    if (recentMarkedDays.length < 2) return MonthTrend.stable;

    final recentGoodDays = recentMarkedDays.where((day) => day.isGoodDay).length;
    final recentBadDays = recentMarkedDays.where((day) => day.isBadDay).length;

    if (recentGoodDays > recentBadDays * 1.5) return MonthTrend.improving;
    if (recentBadDays > recentGoodDays * 1.5) return MonthTrend.declining;

    return MonthTrend.stable;
  }

  /// Jour le plus marqué (si applicable)
  DayEntity? get mostFrequentDayType {
    if (markedDaysCount == 0) return null;
    return goodDaysCount >= badDaysCount ? goodDays.first : badDays.first;
  }

  /// Série continue de bons jours
  int get longestGoodStreak {
    return _calculateLongestStreak(DayStatusValue.good);
  }

  /// Série continue de mauvais jours
  int get longestBadStreak {
    return _calculateLongestStreak(DayStatusValue.bad);
  }

  /// Calcule la série la plus longue pour un type de jour donné
  int _calculateLongestStreak(DayStatusValue value) {
    int currentStreak = 0;
    int maxStreak = 0;

    for (final day in days) {
      if (day.value == value) {
        currentStreak++;
        maxStreak = maxStreak > currentStreak ? maxStreak : currentStreak;
      } else {
        currentStreak = 0;
      }
    }

    return maxStreak;
  }

  /// Moyenne de jours par semaine
  Map<String, double> get weeklyAverage {
    final Map<String, int> weekdayCounts = {
      'Lundi': 0,
      'Mardi': 0,
      'Mercredi': 0,
      'Jeudi': 0,
      'Vendredi': 0,
      'Samedi': 0,
      'Dimanche': 0,
    };

    for (final day in markedDays) {
      final weekday = day.date.weekday;
      final weekdayName = _getWeekdayName(weekday);
      weekdayCounts[weekdayName] = weekdayCounts[weekdayName]! + 1;
    }

    final weeksInMonth = totalDays / 7;
    return weekdayCounts.map((key, value) => MapEntry(key, value / weeksInMonth));
  }

  /// Formatte le mois pour l'affichage
  String get formattedMonth => '$monthName $year';

  @override
  String toString() {
    return 'MonthSummaryEntity($formattedMonth, '
        'marqués: $markedDaysCount/$totalDays, '
        'bons: $goodDaysCount, '
        'mauvais: $badDaysCount)';
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1: return 'Lundi';
      case 2: return 'Mardi';
      case 3: return 'Mercredi';
      case 4: return 'Jeudi';
      case 5: return 'Vendredi';
      case 6: return 'Samedi';
      case 7: return 'Dimanche';
      default: return '';
    }
  }
}

/// Tendance mensuelle
enum MonthTrend {
  improving('↑ Amélioration', 'Le mois s\'améliore', '🟢'),
  declining('↓ Détérioration', 'Le mois se détériore', '🔴'),
  stable('→ Stable', 'Le mois reste stable', '⚪');

  final String label;
  final String description;
  final String emoji;

  const MonthTrend(this.label, this.description, this.emoji);
}