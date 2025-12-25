import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/navigation_bar.dart';
import 'today_screen.dart';
import 'monthly_screen.dart';
import 'yearly_screen.dart';
import '../animations/fade_animation.dart';

/// Écran principal avec navigation par onglets
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const TodayScreen(),
    const MonthlyScreen(),
    const YearlyScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _screens.length, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    final showAnimations = ref.watch(animationsEnabledProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Contenu principal
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: _screens.map((screen) {
                  return showAnimations
                      ? FadeAnimation(
                          child: screen,
                          duration: const Duration(milliseconds: 300),
                        )
                      : screen;
                }).toList(),
              ),
            ),
            
            // Barre de navigation
            AppNavigationBar(
              currentIndex: _currentIndex,
              onTabSelected: _onTabSelected,
            ),
          ],
        ),
      ),
    );
  }
}

/// Écran de chargement initial
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            const Spacer(flex: 2),
            
            FadeAnimation(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.color_lens,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              duration: const Duration(milliseconds: 800),
            ),
            
            const SizedBox(height: 24),
            
            // Titre
            FadeAnimation(
              child: Text(
                'Year in Colors',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              duration: const Duration(milliseconds: 1000),
            ),
            
            const SizedBox(height: 8),
            
            // Sous-titre
            FadeAnimation(
              child: Text(
                'Visualise ton année en couleurs',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              duration: const Duration(milliseconds: 1200),
            ),
            
            const Spacer(flex: 3),
            
            // Indicateur de chargement
            FadeAnimation(
              child: const CircularProgressIndicator(),
              duration: const Duration(milliseconds: 1400),
            ),
            
            const SizedBox(height: 32),
          ],
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

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Marque chaque jour',
      'description': 'Clique sur 🟢 pour un bon jour, 🔴 pour un mauvais jour',
      'icon': Icons.emoji_emotions,
      'color': Colors.green,
    },
    {
      'title': 'Visualise ta progression',
      'description': 'Vois ton mois et ton année en un coup d\'œil',
      'icon': Icons.calendar_today,
      'color': Colors.blue,
    },
    {
      'title': 'Pas de jugement',
      'description': 'C\'est ton miroir visuel, pas un juge',
      'icon': Icons.visibility,
      'color': Colors.purple,
    },
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
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
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
                            color: page['color'].withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            page['icon'],
                            size: 60,
                            color: page['color'],
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Titre
                        Text(
                          page['title'],
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 16),
                        
                        // Description
                        Text(
                          page['description'],
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
            
            // Boutons de navigation
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