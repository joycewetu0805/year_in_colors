import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Core
import 'core/themes/app_theme.dart';
import 'core/themes/theme_manager.dart';
import 'core/themes/theme_provider.dart';
import 'core/constants/app_strings.dart';
import 'core/utils/localization.dart';

// Data
import 'data/local_storage/hive_config.dart';

// Presentation - Providers
import 'presentation/providers/app_providers.dart';
import 'presentation/providers/day_provider.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/providers/export_provider.dart';

// Presentation - Screens
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/today_screen.dart';
import 'presentation/screens/monthly_screen.dart';
import 'presentation/screens/yearly_screen.dart';
import 'presentation/screens/settings_screen.dart';

/// Point d'entrée principal de l'application
Future<void> main() async {
  // Assurer l'initialisation de Flutter
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialiser Hive (base de données locale)
  await HiveConfig.initialize();
  
  // Lancer l'application
  runApp(
    const ProviderScope(
      child: YearInColorsApp(),
    ),
  );
}

/// Application principale Year in Colors
class YearInColorsApp extends ConsumerStatefulWidget {
  const YearInColorsApp({Key? key}) : super(key: key);

  @override
  _YearInColorsAppState createState() => _YearInColorsAppState();
}

class _YearInColorsAppState extends ConsumerState<YearInColorsApp> with WidgetsBindingObserver {
  late ThemeManager _themeManager;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Initialisation asynchrone si nécessaire
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    // Réagir aux changements de luminosité du système
    if (_themeManager.themeMode == ThemeMode.system) {
      ref.read(themeProvider.notifier).state = ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Observer le thème depuis les paramètres
    final themeMode = ref.watch(themeModeProvider);
    
    return MaterialApp(
      // Titre de l'application
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      
      // Thème et apparence
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      
      // Localisation
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en', 'US'),
      ],
      locale: const Locale('fr', 'FR'),
      
      // Routes et navigation
      initialRoute: '/',
      routes: _buildRoutes(),
      
      // Gestion des erreurs globales
      builder: (context, child) {
        return _buildAppWrapper(context, child);
      },
    );
  }

  /// Construction des routes de l'application
  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/': (context) => const HomeScreen(),
      '/today': (context) => const TodayScreen(),
      '/month': (context) => const MonthlyScreen(),
      '/year': (context) => const YearlyScreen(),
      '/settings': (context) => const SettingsScreen(),
    };
  }

  /// Wrapper principal de l'application avec gestion d'état
  Widget _buildAppWrapper(BuildContext context, Widget? child) {
    return GestureDetector(
      onTap: () {
        // Fermer le clavier quand on tape ailleurs
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            // Contenu principal
            if (child != null) child,
            
            // Overlay de chargement global
            _buildGlobalLoadingOverlay(),
            
            // Overlay d'erreur global
            _buildGlobalErrorOverlay(),
            
            // Overlay de succès global
            _buildGlobalSuccessOverlay(),
          ],
        ),
      ),
    );
  }

  /// Overlay de chargement global
  Widget _buildGlobalLoadingOverlay() {
    final isLoading = ref.watch(loadingProvider);
    
    if (!isLoading) return const SizedBox.shrink();
    
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  /// Overlay d'erreur global
  Widget _buildGlobalErrorOverlay() {
    final error = ref.watch(errorProvider);
    
    if (error == null) return const SizedBox.shrink();
    
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => ref.read(errorProvider.notifier).state = null,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red,
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
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    error,
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

  /// Overlay de succès global
  Widget _buildGlobalSuccessOverlay() {
    final success = ref.watch(successProvider);
    
    if (success == null) return const SizedBox.shrink();
    
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => ref.read(successProvider.notifier).state = null,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green,
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
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    success,
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

/// Écran de lancement (splash screen)
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    _controller.forward();
    
    // Naviguer vers l'écran principal après le splash
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Vérifier si c'est le premier lancement
    await Future.delayed(const Duration(seconds: 2));
    
    // Ici, on pourrait vérifier les préférences utilisateur
    // et naviguer vers l'onboarding ou l'écran principal
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.color_lens,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Titre
              Text(
                'Year in Colors',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.5,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Sous-titre
              Text(
                AppStrings.appTagline,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Écran d'introduction (onboarding)
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Marque chaque jour',
      description: 'Clique sur 🟢 pour un bon jour, 🔴 pour un mauvais jour',
      icon: Icons.emoji_emotions,
      color: Colors.green,
    ),
    OnboardingPage(
      title: 'Visualise ta progression',
      description: 'Vois ton mois et ton année en un coup d\'œil',
      icon: Icons.calendar_today,
      color: Colors.blue,
    ),
    OnboardingPage(
      title: 'Pas de jugement',
      description: 'C\'est ton miroir visuel, pas un juge',
      icon: Icons.visibility,
      color: Colors.purple,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    // Marquer l'onboarding comme terminé
    // et naviguer vers l'écran principal
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Barre de progression
            LinearProgressIndicator(
              value: (_currentPage + 1) / _pages.length,
              backgroundColor: Theme.of(context).colorScheme.surface,
              color: Theme.of(context).colorScheme.primary,
              minHeight: 2,
            ),
            
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icône
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: page.color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            page.icon,
                            size: 60,
                            color: page.color,
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Titre
                        Text(
                          page.title,
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Description
                        Text(
                          page.description,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Contrôles de navigation
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Passer
                  TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(
                      'Passer',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ),
                  
                  // Indicateurs de page
                  Row(
                    children: List.generate(_pages.length, (index) {
                      return Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                        ),
                      );
                    }),
                  ),
                  
                  // Suivant/Commencer
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      _currentPage == _pages.length - 1 ? 'Commencer' : 'Suivant',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Modèle pour les pages d'onboarding
class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
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
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '© 2024 - Visualise ton année en couleurs',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}

/// Écran d'erreur pour les problèmes de chargement
class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorScreen({
    Key? key,
    required this.message,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                'Oups !',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget de chargement global
class GlobalLoadingIndicator extends ConsumerWidget {
  const GlobalLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loadingProvider);
    
    if (!isLoading) return const SizedBox.shrink();
    
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}