/// Entité métier représentant un jour dans l'application
/// C'est le cœur du domaine, indépendant de toute implémentation technique
class DayEntity {
  final DateTime date;
  final DayStatusValue value;

  const DayEntity({
    required this.date,
    required this.value,
  });

  /// Crée un jour vide (non marqué)
  factory DayEntity.empty(DateTime date) {
    return DayEntity(
      date: DateTime(date.year, date.month, date.day), // Normalise la date
      value: DayStatusValue.neutral,
    );
  }

  /// Vérifie si le jour est marqué (bon ou mauvais)
  bool get isMarked => value != DayStatusValue.neutral;

  /// Vérifie si c'est un bon jour
  bool get isGoodDay => value == DayStatusValue.good;

  /// Vérifie si c'est un mauvais jour
  bool get isBadDay => value == DayStatusValue.bad;

  /// Crée une copie avec des valeurs modifiées
  DayEntity copyWith({
    DateTime? date,
    DayStatusValue? value,
  }) {
    return DayEntity(
      date: date ?? this.date,
      value: value ?? this.value,
    );
  }

  /// Compare deux jours (uniquement basé sur la date)
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DayEntity &&
        other.date.year == date.year &&
        other.date.month == date.month &&
        other.date.day == date.day;
  }

  @override
  int get hashCode => date.hashCode;

  /// Formatte la date pour l'affichage
  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Vérifie si c'est aujourd'hui
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Vérifie si c'est hier
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Vérifie si c'est demain
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  @override
  String toString() {
    return 'DayEntity(date: $formattedDate, value: $value)';
  }
}

/// Valeurs possibles pour un jour
/// Utilise un enum avec des valeurs numériques pour le stockage
enum DayStatusValue {
  bad(-1, '🔴', 'Mauvais jour'),
  neutral(0, '⚪', 'Jour neutre'),
  good(1, '🟢', 'Bon jour');

  final int numericValue;
  final String emoji;
  final String label;

  const DayStatusValue(this.numericValue, this.emoji, this.label);

  /// Crée une valeur depuis un entier
  factory DayStatusValue.fromInt(int value) {
    switch (value) {
      case -1:
        return DayStatusValue.bad;
      case 0:
        return DayStatusValue.neutral;
      case 1:
        return DayStatusValue.good;
      default:
        return DayStatusValue.neutral;
    }
  }

  /// Convertit en entier pour le stockage
  int toInt() => numericValue;

  /// Vérifie si c'est une valeur valide
  static bool isValidValue(int value) {
    return value >= -1 && value <= 1;
  }

  /// Liste des valeurs pour l'interface utilisateur
  static List<DayStatusValue> get uiValues => [good, bad, neutral];
}