import 'package:intl/intl.dart';

/// Utilitaires de date pour Year in Colors
/// Nommé AppDateUtils pour éviter conflit avec Flutter DateUtils
class AppDateUtils {
  static final DateFormat _monthYearFormat = DateFormat('MMMM yyyy', 'fr_FR');
  static final DateFormat _dayMonthYearFormat = DateFormat('d MMMM yyyy', 'fr_FR');
  static final DateFormat _dayNameFormat = DateFormat('EEEE', 'fr_FR');
  static final DateFormat _monthAbbrFormat = DateFormat('MMM', 'fr_FR');
  
  static String formatMonthYear(DateTime date) {
    return _monthYearFormat.format(date);
  }
  
  static String formatDayMonthYear(DateTime date) {
    return _dayMonthYearFormat.format(date);
  }
  
  static String getDayName(DateTime date) {
    return _dayNameFormat.format(date);
  }
  
  static String getMonthAbbreviation(int month) {
    final date = DateTime(2026, month);
    return _monthAbbrFormat.format(date);
  }
  
  static List<String> getMonthNames() {
    return [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];
  }
  
  static List<String> getWeekdayAbbreviations() {
    return ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
  }
  
  static List<DateTime> getDaysInMonth(DateTime date) {
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    
    final days = <DateTime>[];
    var currentDay = firstDay;
    
    while (currentDay.isBefore(lastDay) || currentDay.isAtSameMomentAs(lastDay)) {
      days.add(currentDay);
      currentDay = currentDay.add(const Duration(days: 1));
    }
    
    return days;
  }
  
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
  
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return isSameDay(now, date);
  }
  
  static bool isInCurrentYear(DateTime date) {
    return date.year == DateTime.now().year;
  }

  static int getDaysInYear([int? year]) {
    final y = year ?? DateTime.now().year;
    return DateTime(y, 12, 31).difference(DateTime(y, 1, 1)).inDays + 1;
  }
}