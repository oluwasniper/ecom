import 'dart:convert';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String>? sizes;
  final List<String>? colors;
  final bool isFavorite;
  final String category;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.sizes,
    this.colors,
    this.isFavorite = false,
  });

  /// Factory constructor to create a `Product` from JSON.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      sizes: (json['sizes'] as List<dynamic>?)?.cast<String>(),
      colors: (json['colors'] as List<dynamic>?)?.cast<String>(),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  /// Converts a `Product` object to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'sizes': sizes,
      'colors': colors,
      'isFavorite': isFavorite,
    };
  }

  /// Creates a new instance with updated values.
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    List<String>? sizes,
    List<String>? colors,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /// Converts a list of `Product` objects into JSON.
  static String encodeList(List<Product> products) =>
      jsonEncode(products.map((p) => p.toJson()).toList());

  /// Decodes a JSON string back into a list of `Product` objects.
  static List<Product> decodeList(String jsonStr) {
    final List<dynamic> jsonData = jsonDecode(jsonStr);
    return jsonData.map((item) => Product.fromJson(item)).toList();
  }
}
