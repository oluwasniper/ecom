import 'package:flutter/material.dart';
import 'package:ecom/presentation/screens/home_screen.dart';
import 'package:ecom/presentation/screens/favourites_screen.dart';
import 'package:ecom/presentation/screens/search_screen.dart';
import 'package:ecom/presentation/screens/profile_screen.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class BottomNav extends StatefulWidget {
  BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
  int selectedIndex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    FavouritesScreen(),
    ProfileScreen(),
  ];
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          widget.screens[widget.selectedIndex],
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
                  color: Theme.of(context).colorScheme.surface,
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
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.selectedIndex = 0;
                        });
                      },
                      icon: Icon(
                        Icons.home,
                        color: widget.selectedIndex == 0
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.selectedIndex = 1;
                        });
                      },
                      icon: Icon(
                        Icons.search,
                        color: widget.selectedIndex == 1
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.selectedIndex = 2;
                        });
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: widget.selectedIndex == 2
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.selectedIndex = 3;
                        });
                      },
                      icon: Icon(
                        Icons.person,
                        color: widget.selectedIndex == 3
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        AdaptiveTheme.of(context).toggleThemeMode();
                      },
                      icon: Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.5),
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
}
