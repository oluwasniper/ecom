import 'package:flutter/material.dart';
import 'package:ecom/presentation/screens/home_screen.dart';
import 'package:ecom/presentation/screens/favourites_screen.dart';
import 'package:ecom/presentation/screens/search_screen.dart';
import 'package:ecom/presentation/screens/profile_screen.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          _screens[_selectedIndex],
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(0, Icons.home),
                    _buildNavItem(1, Icons.search),
                    _buildNavItem(2, Icons.favorite),
                    _buildNavItem(3, Icons.person),
                    IconButton(
                      onPressed: () {
                        AdaptiveTheme.of(context).toggleThemeMode();
                      },
                      icon: Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode,
                        color: isDark
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    final theme = Theme.of(context);
    return IconButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      icon: Icon(
        icon,
        color: _selectedIndex == index
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface.withOpacity(0.5),
      ),
    );
  }
}
