import 'package:flutter/material.dart';
import '../../domain/entities/day_entity.dart';
import '../../core/constants/app_colors.dart';
import '../animations/bounce_animation.dart';

/// Indicateur de statut circulaire
class StatusIndicator extends StatelessWidget {
  final DayStatusValue value;
  final double size;
  final bool showEmoji;
  final bool showAnimation;

  const StatusIndicator({
    Key? key,
    required this.value,
    this.size = 80,
    this.showEmoji = true,
    this.showAnimation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor(value);
    final emoji = _getStatusEmoji(value);

    final indicator = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 16,
            spreadRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: showEmoji
            ? Text(
                emoji,
                style: TextStyle(fontSize: size * 0.4),
              )
            : Icon(
                _getStatusIcon(value),
                color: Colors.white,
                size: size * 0.5,
              ),
      ),
    );

    if (showAnimation) {
      return BounceAnimation(
        child: indicator,
        intensity: 0.2,
        autoPlay: true,
      );
    }

    return indicator;
  }

  Color _getStatusColor(DayStatusValue value) {
    switch (value) {
      case DayStatusValue.good:
        return AppColors.goodDay;
      case DayStatusValue.bad:
        return AppColors.badDay;
      case DayStatusValue.neutral:
        return AppColors.neutralDay;
    }
  }

  String _getStatusEmoji(DayStatusValue value) {
    switch (value) {
      case DayStatusValue.good:
        return '🟢';
      case DayStatusValue.bad:
        return '🔴';
      case DayStatusValue.neutral:
        return '⚪';
    }
  }

  IconData _getStatusIcon(DayStatusValue value) {
    switch (value) {
      case DayStatusValue.good:
        return Icons.thumb_up;
      case DayStatusValue.bad:
        return Icons.thumb_down;
      case DayStatusValue.neutral:
        return Icons.remove;
    }
  }
}

/// Indicateur de statut avec texte
class StatusIndicatorWithText extends StatelessWidget {
  final DayStatusValue value;
  final String text;
  final bool compact;

  const StatusIndicatorWithText({
    Key? key,
    required this.value,
    required this.text,
    this.compact = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StatusIndicator(
          value: value,
          size: compact ? 40 : 60,
          showEmoji: !compact,
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: compact ? 12 : 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

/// Indicateur de statut en ligne (pour les listes)
class InlineStatusIndicator extends StatelessWidget {
  final DayStatusValue value;
  final String label;
  final bool showDot;

  const InlineStatusIndicator({
    Key? key,
    required this.value,
    required this.label,
    this.showDot = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showDot)
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: _getStatusColor(value),
              shape: BoxShape.circle,
            ),
          ),
        Text(
          label,
          style: TextStyle(
            color: _getStatusColor(value),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(DayStatusValue value) {
    switch (value) {
      case DayStatusValue.good:
        return AppColors.goodDay;
      case DayStatusValue.bad:
        return AppColors.badDay;
      case DayStatusValue.neutral:
        return AppColors.neutralDay;
    }
  }
}