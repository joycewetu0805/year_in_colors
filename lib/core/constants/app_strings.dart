/// Constantes de chaînes de caractères pour l'application
class AppStrings {
  // Titres de l'application
  static const String appName = 'Year in Colors';
  static const String appTagline = 'Visualise ton année en couleurs';
  static const String appDescription = 'Marque chaque jour comme bon ou mauvais et visualise ta progression';
  
  // Navigation
  static const String tabToday = 'Aujourd\'hui';
  static const String tabMonth = 'Mois';
  static const String tabYear = 'Année';
  static const String back = 'Retour';
  static const String close = 'Fermer';
  static const String next = 'Suivant';
  static const String previous = 'Précédent';
  static const String done = 'Terminé';
  static const String save = 'Sauvegarder';
  static const String cancel = 'Annuler';
  
  // Écran Aujourd'hui
  static const String today = 'Aujourd\'hui';
  static const String yesterday = 'Hier';
  static const String tomorrow = 'Demain';
  static const String selectDate = 'Sélectionner une date';
  static const String currentDate = 'Date actuelle';
  
  // Statuts de jour
  static const String goodDay = 'Bon jour';
  static const String badDay = 'Mauvais jour';
  static const String neutralDay = 'Jour neutre';
  static const String notSet = 'Non renseigné';
  static const String emptyDay = 'Jour vide';
  
  // Actions
  static const String markAsGood = 'Marquer comme bon';
  static const String markAsBad = 'Marquer comme mauvais';
  static const String markAsNeutral = 'Marquer comme neutre';
  static const String clearSelection = 'Effacer la sélection';
  static const String editDay = 'Modifier le jour';
  
  // Messages de confirmation
  static const String dayMarkedGood = 'Jour marqué comme bon 🌟';
  static const String dayMarkedBad = 'Jour marqué comme difficile 💫';
  static const String dayMarkedNeutral = 'Jour marqué comme neutre';
  static const String dayUpdated = 'Jour mis à jour';
  static const String dayCleared = 'Sélection effacée';
  
  // Statistiques
  static const String statistics = 'Statistiques';
  static const String monthStatistics = 'Statistiques du mois';
  static const String yearStatistics = 'Bilan 2026';
  static const String totalDays = 'Jours totaux';
  static const String filledDays = 'Jours renseignés';
  static const String emptyDays = 'Jours non renseignés';
  static const String goodDays = 'Bons jours';
  static const String badDays = 'Mauvais jours';
  static const String neutralDays = 'Jours neutres';
  static const String percentage = 'Pourcentage';
  static const String ratio = 'Ratio';
  static const String average = 'Moyenne';
  static const String trend = 'Tendance';
  static const String comparison = 'Comparaison';
  
  // Messages annuels
  static const String yearSummary = 'Résumé de l\'année';
  static const String yearMessageExcellent = 'Excellente année !';
  static const String yearMessageGood = 'Bonne année !';
  static const String yearMessageAverage = 'Année moyenne';
  static const String yearMessageTough = 'Année difficile';
  static const String yearMessageStart = 'Commence à marquer tes journées !';
  
  // Partage et export
  static const String share = 'Partager';
  static const String export = 'Exporter';
  static const String exportImage = 'Exporter en image';
  static const String exportPDF = 'Exporter en PDF';
  static const String shareSummary = 'Partager le résumé';
  static const String copyToClipboard = 'Copier dans le presse-papier';
  static const String savedToGallery = 'Sauvegardé dans la galerie';
  static const String shareTitle = 'Mon année 2026 en couleurs';
  static const String shareMessage = 'Découvre mon année 2026 visualisée en couleurs avec Year in Colors!';
  
  // Paramètres
  static const String settings = 'Paramètres';
  static const String appearance = 'Apparence';
  static const String language = 'Langue';
  static const String notifications = 'Notifications';
  static const String dataManagement = 'Gestion des données';
  static const String backup = 'Sauvegarde';
  static const String restore = 'Restaurer';
  static const String clearData = 'Effacer les données';
  static const String about = 'À propos';
  static const String privacyPolicy = 'Politique de confidentialité';
  static const String termsOfService = 'Conditions d\'utilisation';
  static const String version = 'Version';
  static const String feedback = 'Feedback';
  static const String rateApp = 'Noter l\'application';
  
  // Langues
  static const String french = 'Français';
  static const String english = 'English';
  static const String systemLanguage = 'Langue du système';
  
  // Thèmes
  static const String lightTheme = 'Thème clair';
  static const String darkTheme = 'Thème sombre';
  static const String systemTheme = 'Thème système';
  static const String automatic = 'Automatique';
  
  // Jours de la semaine
  static const String monday = 'Lundi';
  static const String tuesday = 'Mardi';
  static const String wednesday = 'Mercredi';
  static const String thursday = 'Jeudi';
  static const String friday = 'Vendredi';
  static const String saturday = 'Samedi';
  static const String sunday = 'Dimanche';
  
  // Mois
  static const List<String> months = [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre'
  ];
  
  static const List<String> monthsShort = [
    'Jan',
    'Fév',
    'Mar',
    'Avr',
    'Mai',
    'Juin',
    'Juil',
    'Août',
    'Sep',
    'Oct',
    'Nov',
    'Déc'
  ];
  
  // Éléments d'interface
  static const String loading = 'Chargement...';
  static const String noData = 'Aucune donnée';
  static const String error = 'Erreur';
  static const String retry = 'Réessayer';
  static const String success = 'Succès';
  static const String failed = 'Échec';
  static const String warning = 'Attention';
  static const String information = 'Information';
  static const String confirmation = 'Confirmation';
  static const String delete = 'Supprimer';
  static const String edit = 'Modifier';
  static const String view = 'Voir';
  static const String more = 'Plus';
  static const String less = 'Moins';
  static const String show = 'Afficher';
  static const String hide = 'Masquer';
  
  // Messages d'erreur
  static const String errorLoadingData = 'Erreur lors du chargement des données';
  static const String errorSavingData = 'Erreur lors de la sauvegarde';
  static const String errorNoInternet = 'Pas de connexion internet';
  static const String errorTryAgain = 'Veuillez réessayer';
  static const String errorUnexpected = 'Une erreur inattendue est survenue';
  
  // Messages d'information
  static const String dataSaved = 'Données sauvegardées';
  static const String dataLoaded = 'Données chargées';
  static const String dataCleared = 'Données effacées';
  static const String backupCreated = 'Sauvegarde créée';
  static const String backupRestored = 'Sauvegarde restaurée';
  
  // Tooltips
  static const String tooltipGoodDay = 'Jour positif, agréable ou productif';
  static const String tooltipBadDay = 'Jour difficile, stressant ou négatif';
  static const String tooltipNeutralDay = 'Jour ordinaire, ni bon ni mauvais';
  static const String tooltipCalendar = 'Calendrier des jours marqués';
  static const String tooltipStats = 'Voir les statistiques détaillées';
  static const String tooltipShare = 'Partager ton année';
  static const String tooltipSettings = 'Paramètres de l\'application';
  
  // Texte inspirants (optionnels, non intrusifs)
  static const List<String> inspirationalMessages = [
    'Chaque jour est une nouvelle page',
    'Les couleurs racontent ton histoire',
    'Visualise ta progression, jour après jour',
    'Un bon jour à la fois',
    'Ton année, tes couleurs',
    'Le temps passe, les couleurs restent',
    'Marque ton chemin en couleurs',
    'La vie en teintes de vert, rouge et gris',
    'Chaque jour compte',
    'Une année en un coup d\'œil'
  ];
  
  // Instructions
  static const String instructionToday = 'Marque aujourd\'hui comme bon ou mauvais';
  static const String instructionCalendar = 'Tape sur un jour pour le modifier';
  static const String instructionStats = 'Suis ta progression mensuelle et annuelle';
  static const String instructionShare = 'Partage ton bilan avec tes proches';
  
  // Formats
  static const String dateFormatFull = 'EEEE d MMMM yyyy';
  static const String dateFormatShort = 'dd/MM/yyyy';
  static const String dateFormatMonthYear = 'MMMM yyyy';
  static const String dateFormatDayMonth = 'd MMMM';
  static const String timeFormat = 'HH:mm';
  
  // Placeholders
  static const String placeholderSearch = 'Rechercher...';
  static const String placeholderNote = 'Ajouter une note (optionnel)';
  static const String placeholderName = 'Nom';
  static const String placeholderEmail = 'Email';
  static const String placeholderPassword = 'Mot de passe';
  
  // Validation
  static const String validationRequired = 'Ce champ est requis';
  static const String validationEmail = 'Email invalide';
  static const String validationPassword = 'Mot de passe trop court';
  
  // Nombres
  static const String zero = '0';
  static const String one = '1';
  static const String two = '2';
  static const String three = '3';
  static const String four = '4';
  static const String five = '5';
  static const String six = '6';
  static const String seven = '7';
  static const String eight = '8';
  static const String nine = '9';
  static const String ten = '10';
  
  // Symboles
  static const String percentSymbol = '%';
  static const String dollarSymbol = '\$';
  static const String euroSymbol = '€';
  static const String degreeSymbol = '°';
  static const String checkmark = '✓';
  static const String cross = '✗';
  static const String arrowRight = '→';
  static const String arrowLeft = '←';
  static const String arrowUp = '↑';
  static const String arrowDown = '↓';
  
  // États du réseau
  static const String online = 'En ligne';
  static const String offline = 'Hors ligne';
  static const String syncing = 'Synchronisation...';
  static const String syncComplete = 'Synchronisation terminée';
  static const String syncFailed = 'Échec de synchronisation';
  
  // Permissions
  static const String permissionStorage = 'Permission de stockage requise';
  static const String permissionCamera = 'Permission caméra requise';
  static const String permissionNotification = 'Permission notification requise';
  
  // Versions
  static const String currentVersion = '1.0.0';
  static const String buildNumber = '1';
  
  // URLs (exemples)
  static const String privacyPolicyURL = 'https://example.com/privacy';
  static const String termsOfServiceURL = 'https://example.com/terms';
  static const String websiteURL = 'https://example.com';
  static const String supportEmail = 'support@example.com';
  
  // Fonction pour obtenir le nom du mois
  static String getMonthName(int month) {
    if (month >= 1 && month <= 12) {
      return months[month - 1];
    }
    return '';
  }
  
  // Fonction pour obtenir le nom court du mois
  static String getShortMonthName(int month) {
    if (month >= 1 && month <= 12) {
      return monthsShort[month - 1];
    }
    return '';
  }
  
  // Fonction pour obtenir le jour de la semaine
  static String getWeekdayName(int weekday) {
    switch (weekday) {
      case 1: return monday;
      case 2: return tuesday;
      case 3: return wednesday;
      case 4: return thursday;
      case 5: return friday;
      case 6: return saturday;
      case 7: return sunday;
      default: return '';
    }
  }
}