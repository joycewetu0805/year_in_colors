import 'package:flutter/material.dart';
import '../../domain/entities/day_entity.dart';
import '../../core/constants/app_colors.dart';
import '../animations/scale_tap_animation.dart';
import '../animations/ripple_animation.dart';

/// Sélecteur de statut de jour (Bon/Mauvais/Neutre)
class DaySelector extends StatelessWidget {
  final DayStatusValue currentStatus;
  final Function(DayStatusValue) onStatusSelected;
  final bool showAnimations;

  const DaySelector({
    Key? key,
    required this.currentStatus,
    required this.onStatusSelected,
    this.showAnimations = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStatusButton(
          value: DayStatusValue.good,
          icon: Icons.thumb_up_alt_outlined,
          label: 'Bon',
          color: AppColors.goodDay,
        ),
        const SizedBox(width: 32),
        _buildStatusButton(
          value: DayStatusValue.bad,
          icon: Icons.thumb_down_alt_outlined,
          label: 'Mauvais',
          color: AppColors.badDay,
        ),
        const SizedBox(width: 32),
        _buildStatusButton(
          value: DayStatusValue.neutral,
          icon: Icons.remove,
          label: 'Neutre',
          color: AppColors.neutralDay,
        ),
      ],
    );
  }

  Widget _buildStatusButton({
    required DayStatusValue value,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    final isSelected = currentStatus == value;

    final button = Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: isSelected ? color : color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
              width: isSelected ? 3 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? color : Colors.grey[600],
          ),
        ),
      ],
    );

    if (showAnimations) {
      return ScaleTapAnimation(
        onTap: () => onStatusSelected(value),
        scaleFactor: 0.95,
        child: button,
      );
    } else {
      return GestureDetector(
        onTap: () => onStatusSelected(value),
        child: button,
      );
    }
  }
}

/// Sélecteur de jour circulaire
class CircularDaySelector extends StatelessWidget {
  final DayStatusValue currentStatus;
  final Function(DayStatusValue) onStatusSelected;
  final double size;

  const CircularDaySelector({
    Key? key,
    required this.currentStatus,
    required this.onStatusSelected,
    this.size = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Cycle through statuses
        final nextStatus = DayStatusValue.values[
            (currentStatus.index + 1) % DayStatusValue.values.length];
        onStatusSelected(nextStatus);
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: _getStatusColor(currentStatus),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: _getStatusColor(currentStatus).withOpacity(0.3),
              blurRadius: 16,
              spreadRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getStatusIcon(currentStatus),
              size: size * 0.4,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              currentStatus.label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(DayStatusValue status) {
    switch (status) {
      case DayStatusValue.good:
        return AppColors.goodDay;
      case DayStatusValue.bad:
        return AppColors.badDay;
      case DayStatusValue.neutral:
        return AppColors.neutralDay;
    }
  }

  IconData _getStatusIcon(DayStatusValue status) {
    switch (status) {
      case DayStatusValue.good:
        return Icons.thumb_up;
      case DayStatusValue.bad:
        return Icons.thumb_down;
      case DayStatusValue.neutral:
        return Icons.remove;
    }
  }
}