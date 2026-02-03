import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/day_entity.dart';
import '../providers/day_provider.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_colors.dart';
import '../animations/scale_tap_animation.dart';
import '../animations/staggered_fade_animation.dart';

/// Grille annuelle des 12 mois
class YearGrid extends ConsumerWidget {
  final int year;
  final Function(int) onMonthSelected;
  final bool showAnimations;

  const YearGrid({
    Key? key,
    required this.year,
    required this.onMonthSelected,
    this.showAnimations = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yearDays = ref.watch(yearDaysProvider(year));
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;
    
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final month = index + 1;
        final monthDays = _getMonthDays(yearDays, month);
        final stats = _calculateMonthStats(monthDays);
        final isCurrentMonth = month == currentMonth && year == currentYear;
        
        final monthWidget = _buildMonthCell(
          context,
          month: month,
          stats: stats,
          isCurrentMonth: isCurrentMonth,
          onTap: () => onMonthSelected(month),
        );

        if (showAnimations) {
          return StaggeredFadeAnimation(
            index: index,
            itemCount: 12,
            child: monthWidget,
          );
        }

        return monthWidget;
      },
    );
  }

  Widget _buildMonthCell(
    BuildContext context, {
    required int month,
    required Map<String, dynamic> stats,
    required bool isCurrentMonth,
    required VoidCallback onTap,
  }) {
    final cell = GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCurrentMonth
                ? AppColors.accentBlue
                : Theme.of(context).colorScheme.outline.withOpacity(0.1),
            width: isCurrentMonth ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Mois
            Text(
              AppStrings.monthAbbreviation(month),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isCurrentMonth
                    ? AppColors.accentBlue
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Statistiques
            if (stats['markedDays'] > 0) _buildMonthStats(stats),
            
            // Indicateur de mois actuel
            if (isCurrentMonth)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.circle,
                  size: 8,
                  color: AppColors.accentBlue,
                ),
              ),
          ],
        ),
      ),
    );

    if (showAnimations) {
      return ScaleTapAnimation(
        onTap: onTap,
        scaleFactor: 0.95,
        child: cell,
      );
    }

    return cell;
  }

  Widget _buildMonthStats(Map<String, dynamic> stats) {
    return Column(
      children: [
        // Pourcentage de bons jours
        Text(
          '${stats['goodPercentage'].round()}%',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.goodDay,
          ),
        ),
        
        const SizedBox(height: 4),
        
        // Barre de progression
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.neutralDay.withOpacity(0.2),
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: stats['goodPercentage'] / 100,
            child: Container(
              decoration: BoxDecoration(
                color: _getProgressColor(stats['goodPercentage']),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 4),
        
        // Jours marqués
        Text(
          '${stats['markedDays']} jours',
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  List<DayEntity> _getMonthDays(List<DayEntity> yearDays, int month) {
    return yearDays.where((day) => day.date.month == month).toList();
  }

  Map<String, dynamic> _calculateMonthStats(List<DayEntity> days) {
    final markedDays = days.where((day) => day.isMarked).toList();
    final goodDays = markedDays.where((day) => day.isGoodDay).length;
    
    return {
      'markedDays': markedDays.length,
      'goodDays': goodDays,
      'goodPercentage': markedDays.isNotEmpty ? (goodDays / markedDays.length) * 100 : 0,
    };
  }

  Color _getProgressColor(double percentage) {
    if (percentage >= 70) return AppColors.goodDay;
    if (percentage >= 40) return Colors.amber;
    return AppColors.badDay;
  }
}

/// Vue d'ensemble de l'année avec heatmap
class YearHeatmap extends StatelessWidget {
  final List<DayEntity> days;
  final int year;

  const YearHeatmap({
    Key? key,
    required this.days,
    required this.year,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titre
          Text(
            'Heatmap $year',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Heatmap
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 52, // 52 semaines
              childAspectRatio: 1.0,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemCount: 364, // 52 semaines × 7 jours
            itemBuilder: (context, index) {
              final dayOffset = index;
              final date = DateTime(year, 1, 1).add(Duration(days: dayOffset));
              
              if (date.year != year) {
                return const SizedBox.shrink();
              }
              
              final day = days.firstWhere(
                (d) => _isSameDay(d.date, date),
                orElse: () => DayEntity.empty(date),
              );
              
              return Container(
                decoration: BoxDecoration(
                  color: _getHeatmapColor(day),
                  borderRadius: BorderRadius.circular(1),
                ),
              );
            },
          ),
          
          const SizedBox(height: 16),
          
          // Légende
          _buildLegend(context),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Color _getHeatmapColor(DayEntity day) {
    if (!day.isMarked) {
      return Colors.grey[100]!;
    }
    
    switch (day.value) {
      case DayStatusValue.good:
        return AppColors.goodDay;
      case DayStatusValue.bad:
        return AppColors.badDay;
      case DayStatusValue.neutral:
        return AppColors.neutralDay;
    }
  }

  Widget _buildLegend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(AppColors.goodDay, 'Bon jour'),
        const SizedBox(width: 16),
        _buildLegendItem(AppColors.badDay, 'Mauvais jour'),
        const SizedBox(width: 16),
        _buildLegendItem(AppColors.neutralDay, 'Neutre'),
        const SizedBox(width: 16),
        _buildLegendItem(Colors.grey[100]!, 'Non marqué'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}