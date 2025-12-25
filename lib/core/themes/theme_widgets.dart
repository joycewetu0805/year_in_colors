import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../constants/app_styles.dart';

/// Widgets réutilisables liés au thème pour une cohérence visuelle

/// Carte avec fond adaptatif et ombre
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final bool elevated;
  
  const AppCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(AppDimensions.spacingLarge),
    this.margin = EdgeInsets.zero,
    this.color,
    this.borderRadius,
    this.border,
    this.elevated = true,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(AppDimensions.borderRadiusLarge),
        border: border,
        boxShadow: elevated ? [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

/// Bouton d'action principal avec style iOS-like
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool fullWidth;
  final bool isLoading;
  final IconData? icon;
  final Color? backgroundColor;
  
  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fullWidth = false,
    this.isLoading = false,
    this.icon,
    this.backgroundColor,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          padding: AppDimensions.paddingAllMedium,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: AppDimensions.iconSizeMedium),
                    const SizedBox(width: AppDimensions.spacingSmall),
                  ],
                  Text(
                    text,
                    style: AppStyles.actionButtonStyle(context),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Bouton de statut de jour (Bon/Mauvais/Neutre)
class DayStatusButton extends StatelessWidget {
  final int value;
  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final IconData icon;
  
  const DayStatusButton({
    Key? key,
    required this.value,
    required this.isSelected,
    required this.onTap,
    required this.label,
    required this.icon,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final color = AppColors.getStatusColor(value);
    
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: AppDimensions.statusButtonSize,
            height: AppDimensions.statusButtonSize,
            decoration: BoxDecoration(
              color: isSelected ? color : color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: color,
                width: isSelected ? AppDimensions.borderWidthThick : AppDimensions.borderWidthNormal,
              ),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : color,
              size: AppDimensions.iconSizeLarge,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingSmall),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isSelected ? color : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

/// Indicateur de statut circulaire
class StatusIndicator extends StatelessWidget {
  final int value;
  final double size;
  final bool showEmoji;
  
  const StatusIndicator({
    Key? key,
    required this.value,
    this.size = AppDimensions.statusIndicatorSize,
    this.showEmoji = false,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final color = AppColors.getStatusColor(value);
    final emoji = AppColors.getStatusEmoji(value);
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: showEmoji
            ? Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              )
            : Icon(
                _getIconForValue(value),
                color: Colors.white,
                size: size * 0.5,
              ),
      ),
    );
  }
  
  IconData _getIconForValue(int value) {
    switch (value) {
      case 1: return Icons.thumb_up;
      case -1: return Icons.thumb_down;
      default: return Icons.remove;
    }
  }
}

/// Widget pour afficher un jour dans le calendrier
class CalendarDayCell extends StatelessWidget {
  final DateTime date;
  final int value;
  final bool isToday;
  final VoidCallback? onTap;
  final double size;
  
  const CalendarDayCell({
    Key? key,
    required this.date,
    required this.value,
    this.isToday = false,
    this.onTap,
    this.size = AppDimensions.dayCellSize,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final color = AppColors.getStatusColor(value);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: const EdgeInsets.all(AppDimensions.spacingMicro),
        decoration: BoxDecoration(
          color: value != 0 ? color : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: isToday ? AppColors.accentBlue : Colors.transparent,
            width: AppDimensions.borderWidthThick,
          ),
        ),
        child: Center(
          child: Text(
            date.day.toString(),
            style: TextStyle(
              fontSize: AppDimensions.fontSizeSmall,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              color: value != 0 ? Colors.white : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }
}

/// Barre de progression colorée pour les statistiques
class ProgressBar extends StatelessWidget {
  final double progress;
  final Color color;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  
  const ProgressBar({
    Key? key,
    required this.progress,
    required this.color,
    this.height = 8,
    this.borderRadius,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(height / 2);
    
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: borderRadius,
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
        ),
      ),
    );
  }
}

/// Carte de statistiques avec style adaptatif
class StatsCard extends StatelessWidget {
  final String title;
  final Map<String, dynamic> stats;
  final Color? titleColor;
  
  const StatsCard({
    Key? key,
    required this.title,
    required this.stats,
    this.titleColor,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppDimensions.spacingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: titleColor ?? Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingLarge),
          ...stats.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  if (entry.value is String)
                    Text(
                      entry.value,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  else if (entry.value is double)
                    Text(
                      '${(entry.value as double).toStringAsFixed(1)}%',
                      style: AppStyles.percentageStyle(context, entry.value as double),
                    )
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

/// En-tête de section avec style iOS
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  
  const SectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.trailing,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingLarge,
        vertical: AppDimensions.spacingMedium,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: AppDimensions.spacingMicro),
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}