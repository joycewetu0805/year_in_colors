import 'package:flutter/material.dart';

class AppLocalizations {
  static const Map<String, Map<String, String>> _translations = {
    'fr': {
      'app_title': 'Year in Colors',
      'today': 'Aujourd\'hui',
      'month': 'Mois',
      'year': 'Année',
      'good_day': 'Bon jour',
      'bad_day': 'Mauvais jour',
      'neutral_day': 'Jour neutre',
      'not_set': 'Non renseigné',
      'stats': 'Statistiques',
      'month_stats': 'Statistiques du mois',
      'year_stats': 'Bilan 2026',
      'good_days': 'Bons jours',
      'bad_days': 'Mauvais jours',
      'neutral_days': 'Jours neutres',
      'filled_days': 'Jours renseignés',
      'percentage': 'Pourcentage',
      'share': 'Partager',
      'export': 'Exporter',
      'settings': 'Paramètres',
      'select_date': 'Sélectionner une date',
      'tap_to_select': 'Tapez pour sélectionner',
      'year_message_high': 'En 2026, tu as eu {percentage}% de bons jours. Belle année !',
      'year_message_medium': 'En 2026, tu as eu {percentage}% de bons jours.',
      'year_message_low': 'En 2026, tu as eu {percentage}% de bons jours.',
      'empty_year': 'Commence à marquer tes journées !',
    },
    'en': {
      'app_title': 'Year in Colors',
      'today': 'Today',
      'month': 'Month',
      'year': 'Year',
      'good_day': 'Good day',
      'bad_day': 'Bad day',
      'neutral_day': 'Neutral day',
      'not_set': 'Not set',
      'stats': 'Statistics',
      'month_stats': 'Monthly stats',
      'year_stats': '2026 Summary',
      'good_days': 'Good days',
      'bad_days': 'Bad days',
      'neutral_days': 'Neutral days',
      'filled_days': 'Filled days',
      'percentage': 'Percentage',
      'share': 'Share',
      'export': 'Export',
      'settings': 'Settings',
      'select_date': 'Select a date',
      'tap_to_select': 'Tap to select',
      'year_message_high': 'In 2026, you had {percentage}% of good days. Great year!',
      'year_message_medium': 'In 2026, you had {percentage}% of good days.',
      'year_message_low': 'In 2026, you had {percentage}% of good days.',
      'empty_year': 'Start marking your days!',
    },
  };
  
  static String get(BuildContext context, String key) {
    final locale = Localizations.localeOf(context).languageCode;
    final translations = _translations[locale] ?? _translations['fr']!;
    return translations[key] ?? key;
  }
  
  static String getTranslatedYearMessage(BuildContext context, double percentage) {
    final locale = Localizations.localeOf(context).languageCode;
    final translations = _translations[locale] ?? _translations['fr']!;
    
    if (percentage >= 70) {
      return translations['year_message_high']!.replaceFirst('{percentage}', percentage.round().toString());
    } else if (percentage >= 40) {
      return translations['year_message_medium']!.replaceFirst('{percentage}', percentage.round().toString());
    } else {
      return translations['year_message_low']!.replaceFirst('{percentage}', percentage.round().toString());
    }
  }
}