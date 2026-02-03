import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

// Core
import 'core/themes/app_theme.dart';
import 'core/constants/app_strings.dart';

// Data
import 'data/local_storage/hive_config.dart';

// Presentation - Providers
import 'presentation/providers/app_providers.dart';
import 'presentation/providers/settings_provider.dart';

// Presentation - Screens
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/today_screen.dart';
import 'presentation/screens/monthly_screen.dart';
import 'presentation/screens/yearly_screen.dart';
import 'presentation/screens/settings_screen.dart';

/// Point d'entrée principal de l'application
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation Hive
  await HiveConfig.initialize();

  // Initialisation intl (OBLIGATOIRE pour DateFormat)
  await initializeDateFormatting();

  runApp(
    const ProviderScope(
      child: YearInColorsApp(),
    ),
  );
}

/// Application principale Year in Colors
class YearInColorsApp extends ConsumerWidget {
  const YearInColorsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,

      // Thème
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // Locale par défaut
      locale: const Locale('fr', 'FR'),

      // Routes
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/today': (context) => const TodayScreen(),
        '/month': (context) => const MonthlyScreen(),
        '/year': (context) => const YearlyScreen(),
        '/settings': (context) => const SettingsScreen(),
      },

      // Gestion globale
      builder: (context, child) {
        return _AppWrapper(child: child);
      },
    );
  }
}

/// Wrapper pour overlays globaux (loading, error, success)
class _AppWrapper extends ConsumerWidget {
  final Widget? child;

  const _AppWrapper({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
    final error = ref.watch(errorProvider);
    final success = ref.watch(successProvider);

    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            if (child != null) child!,

            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),

            if (error != null)
              _NotificationToast(
                message: error,
                color: Colors.red,
                icon: Icons.error_outline,
                onDismiss: () =>
                    ref.read(errorProvider.notifier).state = null,
              ),

            if (success != null)
              _NotificationToast(
                message: success,
                color: Colors.green,
                icon: Icons.check_circle,
                onDismiss: () =>
                    ref.read(successProvider.notifier).state = null,
              ),
          ],
        ),
      ),
    );
  }
}

/// Toast de notification (erreur/succès)
class _NotificationToast extends StatelessWidget {
  final String message;
  final Color color;
  final IconData icon;
  final VoidCallback onDismiss;

  const _NotificationToast({
    required this.message,
    required this.color,
    required this.icon,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onDismiss,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(Icons.close, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget pour afficher les informations de version
class VersionInfo extends StatelessWidget {
  const VersionInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Year in Colors',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Version ${AppStrings.currentVersion}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.6),
                ),
          ),
        ],
      ),
    );
  }
}