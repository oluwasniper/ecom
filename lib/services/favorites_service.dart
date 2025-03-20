import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecom/models/product.dart';

class FavoritesService {
  static const String _key = 'favorites';

  Future<List<Product>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_key) ?? [];
    return favoritesJson
        .map((json) => Product.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> toggleFavorite(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    final existingIndex = favorites.indexWhere((p) => p.id == product.id);
    if (existingIndex >= 0) {
      favorites.removeAt(existingIndex);
    } else {
      final updatedProduct = product.copyWith(isFavorite: true);
      favorites.add(updatedProduct);
    }

    await prefs.setStringList(
      _key,
      favorites.map((p) => jsonEncode(p.toJson())).toList(),
    );
  }

  Future<bool> isFavorite(String productId) async {
    final favorites = await getFavorites();
    return favorites.any((p) => p.id == productId);
  }
}
