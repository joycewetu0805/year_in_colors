import 'dart:math' as math;
import 'day_entity.dart';
import 'month_summary_entity.dart';

/// Résumé annuel - Statistiques et métadonnées pour une année complète
class YearSummaryEntity {
  final int year;
  final List<DayEntity> days;
  final List<MonthSummaryEntity> months;

  const YearSummaryEntity({
    required this.year,
    required this.days,
    required this.months,
  });

  factory YearSummaryEntity.fromDays(int year, List<DayEntity> days) {
    final months = <MonthSummaryEntity>[];
    
    for (int month = 1; month <= 12; month++) {
      final monthDays = days.where((day) => day.date.month == month).toList();
      months.add(MonthSummaryEntity(
        year: year,
        month: month,
        days: monthDays,
      ));
    }
    
    return YearSummaryEntity(
      year: year,
      days: days,
      months: months,
    );
  }

  /// Jours marqués dans l'année
  List<DayEntity> get markedDays => days.where((day) => day.isMarked).toList();

  /// Bons jours dans l'année
  List<DayEntity> get goodDays => days.where((day) => day.isGoodDay).toList();

  /// Mauvais jours dans l'année
  List<DayEntity> get badDays => days.where((day) => day.isBadDay).toList();

  /// Jours neutres dans l'année
  List<DayEntity> get neutralDays =>
      days.where((day) => day.value == DayStatusValue.neutral).toList();

  /// Nombre total de jours dans l'année (365 ou 366)
  int get totalDays => DateTime(year, 12, 31).difference(DateTime(year, 1, 1)).inDays + 1;

  /// Nombre de jours marqués
  int get markedDaysCount => markedDays.length;

  /// Nombre de bons jours
  int get goodDaysCount => goodDays.length;

  /// Nombre de mauvais jours
  int get badDaysCount => badDays.length;

  /// Nombre de jours neutres
  int get neutralDaysCount => neutralDays.length;

  /// Pourcentage de jours marqués dans l'année
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

  /// Mois le plus productif (avec le plus de bons jours)
  MonthSummaryEntity? get bestMonth {
    if (months.isEmpty) return null;
    
    return months.reduce((a, b) {
      return a.goodDaysCount > b.goodDaysCount ? a : b;
    });
  }

  /// Mois le plus difficile (avec le plus de mauvais jours)
  MonthSummaryEntity? get worstMonth {
    if (months.isEmpty) return null;
    
    return months.reduce((a, b) {
      return a.badDaysCount > b.badDaysCount ? a : b;
    });
  }

  /// Mois le plus actif (avec le plus de jours marqués)
  MonthSummaryEntity? get mostActiveMonth {
    if (months.isEmpty) return null;
    
    return months.reduce((a, b) {
      return a.markedDaysCount > b.markedDaysCount ? a : b;
    });
  }

  /// Tendance annuelle
  YearTrend get trend {
    if (months.length < 3) return YearTrend.neutral;

    // Analyse des 3 derniers mois
    final recentMonths = months.sublist(math.max(0, months.length - 3));
    final improvingMonths = recentMonths.where((m) => m.trend == MonthTrend.improving).length;
    final decliningMonths = recentMonths.where((m) => m.trend == MonthTrend.declining).length;

    if (improvingMonths >= 2) return YearTrend.improving;
    if (decliningMonths >= 2) return YearTrend.declining;
    if (goodPercentage >= 70) return YearTrend.excellent;
    if (goodPercentage >= 40) return YearTrend.good;
    
    return YearTrend.neutral;
  }

  /// Série la plus longue de bons jours
  int get longestGoodStreak {
    return _calculateLongestStreak(DayStatusValue.good);
  }

  /// Série la plus longue de mauvais jours
  int get longestBadStreak {
    return _calculateLongestStreak(DayStatusValue.bad);
  }

  /// Calcule la série la plus longue pour un type de jour
  int _calculateLongestStreak(DayStatusValue value) {
    int currentStreak = 0;
    int maxStreak = 0;

    // Trie les jours par date
    final sortedDays = List<DayEntity>.from(days)
      ..sort((a, b) => a.date.compareTo(b.date));

    for (final day in sortedDays) {
      if (day.value == value) {
        currentStreak++;
        maxStreak = maxStreak > currentStreak ? maxStreak : currentStreak;
      } else {
        currentStreak = 0;
      }
    }

    return maxStreak;
  }

  /// Distribution par jour de la semaine
  Map<String, double> get weekdayDistribution {
    final Map<String, int> counts = {
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
      counts[weekdayName] = counts[weekdayName]! + 1;
    }

    final total = markedDaysCount.toDouble();
    return counts.map((key, value) => MapEntry(key, total > 0 ? (value / total) * 100 : 0));
  }

  /// Distribution par mois
  Map<String, double> get monthlyDistribution {
    final Map<String, double> distribution = {};

    for (final month in months) {
      distribution[month.shortMonthName] = month.markedPercentage;
    }

    return distribution;
  }

  /// Message d'encouragement personnalisé basé sur les statistiques
  String get encouragementMessage {
    if (markedDaysCount == 0) {
      return 'Commence à marquer tes journées pour voir ton année en couleurs !';
    }

    if (goodPercentage >= 80) {
      return 'Fantastique ! Tu as passé $goodPercentage% de bons jours cette année. Continue comme ça !';
    } else if (goodPercentage >= 60) {
      return 'Très bonne année ! $goodPercentage% de jours positifs, c\'est remarquable.';
    } else if (goodPercentage >= 40) {
      return 'Belle année équilibrée avec $goodPercentage% de bons jours.';
    } else if (goodPercentage >= 20) {
      return 'Une année avec ses hauts et ses bas. $goodPercentage% de bons jours.';
    } else {
      return 'Une année difficile avec $goodPercentage% de bons jours. Chaque nouveau jour est une nouvelle opportunité.';
    }
  }

  /// Résumé textuel pour le partage
  String get shareableSummary {
    return '''
📊 Année $year - Year in Colors

🎯 Jours marqués: $markedDaysCount/$totalDays (${markedPercentage.toStringAsFixed(1)}%)
🟢 Bons jours: $goodDaysCount (${goodPercentage.toStringAsFixed(1)}%)
🔴 Mauvais jours: $badDaysCount (${badPercentage.toStringAsFixed(1)}%)

🏆 Meilleur mois: ${bestMonth?.shortMonthName ?? 'N/A'}
💪 Série la plus longue de bons jours: ${longestGoodStreak} jours

$encouragementMessage
    ''';
  }

  /// Formatte l'année pour l'affichage
  String get formattedYear => 'Année $year';

  @override
  String toString() {
    return 'YearSummaryEntity($year, '
        'marqués: $markedDaysCount/$totalDays, '
        'bons: $goodDaysCount (${goodPercentage.toStringAsFixed(1)}%), '
        'mauvais: $badDaysCount (${badPercentage.toStringAsFixed(1)}%))';
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

/// Tendance annuelle
enum YearTrend {
  excellent('⭐ Excellente', 'Année exceptionnelle', '🌟🌟'),
  improving('📈 En amélioration', 'L\'année s\'améliore progressivement', '📈'),
  good('👍 Bonne', 'Bonne année dans l\'ensemble', '👍'),
  neutral('⚖️ Neutre', 'Année équilibrée', '⚖️'),
  declining('📉 En déclin', 'L\'année se détériore', '📉');

  final String label;
  final String description;
  final String emoji;

  const YearTrend(this.label, this.description, this.emoji);
}