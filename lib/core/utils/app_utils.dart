import 'package:flutter/material.dart';

class AppUtils {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static double calculateGoodDayPercentage(int goodDays, int totalDays) {
    if (totalDays == 0) return 0;
    return (goodDays / totalDays) * 100;
  }

  static String getYearMessage(double goodPercentage, int year) {
    if (goodPercentage >= 70) {
      return 'En $year, tu as eu ${goodPercentage.round()}% de bons jours. Belle année !';
    } else if (goodPercentage >= 40) {
      return 'En $year, tu as eu ${goodPercentage.round()}% de bons jours.';
    } else {
      return 'En $year, tu as eu ${goodPercentage.round()}% de bons jours.';
    }
  }
}