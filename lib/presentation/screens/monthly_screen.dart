import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/day_entity.dart';
import '../providers/day_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/month_calendar.dart';
import '../widgets/stats_card.dart';
import '../animations/fade_animation.dart';
import '../../core/utils/date_utils.dart' as app_date;

/// Écran mensuel - Vue calendrier et statistiques
class MonthlyScreen extends ConsumerStatefulWidget {
  const MonthlyScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MonthlyScreen> createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends ConsumerState<MonthlyScreen> {
  late DateTime _currentMonth;
  late PageController _pageController;
  late int _currentYear;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentYear = now.year;
    _currentMonth = DateTime(_currentYear, now.month);
    _pageController = PageController(initialPage: now.month - 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPreviousMonth() {
    if (_currentMonth.month > 1) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextMonth() {
    if (_currentMonth.month < 12) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentMonth = DateTime(_currentYear, page + 1);
    });
  }

  void _onDaySelected(DateTime date) {
    ref.read(dayProvider.notifier).setSelectedDate(date);
  }

  Map<String, dynamic> _calculateMonthStats(List<DayEntity> days) {
    final markedDays = days.where((day) => day.isMarked).toList();
    final goodDays = markedDays.where((day) => day.isGoodDay).length;
    final badDays = markedDays.where((day) => day.isBadDay).length;

    return {
      'total': markedDays.length,
      'good': goodDays,
      'bad': badDays,
      'goodPercentage': markedDays.isNotEmpty ? (goodDays / markedDays.length) * 100 : 0.0,
      'badPercentage': markedDays.isNotEmpty ? (badDays / markedDays.length) * 100 : 0.0,
    };
  }

  String _getMonthName(int month) {
    const months = [
      'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
      'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final monthDays = ref.watch(monthDaysProvider(_currentMonth));
    final stats = _calculateMonthStats(monthDays);
    final showAnimations = ref.watch(animationsEnabledProvider);
    final isCurrentMonth = _currentMonth.month == DateTime.now().month &&
        _currentMonth.year == DateTime.now().year;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // En-tête du mois
              _buildMonthHeader(context),
              const SizedBox(height: 20),

              // Calendrier avec pagination
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final monthDate = DateTime(_currentYear, index + 1);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: MonthCalendar(
                        month: monthDate,
                        onDaySelected: _onDaySelected,
                        showAnimations: showAnimations,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Statistiques du mois
              if (stats['total'] > 0)
                showAnimations
                    ? FadeAnimation(child: _buildMonthStats(context, stats))
                    : _buildMonthStats(context, stats),

              // Indicateur de mois actuel
              if (isCurrentMonth)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Mois en cours',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: _currentMonth.month > 1 ? _goToPreviousMonth : null,
            color: _currentMonth.month > 1
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          Column(
            children: [
              Text(
                _getMonthName(_currentMonth.month),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                _currentYear.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: _currentMonth.month < 12 ? _goToNextMonth : null,
            color: _currentMonth.month < 12
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthStats(BuildContext context, Map<String, dynamic> stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            '${stats['total']}',
            'Marqués',
            Theme.of(context).colorScheme.primary,
          ),
          _buildStatItem(
            context,
            '${stats['good']}',
            'Bons',
            Colors.green,
          ),
          _buildStatItem(
            context,
            '${stats['bad']}',
            'Mauvais',
            Colors.red,
          ),
          _buildStatItem(
            context,
            '${(stats['goodPercentage'] as double).round()}%',
            'Taux',
            Colors.blue,
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
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
}
