import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecom/models/product.dart';
import 'package:ecom/services/favorites_service.dart';

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Product>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<List<Product>> {
  FavoritesNotifier() : super([]) {
    _loadFavorites();
  }

  final FavoritesService _favoritesService = FavoritesService();

  Future<void> _loadFavorites() async {
    state = await _favoritesService.getFavorites();
  }

  Future<void> toggleFavorite(Product product) async {
    await _favoritesService.toggleFavorite(product);
    _loadFavorites();
  }
}
