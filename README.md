Year in Colors

Application mobile minimaliste permettant de visualiser une année entière à travers des couleurs.
Chaque jour est marqué objectivement comme bon, neutre ou mauvais, sans journal textuel ni analyse psychologique.

L’objectif est une lecture factuelle du temps vécu, pas une interprétation émotionnelle.

Concept

Chaque jour est représenté par un état simple :
	•	Vert : bon jour
	•	Gris : jour neutre
	•	Rouge : mauvais jour

L’utilisateur marque son jour en un tap. Les données sont stockées localement et visualisées sous forme mensuelle et annuelle.

Fonctionnalités

Écran Aujourd’hui
	•	Date sélectionnée automatiquement
	•	Trois actions possibles : bon / neutre / mauvais
	•	Sauvegarde immédiate sans confirmation

Vue Mensuelle
	•	Calendrier compact
	•	Chaque jour coloré selon son état
	•	Statistiques mensuelles factuelles (comptes et ratios)

Vue Annuelle
	•	Grille complète des 12 mois
	•	Lecture globale de l’année
	•	Statistiques annuelles agrégées

Contraintes Produit
	•	Pas de texte obligatoire
	•	Pas de journal intime
	•	Pas d’analyse psychologique
	•	Données 100 % locales
	•	UX iOS-first, minimalisme strict
	•	Fonctionne hors ligne

Architecture

Le projet suit une Clean Architecture simplifiée, orientée maintenabilité et clarté :
	•	Domain : entités et interfaces abstraites
	•	Data : stockage local Hive + implémentations
	•	Presentation : UI, providers Riverpod, navigation

Les statistiques sont calculées à la volée et ne sont jamais stockées.

Technologies
	•	Flutter 3.x (iOS-first)
	•	Riverpod (gestion d’état)
	•	Hive (stockage local)
	•	Clean Architecture
	•	Design system minimaliste inspiré iOS

Structure du projet

lib/
├── main.dart
├── core/
│   ├── config/
│   ├── constants/
│   ├── theme/
│   └── utils/
├── domain/
│   ├── entities/
│   └── repositories/
├── data/
│   ├── models/
│   ├── datasources/
│   └── repositories/
└── presentation/
    ├── providers/
    ├── screens/
    └── widgets/

Installation

Prérequis
	•	Flutter SDK installé
	•	iOS Simulator ou appareil réel
	•	Xcode configuré (pour iOS)

Lancer l’application

flutter pub get
flutter run

État du projet
	•	Architecture définie
	•	Fonctionnalités principales implémentées
	•	Audit technique réalisé
	•	Corrections critiques en cours avant publication App Store

Philosophie

Year in Colors n’essaie pas de vous expliquer votre vie.
Il montre simplement ce qui est, jour après jour, couleur après couleur.


👉 README technique interne (pour devs)
👉 ou CHANGELOG + roadmap App Store
👉 ou on passe directement au commit Phase 1 (compilation)
>>>>>>> 3ef8e85
