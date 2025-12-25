import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/day_entity.dart';
import '../providers/day_provider.dart';
import '../widgets/day_selector.dart';
import '../widgets/status_indicator.dart';
import '../animations/scale_animation.dart';
import '../animations/fade_animation.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/date_utils.dart';

/// Écran "Aujourd'hui" - Pour marquer le jour actuel
class TodayScreen extends ConsumerStatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends ConsumerState<TodayScreen> {
  late DateTime _selectedDate;
  bool _isChangingDate = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dayProvider.notifier).setSelectedDate(_selectedDate);
    });
  }

  void _updateSelectedDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      _isChangingDate = true;
    });
    
    ref.read(dayProvider.notifier).setSelectedDate(newDate);
    
    // Animation de changement de date
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _isChangingDate = false;
      });
    });
  }

  void _goToToday() {
    final today = DateTime.now();
    _updateSelectedDate(today);
  }

  void _goToPreviousDay() {
    final previousDay = _selectedDate.subtract(const Duration(days: 1));
    if (previousDay.year >= 2026) {
      _updateSelectedDate(previousDay);
    }
  }

  void _goToNextDay() {
    final nextDay = _selectedDate.add(const Duration(days: 1));
    if (nextDay.year <= 2026) {
      _updateSelectedDate(nextDay);
    }
  }

  Future<void> _markDay(DayStatusValue value) async {
    final day = DayEntity(date: _selectedDate, value: value);
    await ref.read(dayProvider.notifier).saveDay(day);
    
    // Feedback visuel
    _showConfirmation(value);
  }

  void _showConfirmation(DayStatusValue value) {
    final messages = {
      DayStatusValue.good: "Jour marqué comme bon 🌟",
      DayStatusValue.bad: "Jour marqué comme difficile 💫",
      DayStatusValue.neutral: "Jour marqué comme neutre",
    };
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(messages[value] ?? ""),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  String _getRelativeDateText(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(date.year, date.month, date.day);
    
    final difference = target.difference(today).inDays;
    
    if (difference == 0) return "Aujourd'hui";
    if (difference == 1) return "Demain";
    if (difference == -1) return "Hier";
    if (difference > 1 && difference < 7) return "Dans $difference jours";
    if (difference < 0 && difference > -7) return "Il y a ${-difference} jours";
    
    return DateUtils.formatDayMonthYear(date);
  }

  @override
  Widget build(BuildContext context) {
    final dayState = ref.watch(dayProvider);
    final selectedDay = dayState.getSelectedDay();
    final showAnimations = ref.watch(animationsEnabledProvider);
    final showEmojis = ref.watch(emojisEnabledProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // En-tête avec date
              FadeAnimation(
                child: Column(
                  children: [
                    Text(
                      DateUtils.formatDayMonthYear(_selectedDate),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateUtils.getDayName(_selectedDate),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getRelativeDateText(_selectedDate),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                fadeIn: !_isChangingDate,
              ),
              
              const SizedBox(height: 48),
              
              // Indicateur de statut
              if (showAnimations)
                ScaleAnimation(
                  child: StatusIndicator(
                    value: selectedDay.value,
                    showEmoji: showEmojis,
                  ),
                )
              else
                StatusIndicator(
                  value: selectedDay.value,
                  showEmoji: showEmojis,
                ),
              
              const SizedBox(height: 24),
              
              // Texte du statut
              FadeAnimation(
                child: Text(
                  selectedDay.value.label,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Sélecteur de jour
              DaySelector(
                currentStatus: selectedDay.value,
                onStatusSelected: _markDay,
                showAnimations: showAnimations,
              ),
              
              const Spacer(),
              
              // Navigation de date
              _buildDateNavigation(),
              
              // Indicateur de chargement
              if (dayState.isLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateNavigation() {
    final isToday = DateUtils.isToday(_selectedDate);
    final isFirstDay = _selectedDate.year == 2026 && _selectedDate.month == 1 && _selectedDate.day == 1;
    final isLastDay = _selectedDate.year == 2026 && _selectedDate.month == 12 && _selectedDate.day == 31;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Précédent
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: isFirstDay ? null : _goToPreviousDay,
            color: isFirstDay
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.3)
                : Theme.of(context).colorScheme.onSurface,
          ),
          
          // Aujourd'hui
          TextButton(
            onPressed: isToday ? null : _goToToday,
            child: Text(
              "Aujourd'hui",
              style: TextStyle(
                color: isToday
                    ? Theme.of(context).colorScheme.onSurface.withOpacity(0.3)
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          
          // Suivant
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: isLastDay ? null : _goToNextDay,
            color: isLastDay
                ? Theme.of(context).colorScheme.onSurface.withOpacity(0.3)
                : Theme.of(context).colorScheme.onSurface,
          ),
        ],
      ),
    );
  }
}

/// Dialog pour sélectionner une date
Future<DateTime?> showDatePickerDialog(BuildContext context, DateTime initialDate) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2026, 1, 1),
    lastDate: DateTime(2026, 12, 31),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).colorScheme.primary,
            onPrimary: Colors.white,
            surface: Theme.of(context).colorScheme.surface,
            onSurface: Theme.of(context).colorScheme.onSurface,
          ),
          dialogBackgroundColor: Theme.of(context).colorScheme.background,
        ),
        child: child!,
      );
    },
  );
}