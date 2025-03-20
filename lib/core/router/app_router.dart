import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecom/presentation/screens/home_screen.dart';
import 'package:ecom/presentation/screens/search_screen.dart';
import 'package:ecom/presentation/screens/favourites_screen.dart';
import 'package:ecom/presentation/screens/profile_screen.dart';
import 'package:ecom/presentation/screens/product_details_screen.dart';
import 'package:ecom/widgets/bottom_nav.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/presentation/screens/onboarding_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _searchNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _favoritesNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _profileNavigatorKey =
    GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/onboarding',
      name: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNav(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: '/',
              name: AppRoutes.home,
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
                  path: 'product/:id',
                  name: AppRoutes.productDetails,
                  builder: (context, state) {
                    final product = state.extra as Product;
                    return ProductDetailsScreen(product: product);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _searchNavigatorKey,
          routes: [
            GoRoute(
              path: '/search',
              name: AppRoutes.search,
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _favoritesNavigatorKey,
          routes: [
            GoRoute(
              path: '/favourites',
              name: AppRoutes.favourites,
              builder: (context, state) => const FavouritesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            GoRoute(
              path: '/profile',
              name: AppRoutes.profile,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

// Route names as constants
class AppRoutes {
  static const String onboarding = 'onboarding';
  static const String home = 'home';
  static const String search = 'search';
  static const String favourites = 'favourites';
  static const String profile = 'profile';
  static const String productDetails = 'product-details';
}
