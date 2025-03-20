import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ecom/models/product.dart';

part 'products_provider.g.dart';

@riverpod
class Products extends _$Products {
  @override
  List<Product> build() {
    return [
      Product(
        id: '1',
        name: 'Wireless Earbuds Pro',
        description:
            'High-quality wireless earbuds with active noise cancellation',
        price: 129.99,
        imageUrl: 'assets/images/products/earbuds.jpg',
        category: 'Audio',
        sizes: null,
        colors: ['Black', 'White', 'Navy'],
      ),
      Product(
        id: '2',
        name: 'Smart Watch Series X',
        description: 'Advanced fitness tracker with heart rate monitoring',
        price: 199.99,
        imageUrl: 'assets/images/products/smartwatch.jpg',
        category: 'Watches',
        sizes: ['S', 'M', 'L'],
        colors: ['Silver', 'Gold', 'Space Gray'],
      ),
      Product(
        id: '3',
        name: 'Premium Laptop Stand',
        description: 'Ergonomic aluminum laptop stand with cooling',
        price: 49.99,
        imageUrl: 'assets/images/products/laptop_stand.jpg',
        category: 'Laptops',
        sizes: null,
        colors: ['Silver', 'Black'],
      ),
      Product(
        id: '4',
        name: 'HD Webcam',
        description: '1080p webcam with built-in microphone',
        price: 39.99,
        imageUrl: 'assets/images/products/webcam.jpg',
        category: 'Cameras',
        sizes: null,
        colors: ['Black'],
      ),
      Product(
        id: '5',
        name: 'Mechanical Keyboard',
        description: 'RGB mechanical keyboard with customizable switches',
        price: 149.99,
        imageUrl: 'assets/images/products/keyboard.jpg',
        category: 'Gaming',
        sizes: null,
        colors: ['Black', 'White'],
      ),
      Product(
        id: '6',
        name: 'Gaming Mouse',
        description: 'High-precision gaming mouse with adjustable DPI',
        price: 79.99,
        imageUrl: 'assets/images/products/mouse.jpg',
        category: 'Gaming',
        sizes: null,
        colors: ['Black', 'White', 'RGB'],
      ),
      Product(
        id: '7',
        name: 'Bluetooth Speaker',
        description: 'Portable Bluetooth speaker with 20-hour battery life',
        price: 89.99,
        imageUrl: 'assets/images/products/speaker.jpg',
        category: 'Audio',
        sizes: null,
        colors: ['Black', 'Blue', 'Red'],
      ),
      Product(
        id: '8',
        name: 'Phone Case',
        description: 'Durable phone case with military-grade protection',
        price: 24.99,
        imageUrl: 'assets/images/products/phone_case.jpg',
        category: 'Phones',
        sizes: ['iPhone 13', 'iPhone 14', 'iPhone 15'],
        colors: ['Clear', 'Black', 'Navy'],
      ),
    ];
  }

  Product getById(String id) {
    return state.firstWhere(
      (product) => product.id == id,
      orElse: () => throw Exception('Product not found'),
    );
  }

  List<Product> search(String query) {
    final lowercaseQuery = query.toLowerCase();
    return state.where((product) {
      return product.name.toLowerCase().contains(lowercaseQuery) ||
          product.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  List<Product> filterByCategory(String category) {
    return state.where((product) => product.category == category).toList();
  }

  List<Product> filterByPriceRange(double minPrice, double maxPrice) {
    return state.where((product) {
      return product.price >= minPrice && product.price <= maxPrice;
    }).toList();
  }
}
