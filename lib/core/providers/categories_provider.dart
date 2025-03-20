import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_provider.g.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

@riverpod
class Categories extends _$Categories {
  @override
  List<Category> build() {
    return [
      Category(
        id: 'phones',
        name: 'Phones',
        icon: Icons.phone_android,
        color: Colors.blue,
      ),
      Category(
        id: 'laptops',
        name: 'Laptops',
        icon: Icons.laptop,
        color: Colors.green,
      ),
      Category(
        id: 'tvs',
        name: 'TVs',
        icon: Icons.tv,
        color: Colors.orange,
      ),
      Category(
        id: 'watches',
        name: 'Watches',
        icon: Icons.watch,
        color: Colors.purple,
      ),
      Category(
        id: 'audio',
        name: 'Audio',
        icon: Icons.headphones,
        color: Colors.red,
      ),
      Category(
        id: 'cameras',
        name: 'Cameras',
        icon: Icons.camera_alt,
        color: Colors.teal,
      ),
      Category(
        id: 'gaming',
        name: 'Gaming',
        icon: Icons.sports_esports,
        color: Colors.indigo,
      ),
      Category(
        id: 'smart_home',
        name: 'Smart Home',
        icon: Icons.home,
        color: Colors.brown,
      ),
    ];
  }

  Category getById(String id) {
    return state.firstWhere(
      (category) => category.id == id,
      orElse: () => throw Exception('Category not found'),
    );
  }
}
