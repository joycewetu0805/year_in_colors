import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/day_entity.dart';
import '../providers/day_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/year_grid.dart';
import '../animations/fade_animation.dart';
import '../animations/staggered_fade_animation.dart' as staggered;
import '../../core/constants/app_colors.dart';

/// Écran annuel - Vue d'ensemble de l'année
class YearlyScreen extends ConsumerWidget {
  const YearlyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentYear = DateTime.now().year;
    final yearDays = ref.watch(yearDaysProvider(currentYear));
    final yearStats = _calculateYearStats(yearDays);
    final showAnimations = ref.watch(animationsEnabledProvider);
    final goodPercentage = ref.watch(goodPercentageProvider(currentYear));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Titre de l'année
              _buildYearHeader(context, currentYear),
              const SizedBox(height: 24),

              // Grille des mois
              Expanded(
                child: showAnimations
                    ? staggered.StaggeredFadeAnimation(
                        index: 0,
                        itemCount: 1,
                        child: YearGrid(
                          year: currentYear,
                          onMonthSelected: (month) {
                            // Navigation vers écran mensuel
                          },
                          showAnimations: showAnimations,
                        ),
                      )
                    : YearGrid(
                        year: currentYear,
                        onMonthSelected: (month) {},
                        showAnimations: false,
                      ),
              ),

              const SizedBox(height: 24),

              // Statistiques annuelles
              if (yearStats['markedDays'] > 0)
                showAnimations
                    ? FadeAnimation(child: _buildYearStats(context, yearStats, goodPercentage, currentYear))
                    : _buildYearStats(context, yearStats, goodPercentage, currentYear),

              // Message pour nouvelle année
              if (yearStats['markedDays'] == 0)
                showAnimations
                    ? FadeAnimation(child: _buildEmptyYearMessage(context, currentYear))
                    : _buildEmptyYearMessage(context, currentYear),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYearHeader(BuildContext context, int year) {
    return Column(
      children: [
        Text(
          year.toString(),
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: -1,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.circle,
              size: 8,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'Année en cours',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildYearStats(BuildContext context, Map<String, dynamic> stats, double goodPercentage, int year) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // Pourcentage principal
          Text(
            '${goodPercentage.round()}%',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: _getProgressColor(goodPercentage),
            ),
          ),
          Text(
            'de jours positifs',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 16),
          // Statistiques détaillées
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(context, '${stats['markedDays']}', 'Marqués', Theme.of(context).colorScheme.primary),
              _buildStatItem(context, '${stats['goodDays']}', 'Bons', AppColors.goodDay),
              _buildStatItem(context, '${stats['badDays']}', 'Mauvais', AppColors.badDay),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
        ),
      ],
    );
  }

  Widget _buildEmptyYearMessage(BuildContext context, int year) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.emoji_emotions_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Commence ton année $year !',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Marque tes premiers jours pour voir ton année prendre vie en couleurs.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(double percentage) {
    if (percentage >= 70) return AppColors.goodDay;
    if (percentage >= 40) return Colors.amber;
    return AppColors.badDay;
  }

  Map<String, dynamic> _calculateYearStats(List<DayEntity> days) {
    final markedDays = days.where((day) => day.isMarked).toList();
    final goodDays = markedDays.where((day) => day.isGoodDay).length;
    final badDays = markedDays.where((day) => day.isBadDay).length;

    return {
      'markedDays': markedDays.length,
      'goodDays': goodDays,
      'badDays': badDays,
      'completionRate': (markedDays.length / 365) * 100,
      'goodPercentage': markedDays.isNotEmpty ? (goodDays / markedDays.length) * 100 : 0.0,
      'badPercentage': markedDays.isNotEmpty ? (badDays / markedDays.length) * 100 : 0.0,
    };
  }
}
