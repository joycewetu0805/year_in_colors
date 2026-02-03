import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/navigation_bar.dart';
import '../providers/settings_provider.dart';
import 'today_screen.dart';
import 'monthly_screen.dart';
import 'yearly_screen.dart';
import '../animations/fade_animation.dart';

/// Écran principal avec navigation par onglets
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    TodayScreen(),
    MonthlyScreen(),
    YearlyScreen(),
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
                      ? FadeAnimation(child: screen)
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
