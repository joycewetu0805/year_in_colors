/// Paramètres de l'application - Configuration utilisateur
class AppSettingsEntity {
  final ThemeMode themeMode;
  final String languageCode;
  final bool showEmojis;
  final bool showAnimations;
  final bool showConfetti;
  final DateTime? lastBackupDate;
  final bool autoBackupEnabled;
  final bool notificationsEnabled;
  final TimeOfDay notificationTime;
  final bool firstLaunchCompleted;

  const AppSettingsEntity({
    this.themeMode = ThemeMode.system,
    this.languageCode = 'fr',
    this.showEmojis = true,
    this.showAnimations = true,
    this.showConfetti = true,
    this.lastBackupDate,
    this.autoBackupEnabled = false,
    this.notificationsEnabled = false,
    this.notificationTime = const TimeOfDay(hour: 20, minute: 0),
    this.firstLaunchCompleted = false,
  });

  /// Crée des paramètres par défaut
  factory AppSettingsEntity.defaultSettings() {
    return const AppSettingsEntity();
  }

  /// Crée une copie avec des valeurs modifiées
  AppSettingsEntity copyWith({
    ThemeMode? themeMode,
    String? languageCode,
    bool? showEmojis,
    bool? showAnimations,
    bool? showConfetti,
    DateTime? lastBackupDate,
    bool? autoBackupEnabled,
    bool? notificationsEnabled,
    TimeOfDay? notificationTime,
    bool? firstLaunchCompleted,
  }) {
    return AppSettingsEntity(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      showEmojis: showEmojis ?? this.showEmojis,
      showAnimations: showAnimations ?? this.showAnimations,
      showConfetti: showConfetti ?? this.showConfetti,
      lastBackupDate: lastBackupDate ?? this.lastBackupDate,
      autoBackupEnabled: autoBackupEnabled ?? this.autoBackupEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      notificationTime: notificationTime ?? this.notificationTime,
      firstLaunchCompleted: firstLaunchCompleted ?? this.firstLaunchCompleted,
    );
  }

  /// Vérifie si un backup est nécessaire (toutes les 7 jours)
  bool get isBackupNeeded {
    if (lastBackupDate == null || !autoBackupEnabled) return false;
    
    final now = DateTime.now();
    final difference = now.difference(lastBackupDate!);
    return difference.inDays >= 7;
  }

  /// Vérifie si les notifications sont configurées et activées
  bool get areNotificationsConfigured {
    return notificationsEnabled && notificationTime != null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppSettingsEntity &&
        other.themeMode == themeMode &&
        other.languageCode == languageCode &&
        other.showEmojis == showEmojis &&
        other.showAnimations == showAnimations &&
        other.showConfetti == showConfetti &&
        other.lastBackupDate == lastBackupDate &&
        other.autoBackupEnabled == autoBackupEnabled &&
        other.notificationsEnabled == notificationsEnabled &&
        other.notificationTime == notificationTime &&
        other.firstLaunchCompleted == firstLaunchCompleted;
  }

  @override
  int get hashCode {
    return Object.hash(
      themeMode,
      languageCode,
      showEmojis,
      showAnimations,
      showConfetti,
      lastBackupDate,
      autoBackupEnabled,
      notificationsEnabled,
      notificationTime,
      firstLaunchCompleted,
    );
  }

  @override
  String toString() {
    return 'AppSettingsEntity('
        'themeMode: $themeMode, '
        'languageCode: $languageCode, '
        'notifications: ${notificationsEnabled ? "ON" : "OFF"})';
  }
}

/// Mode de thème supporté
enum ThemeMode {
  light('Clair', Icons.light_mode),
  dark('Sombre', Icons.dark_mode),
  system('Système', Icons.brightness_auto);

  final String label;
  final IconData icon;

  const ThemeMode(this.label, this.icon);

  /// Convertit depuis une chaîne de caractères
  factory ThemeMode.fromString(String value) {
    switch (value.toLowerCase()) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// Convertit en chaîne de caractères pour le stockage
  String toStorageString() {
    return toString().split('.').last;
  }
}