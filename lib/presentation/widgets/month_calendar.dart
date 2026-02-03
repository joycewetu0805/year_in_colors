import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/day_entity.dart';
import '../providers/day_provider.dart';
import '../../core/constants/app_colors.dart';
import '../animations/scale_animation.dart';

/// Noms des mois
String _monthName(int month) {
  const months = [
    'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
    'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
  ];
  return months[month - 1];
}

String _monthAbbreviation(int month) {
  const months = ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'];
  return months[month - 1];
}

/// Calendrier mensuel compact
class MonthCalendar extends ConsumerWidget {
  final DateTime month;
  final Function(DateTime) onDaySelected;
  final bool showAnimations;

  const MonthCalendar({
    Key? key,
    required this.month,
    required this.onDaySelected,
    this.showAnimations = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = ref.watch(monthDaysProvider(month));
    final selectedDate = ref.watch(dayProvider.select((state) => state.selectedDate));

    // Obtenir le premier jour du mois
    final firstDay = DateTime(month.year, month.month, 1);
    // Obtenir le dernier jour du mois
    final lastDay = DateTime(month.year, month.month + 1, 0);
    
    // Calculer le jour de la semaine du premier jour (0 = dimanche, 6 = samedi)
    // On ajuste pour avoir lundi = 0
    int startingWeekday = firstDay.weekday - 1;

    // Créer la grille du calendrier (6 semaines × 7 jours = 42 cellules)
    final List<Widget> dayWidgets = [];

    // Ajouter les en-têtes des jours de la semaine
    const weekdays = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
    for (final day in weekdays) {
      dayWidgets.add(
        Container(
          alignment: Alignment.center,
          child: Text(
            day,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    // Ajouter les cellules vides avant le premier jour
    for (int i = 0; i < startingWeekday; i++) {
      dayWidgets.add(const SizedBox.shrink());
    }

    // Ajouter les jours du mois
    DateTime currentDay = firstDay;
    while (currentDay.isBefore(lastDay) || currentDay.isAtSameMomentAs(lastDay)) {
      final dayStatus = _getDayStatus(currentDay, days);
      final isToday = _isToday(currentDay);
      final isSelected = _isSameDay(currentDay, selectedDate);

      dayWidgets.add(
        _buildDayCell(
          context,
          day: currentDay,
          status: dayStatus,
          isToday: isToday,
          isSelected: isSelected,
        ),
      );
      currentDay = currentDay.add(const Duration(days: 1));
    }

    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 7,
      childAspectRatio: 1.0,
      padding: EdgeInsets.zero,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: dayWidgets,
    );
  }

  Widget _buildDayCell(
    BuildContext context, {
    required DateTime day,
    required DayEntity status,
    required bool isToday,
    required bool isSelected,
  }) {
    final cell = GestureDetector(
      onTap: () => onDaySelected(day),
      child: Container(
        decoration: BoxDecoration(
          color: _getDayCellColor(status, isSelected, context),
          shape: BoxShape.circle,
          border: Border.all(
            color: _getDayCellBorderColor(status, isToday, isSelected, context),
            width: _getDayCellBorderWidth(isToday, isSelected),
          ),
        ),
        child: Center(
          child: Text(
            day.day.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              color: _getDayCellTextColor(status, context),
            ),
          ),
        ),
      ),
    );

    if (showAnimations && (isToday || isSelected)) {
      return ScaleAnimation(
        child: cell,
        duration: const Duration(milliseconds: 200),
      );
    }

    return cell;
  }

  DayEntity _getDayStatus(DateTime date, List<DayEntity> days) {
    return days.firstWhere(
      (day) => _isSameDay(day.date, date),
      orElse: () => DayEntity.empty(date),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Color _getStatusColor(DayEntity status) {
    if (status.isGoodDay) return AppColors.goodDay;
    if (status.isBadDay) return AppColors.badDay;
    return AppColors.neutralDay;
  }

  Color _getDayCellColor(DayEntity status, bool isSelected, BuildContext context) {
    if (isSelected) {
      return Theme.of(context).colorScheme.primary.withOpacity(0.1);
    }

    if (status.isMarked) {
      return _getStatusColor(status);
    }

    return Colors.transparent;
  }

  Color _getDayCellBorderColor(
    DayEntity status,
    bool isToday,
    bool isSelected,
    BuildContext context,
  ) {
    if (isSelected) {
      return Theme.of(context).colorScheme.primary;
    }

    if (isToday) {
      return AppColors.accentBlue;
    }

    if (status.isMarked) {
      return _getStatusColor(status);
    }

    return Colors.transparent;
  }

  double _getDayCellBorderWidth(bool isToday, bool isSelected) {
    if (isSelected) return 2.0;
    if (isToday) return 1.5;
    return 0.0;
  }

  Color _getDayCellTextColor(DayEntity status, BuildContext context) {
    if (status.isMarked) {
      return Colors.white;
    }
    
    return Theme.of(context).colorScheme.onSurface.withOpacity(0.6);
  }
}

/// En-tête du calendrier avec navigation
class CalendarHeader extends StatelessWidget {
  final DateTime month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onToday;
  final bool canGoPrevious;
  final bool canGoNext;
  final bool isCurrentMonth;

  const CalendarHeader({
    Key? key,
    required this.month,
    required this.onPrevious,
    required this.onNext,
    required this.onToday,
    this.canGoPrevious = true,
    this.canGoNext = true,
    this.isCurrentMonth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Mois précédent
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: canGoPrevious ? onPrevious : null,
            color: canGoPrevious
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          
          // Mois et année avec indicateur
          Column(
            children: [
              Text(
                '${_monthName(month.month)} ${month.year}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isCurrentMonth)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.accentBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'En cours',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.accentBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          // Mois suivant
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: canGoNext ? onNext : null,
            color: canGoNext
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}

/// Mini calendrier pour les aperçus
class MiniCalendar extends StatelessWidget {
  final DateTime month;
  final Function(DateTime) onDaySelected;
  final double cellSize;

  const MiniCalendar({
    Key? key,
    required this.month,
    required this.onDaySelected,
    this.cellSize = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // En-tête
          Text(
            _monthAbbreviation(month.month),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          
          // Grille simplifiée
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 7,
            childAspectRatio: 1.0,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            children: List.generate(31, (index) {
              final day = index + 1;
              return Container(
                width: cellSize,
                height: cellSize,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    day.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}