import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecom/presentation/screens/splash_screen.dart';
import 'package:ecom/presentation/screens/onboarding_screen.dart';
import 'package:ecom/presentation/screens/home_screen.dart';
import 'package:ecom/presentation/screens/cart_screen.dart';
import 'package:ecom/presentation/screens/favourites_screen.dart';
import 'package:ecom/presentation/screens/product_details_screen.dart';
import 'package:ecom/presentation/screens/profile_screen.dart';
import 'package:ecom/presentation/screens/search_screen.dart';
import 'package:ecom/widgets/bottom_nav.dart';
import 'package:ecom/models/product.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    // Auth routes (splash and onboarding)
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Shell route for bottom navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => BottomNav(
        navigationShell: navigationShell,
      ),
      branches: [
        // Home branch
        StatefulShellBranch(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
                  path: 'product/:id',
                  builder: (context, state) => ProductDetailsScreen(
                    product: state.extra as Product,
                  ),
                ),
              ],
            ),
          ],
        ),

        // Search branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),

        // Favorites branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavouritesScreen(),
            ),
          ],
        ),

        // Cart branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cart',
              builder: (context, state) => const CartScreen(),
            ),
          ],
        ),

        // Profile branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

// Extension methods for easier navigation
extension RouterExtension on BuildContext {
  void pushHome() => go('/');
  void pushSearch() => go('/search');
  void pushFavorites() => go('/favorites');
  void pushCart() => go('/cart');
  void pushProfile() => go('/profile');
  void pushProduct(Product product) =>
      go('/product/${product.id}', extra: product);
  void pushOnboarding() => go('/onboarding');
}
