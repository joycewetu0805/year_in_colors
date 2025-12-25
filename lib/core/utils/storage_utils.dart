import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ColorUtils {
  static Color getStatusColor(int value) {
    switch (value) {
      case 1:
        return AppColors.goodDay;
      case -1:
        return AppColors.badDay;
      default:
        return AppColors.neutralDay;
    }
  }
  
  static Color getStatusBackgroundColor(int value, BuildContext context) {
    final color = getStatusColor(value);
    final brightness = Theme.of(context).brightness;
    
    if (brightness == Brightness.light) {
      return color.withOpacity(0.1);
    } else {
      return color.withOpacity(0.2);
    }
  }
  
  static String getStatusEmoji(int value) {
    switch (value) {
      case 1:
        return '🟢';
      case -1:
        return '🔴';
      default:
        return '⚪';
    }
  }
  
  static String getStatusText(int value) {
    switch (value) {
      case 1:
        return 'Bon jour';
      case -1:
        return 'Mauvais jour';
      default:
        return 'Non renseigné';
    }
  }
  
  static String getStatusActionText(int value) {
    switch (value) {
      case 1:
        return 'Bon';
      case -1:
        return 'Mauvais';
      default:
        return 'Neutre';
    }
  }
  
  static Color getPercentageColor(double percentage) {
    if (percentage >= 70) {
      return AppColors.goodDay;
    } else if (percentage >= 40) {
      return Colors.amber;
    } else {
      return AppColors.badDay;
    }
  }
  
  static String formatPercentage(double value) {
    return '${value.toStringAsFixed(1)}%';
  }
}