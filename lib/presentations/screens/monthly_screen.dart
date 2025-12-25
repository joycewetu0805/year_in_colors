import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/day_provider.dart';
import '../widgets/month_calendar.dart';
import '../widgets/stats_card.dart';
import '../animations/fade_animation.dart';
import '../animations/slide_animation.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/date_utils.dart';

/// Écran mensuel - Vue calendrier et statistiques
class MonthlyScreen extends ConsumerStatefulWidget {
  const MonthlyScreen({Key? key}) : super(key: key);

  static Widget withMonth(int year, int month) {
    return MonthlyScreen._withMonth(year, month);
  }

  const MonthlyScreen._withMonth(this._initialYear, this._initialMonth, {Key? key}) : super(key: key);

  final int? _initialYear;
  final int? _initialMonth;

  @override
  _MonthlyScreenState createState() => _MonthlyScreenState();
}

class _MonthlyScreenState extends ConsumerState<MonthlyScreen> {
  late DateTime _currentMonth;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    if (widget._initialYear != null && widget._initialMonth != null) {
      _currentMonth = DateTime(widget._initialYear!, widget._initialMonth!);
    } else {
      _currentMonth = DateTime.now();
      if (_currentMonth.year != 2026) {
        _currentMonth = DateTime(2026, 1, 1);
      }
    }
    
    _currentPage = _currentMonth.month - 1;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPreviousMonth() {
    final newMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    if (newMonth.year >= 2026) {
      setState(() {
        _currentMonth = newMonth;
        _currentPage = _currentMonth.month - 1;
      });
      _pageController.jumpToPage(_currentPage);
    }
  }

  void _goToNextMonth() {
    final newMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    if (newMonth.year <= 2026) {
      setState(() {
        _currentMonth = newMonth;
        _currentPage = _currentMonth.month - 1;
      });
      _pageController.jumpToPage(_currentPage);
    }
  }

  void _goToToday() {
    final now = DateTime.now();
    if (now.year == 2026) {
      setState(() {
        _currentMonth = DateTime(now.year, now.month);
        _currentPage = _currentMonth.month - 1;
      });
      _pageController.jumpToPage(_currentPage);
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentMonth = DateTime(2026, page + 1);
      _currentPage = page;
    });
  }

  void _onDaySelected(DateTime date) {
    // Naviguer vers TodayScreen avec la date sélectionnée
    ref.read(dayProvider.notifier).setSelectedDate(date);
    // Si vous avez une navigation par onglets, vous pouvez naviguer vers TodayScreen
    // Pour l'instant, on reste sur le même écran mais on pourrait ouvrir un modal
  }

  Map<String, dynamic> _calculateMonthStats(List<DayEntity> days) {
    final markedDays = days.where((day) => day.isMarked).toList();
    final goodDays = markedDays.where((day) => day.isGoodDay).length;
    final badDays = markedDays.where((day) => day.isBadDay).length;
    final neutralDays = markedDays.where((day) => day.value == DayStatusValue.neutral).length;

    return {
      'total': markedDays.length,
      'good': goodDays,
      'bad': badDays,
      'neutral': neutralDays,
      'goodPercentage': markedDays.isNotEmpty ? (goodDays / markedDays.length) * 100 : 0,
      'badPercentage': markedDays.isNotEmpty ? (badDays / markedDays.length) * 100 : 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    final monthDays = ref.watch(monthDaysProvider(_currentMonth));
    final stats = _calculateMonthStats(monthDays);
    final showAnimations = ref.watch(animationsEnabledProvider);
    final isCurrentMonth = _currentMonth.month == DateTime.now().month && _currentMonth.year == DateTime.now().year;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // En-tête du mois
              _buildMonthHeader(),
              const SizedBox(height: 20),
              
              // Calendrier avec pagination
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final monthDate = DateTime(2026, index + 1);
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
                FadeAnimation(
                  child: _buildMonthStats(stats),
                  autoPlay: false,
                ),
              
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
  
  Widget _buildMonthHeader() {
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
            onPressed: _currentMonth.month > 1 ? _goToPreviousMonth : null,
            color: _currentMonth.month > 1
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          
          // Mois et année
          Column(
            children: [
              Text(
                DateUtils.formatMonthYear(_currentMonth),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '2026',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
          
          // Mois suivant
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
  
  Widget _buildMonthStats(Map<String, dynamic> stats) {
    return StatsCard(
      title: '${AppStrings.monthName(_currentMonth.month)} 2026',
      stats: {
        'Jours marqués': '${stats['total']}',
        'Bons jours': '${stats['good']} (${stats['goodPercentage'].round()}%)',
        'Mauvais jours': '${stats['bad']} (${stats['badPercentage'].round()}%)',
        'Jours neutres': '${stats['neutral']}',
      },
      color: Theme.of(context).colorScheme.primary,
    );
  }
}

/// Vue compacte du mois (pour les grilles)
class CompactMonthView extends StatelessWidget {
  final DateTime month;
  final VoidCallback? onTap;
  final bool isCurrentMonth;

  const CompactMonthView({
    Key? key,
    required this.month,
    this.onTap,
    this.isCurrentMonth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCurrentMonth
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withOpacity(0.1),
            width: isCurrentMonth ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.monthAbbreviation(month.month),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isCurrentMonth
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              month.year.toString(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}