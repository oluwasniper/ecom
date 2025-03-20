import 'package:ecom/models/product.dart';

class CartItem {
  final Product product;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;

  CartItem({
    required this.product,
    required this.quantity,
    this.selectedSize,
    this.selectedColor,
  });

  double get totalPrice => product.price * quantity;

  CartItem copyWith({
    Product? product,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }
}
