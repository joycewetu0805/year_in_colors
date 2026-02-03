import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/settings_provider.dart';
import '../providers/export_provider.dart';
import '../providers/day_provider.dart';
import '../widgets/settings_tile.dart';
import '../animations/fade_animation.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_colors.dart';

/// Écran des paramètres
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).settings;
    final showAnimations = settings.showAnimations;
    final themeMode = settings.themeMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // En-tête
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              pinned: true,
              title: Text(
                'Paramètres',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            
            // Contenu
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  if (showAnimations)
                    FadeAnimation(
                      child: _buildAppearanceSection(context, ref, themeMode),
                    )
                  else
                    _buildAppearanceSection(context, ref, themeMode),
                  
                  const SizedBox(height: 24),
                  
                  if (showAnimations)
                    FadeAnimation(
                      child: _buildDataSection(context, ref),
                    )
                  else
                    _buildDataSection(context, ref),

                  const SizedBox(height: 24),

                  if (showAnimations)
                    FadeAnimation(
                      child: _buildAboutSection(context),
                    )
                  else
                    _buildAboutSection(context),
                  
                  const SizedBox(height: 40),
                  
                  // Version
                  Center(
                    child: Text(
                      'Version ${AppStrings.currentVersion}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceSection(BuildContext context, WidgetRef ref, ThemeMode themeMode) {
    final settingsNotifier = ref.read(settingsProvider.notifier);
    
    return SettingsSection(
      title: 'Apparence',
      children: [
        SettingsTile(
          icon: Icons.palette,
          title: 'Thème',
          subtitle: _getThemeName(themeMode),
          trailing: DropdownButton<ThemeMode>(
            value: themeMode,
            underline: Container(),
            items: ThemeMode.values.map((mode) {
              return DropdownMenuItem<ThemeMode>(
                value: mode,
                child: Text(_getThemeName(mode)),
              );
            }).toList(),
            onChanged: (mode) {
              if (mode != null) {
                settingsNotifier.updateTheme(mode);
              }
            },
          ),
        ),
        
        SettingsTile(
          icon: Icons.animation,
          title: 'Animations',
          subtitle: 'Activer les animations',
          trailing: Switch(
            value: ref.watch(settingsProvider).settings.showAnimations,
            onChanged: (value) {
              settingsNotifier.updateAnimations(value);
            },
          ),
        ),
        
        SettingsTile(
          icon: Icons.emoji_emotions,
          title: 'Emojis',
          subtitle: 'Afficher les emojis',
          trailing: Switch(
            value: ref.watch(settingsProvider).settings.showEmojis,
            onChanged: (value) {
              settingsNotifier.updateEmojis(value);
            },
          ),
        ),
        
        SettingsTile(
          icon: Icons.confirmation_number,
          title: 'Confetti',
          subtitle: 'Animations de succès',
          trailing: Switch(
            value: ref.watch(settingsProvider).settings.showConfetti,
            onChanged: (value) {
              // Confetti setting - à implémenter si nécessaire
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDataSection(BuildContext context, WidgetRef ref) {
    final exportNotifier = ref.read(exportProvider.notifier);
    final dayNotifier = ref.read(dayProvider.notifier);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    
    return SettingsSection(
      title: 'Données',
      children: [
        SettingsTile(
          icon: Icons.backup,
          title: 'Sauvegarde automatique',
          subtitle: 'Sauvegarder toutes les semaines',
          trailing: Switch(
            value: ref.watch(settingsProvider).settings.autoBackupEnabled,
            onChanged: (value) {
              settingsNotifier.updateAutoBackup(value);
            },
          ),
        ),
        
        SettingsTile(
          icon: Icons.save,
          title: 'Sauvegarder maintenant',
          subtitle: 'Créer une copie de tes données',
          onTap: () async {
            await exportNotifier.createExport();
          },
        ),
        
        SettingsTile(
          icon: Icons.share,
          title: 'Partager mon année',
          subtitle: 'Partager le résumé ${DateTime.now().year}',
          onTap: () async {
            final currentYear = DateTime.now().year;
            final yearStats = await ref.read(yearSummaryProvider(currentYear).future);
            if (yearStats != null) {
              await Share.share(yearStats.shareableSummary);
            }
          },
        ),
        
        SettingsTile(
          icon: Icons.import_export,
          title: 'Exporter les données',
          subtitle: 'Exporter en JSON',
          onTap: () async {
            final export = ref.read(lastExportProvider);
            if (export != null) {
              final json = await exportNotifier.exportToJson(export);
              if (json != null) {
                await Share.share(json, subject: 'Export Year in Colors ${DateTime.now().year}');
              }
            }
          },
        ),
        
        SettingsTile(
          icon: Icons.delete_outline,
          title: 'Effacer toutes les données',
          subtitle: 'Supprimer tous les jours marqués',
          isDestructive: true,
          onTap: () {
            _showClearDataDialog(context, dayNotifier);
          },
        ),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return SettingsSection(
      title: 'À propos',
      children: [
        SettingsTile(
          icon: Icons.info,
          title: 'À propos de l\'application',
          onTap: () {
            _showAboutDialog(context);
          },
        ),
        
        SettingsTile(
          icon: Icons.privacy_tip,
          title: 'Politique de confidentialité',
          onTap: () {
            // Ouvrir l'URL de la politique de confidentialité
          },
        ),
        
        SettingsTile(
          icon: Icons.description,
          title: 'Conditions d\'utilisation',
          onTap: () {
            // Ouvrir l'URL des conditions
          },
        ),
        
        SettingsTile(
          icon: Icons.email,
          title: 'Contact',
          onTap: () {
            // Ouvrir l'email de contact
          },
        ),
        
        SettingsTile(
          icon: Icons.star,
          title: 'Noter l\'application',
          onTap: () {
            // Ouvrir la page de notation
          },
        ),
      ],
    );
  }

  String _getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Clair';
      case ThemeMode.dark:
        return 'Sombre';
      case ThemeMode.system:
        return 'Système';
    }
  }

  void _showClearDataDialog(BuildContext context, DayNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Effacer toutes les données'),
          content: const Text(
            'Es-tu sûr de vouloir effacer tous les jours marqués ? Cette action est irréversible.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                notifier.clearAllDays();
                Navigator.pop(context);
              },
              child: const Text(
                'Effacer',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('À propos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Year in Colors',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Visualise ton année en marquant chaque jour comme bon, mauvais ou neutre.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Conçu pour être un miroir visuel de ton année, sans jugement, sans analyse lourde.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}

/// Section des paramètres
class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SettingsSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: children
                .map((child) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          child,
                          if (child != children.last)
                            Divider(
                              height: 1,
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                            ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

/// Bouton pour les paramètres
class SettingsButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color? color;

  const SettingsButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color ?? Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}