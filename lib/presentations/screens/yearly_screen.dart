import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/day_provider.dart';
import '../widgets/year_grid.dart';
import '../widgets/stats_card.dart';
import '../animations/fade_animation.dart';
import '../animations/staggered_fade_animation.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_colors.dart';

/// Écran annuel - Vue d'ensemble de l'année
class YearlyScreen extends ConsumerWidget {
  const YearlyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yearDays = ref.watch(yearDaysProvider(2026));
    final yearStats = _calculateYearStats(yearDays);
    final showAnimations = ref.watch(animationsEnabledProvider);
    final goodPercentage = ref.watch(goodPercentageProvider(2026));
    final isCurrentYear = DateTime.now().year == 2026;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Titre de l'année
              _buildYearHeader(isCurrentYear),
              const SizedBox(height: 24),
              
              // Grille des mois
              Expanded(
                child: showAnimations
                    ? StaggeredFadeAnimation(
                        index: 0,
                        itemCount: 1,
                        child: YearGrid(
                          year: 2026,
                          onMonthSelected: (month) {
                            _navigateToMonth(context, month);
                          },
                          showAnimations: showAnimations,
                        ),
                      )
                    : YearGrid(
                        year: 2026,
                        onMonthSelected: (month) {
                          _navigateToMonth(context, month);
                        },
                        showAnimations: false,
                      ),
              ),
              
              const SizedBox(height: 24),
              
              // Message annuel
              if (yearStats['markedDays'] > 0)
                FadeAnimation(
                  child: _buildYearMessage(goodPercentage),
                  autoPlay: false,
                ),
              
              const SizedBox(height: 20),
              
              // Statistiques annuelles
              if (yearStats['markedDays'] > 0)
                FadeAnimation(
                  child: _buildYearStats(yearStats),
                  autoPlay: false,
                ),
              
              // Message pour nouvelle année
              if (yearStats['markedDays'] == 0)
                FadeAnimation(
                  child: _buildEmptyYearMessage(),
                  autoPlay: false,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYearHeader(bool isCurrentYear) {
    return Column(
      children: [
        Text(
          '2026',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: -1,
          ),
        ),
        if (isCurrentYear)
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

  Widget _buildYearMessage(double goodPercentage) {
    String message;
    Color color;

    if (goodPercentage >= 70) {
      message = 'Excellente année ! 🎉\n${goodPercentage.round()}% de jours positifs';
      color = AppColors.goodDay;
    } else if (goodPercentage >= 40) {
      message = 'Belle année 👍\n${goodPercentage.round()}% de bons jours';
      color = Colors.amber;
    } else {
      message = 'Année avec ses défis 💪\n${goodPercentage.round()}% de jours positifs';
      color = AppColors.badDay;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: color,
          height: 1.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildYearStats(Map<String, dynamic> stats) {
    return StatsCard(
      title: 'Bilan 2026',
      stats: {
        'Jours marqués': '${stats['markedDays']} (${stats['completionRate'].round()}%)',
        'Bons jours': '${stats['goodDays']} (${stats['goodPercentage'].round()}%)',
        'Mauvais jours': '${stats['badDays']} (${stats['badPercentage'].round()}%)',
        'Série la plus longue': '${stats['longestStreak']} jours',
      },
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildEmptyYearMessage() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
            'Commence ton année 2026 !',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Marque tes premiers jours comme bons ou mauvais pour voir ton année prendre vie en couleurs.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _calculateYearStats(List<DayEntity> days) {
    final markedDays = days.where((day) => day.isMarked).toList();
    final goodDays = markedDays.where((day) => day.isGoodDay).length;
    final badDays = markedDays.where((day) => day.isBadDay).length;
    
    // Calculer la série la plus longue de bons jours
    int longestStreak = 0;
    int currentStreak = 0;
    
    final sortedDays = List<DayEntity>.from(markedDays)
      ..sort((a, b) => a.date.compareTo(b.date));
    
    for (final day in sortedDays) {
      if (day.isGoodDay) {
        currentStreak++;
        longestStreak = currentStreak > longestStreak ? currentStreak : longestStreak;
      } else {
        currentStreak = 0;
      }
    }

    return {
      'markedDays': markedDays.length,
      'goodDays': goodDays,
      'badDays': badDays,
      'completionRate': (markedDays.length / 365) * 100,
      'goodPercentage': markedDays.isNotEmpty ? (goodDays / markedDays.length) * 100 : 0,
      'badPercentage': markedDays.isNotEmpty ? (badDays / markedDays.length) * 100 : 0,
      'longestStreak': longestStreak,
    };
  }

  void _navigateToMonth(BuildContext context, int month) {
    // Naviguer vers l'écran mensuel
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MonthlyScreen.withMonth(2026, month),
      ),
    );
  }
}

/// Vue d'ensemble de l'année pour le partage
class YearOverviewWidget extends StatelessWidget {
  final Map<String, dynamic> stats;
  final double goodPercentage;

  const YearOverviewWidget({
    Key? key,
    required this.stats,
    required this.goodPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surface.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Titre
          Text(
            '2026 - Year in Colors',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          
          // Cercle de progression
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: goodPercentage / 100,
                  strokeWidth: 8,
                  color: _getProgressColor(goodPercentage),
                  backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.3),
                ),
              ),
              Text(
                '${goodPercentage.round()}%',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _getProgressColor(goodPercentage),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Statistiques
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context,
                '🟢',
                'Bons jours',
                stats['goodDays'].toString(),
              ),
              _buildStatItem(
                context,
                '🔴',
                'Mauvais jours',
                stats['badDays'].toString(),
              ),
              _buildStatItem(
                context,
                '📅',
                'Jours marqués',
                '${stats['markedDays']}/365',
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Message
          Text(
            _getYearMessage(goodPercentage),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String icon, String label, String value) {
    return Column(
      children: [
        Text(
          icon,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(double percentage) {
    if (percentage >= 70) return AppColors.goodDay;
    if (percentage >= 40) return Colors.amber;
    return AppColors.badDay;
  }

  String _getYearMessage(double percentage) {
    if (percentage >= 80) return 'Année exceptionnelle ! 🌟';
    if (percentage >= 60) return 'Très bonne année ! 🎯';
    if (percentage >= 40) return 'Belle année ! 👍';
    if (percentage >= 20) return 'Année avec du caractère 💪';
    return 'Année de croissance 📈';
  }
}