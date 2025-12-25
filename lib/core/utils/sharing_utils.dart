import 'package:flutter/material.dart';
import 'package:share_plus/share_share.dart';

class SharingUtils {
  static Future<void> shareYearSummary({
    required int goodDays,
    required int badDays,
    required int totalDays,
    required double goodPercentage,
  }) async {
    final message = '''
📊 Mon année 2026 en couleurs

🎯 Jours renseignés: $totalDays
🟢 Bons jours: $goodDays (${goodPercentage.toStringAsFixed(1)}%)
🔴 Mauvais jours: $badDays
📈 Progression: ${(goodPercentage - 50).toStringAsFixed(1)}%

#YearInColors #2026
    ''';
    
    await Share.share(message);
  }
  
  static Future<void> shareMonthSummary({
    required String monthName,
    required int goodDays,
    required int badDays,
    required int filledDays,
  }) async {
    final percentage = filledDays > 0 ? (goodDays / filledDays * 100) : 0;
    
    final message = '''
📅 $monthName 2026

🎯 Jours marqués: $filledDays
🟢 Bons jours: $goodDays
🔴 Mauvais jours: $badDays
📊 Taux de bons jours: ${percentage.toStringAsFixed(1)}%

#YearInColors
    ''';
    
    await Share.share(message);
  }
  
  static Future<void> exportAsImage() async {
    // TODO: Implémenter la capture d'écran et export PNG
    // Utiliser: https://pub.dev/packages/screenshot
  }
  
  static Future<void> exportAsPDF() async {
    // TODO: Implémenter l'export PDF
    // Utiliser: https://pub.dev/packages/pdf
  }
}