import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecom/models/cart_item.dart';
import 'package:ecom/models/product.dart';

part 'cart_provider.g.dart';

const String _cartKey = 'cart_items';

@riverpod
class Cart extends _$Cart {
  late final SharedPreferences _prefs;

  @override
  List<CartItem> build() {
    _loadPrefs();
    return [];
  }

  Future<void> _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    final cartJson = _prefs.getString(_cartKey);
    if (cartJson != null) {
      final List<dynamic> cartList = jsonDecode(cartJson);
      state = cartList.map((item) {
        final product = Product.fromJson(item['product']);
        return CartItem(
          product: product,
          quantity: item['quantity'],
          selectedSize: item['selectedSize'],
          selectedColor: item['selectedColor'],
        );
      }).toList();
    }
  }

  Future<void> _saveCart() async {
    final cartJson = jsonEncode(
      state
          .map((item) => {
                'product': item.product.toJson(),
                'quantity': item.quantity,
                'selectedSize': item.selectedSize,
                'selectedColor': item.selectedColor,
              })
          .toList(),
    );
    await _prefs.setString(_cartKey, cartJson);
  }

  void addToCart(
    Product product, {
    required int quantity,
    String? selectedSize,
    String? selectedColor,
  }) {
    final existingItemIndex = state.indexWhere((item) =>
        item.product.id == product.id &&
        item.selectedSize == selectedSize &&
        item.selectedColor == selectedColor);

    if (existingItemIndex != -1) {
      // Update existing item quantity
      final existingItem = state[existingItemIndex];
      state = [
        ...state.sublist(0, existingItemIndex),
        existingItem.copyWith(quantity: existingItem.quantity + quantity),
        ...state.sublist(existingItemIndex + 1),
      ];
    } else {
      // Add new item
      state = [
        ...state,
        CartItem(
          product: product,
          quantity: quantity,
          selectedSize: selectedSize,
          selectedColor: selectedColor,
        ),
      ];
    }
    _saveCart();
  }

  void removeFromCart(int index) {
    state = [
      ...state.sublist(0, index),
      ...state.sublist(index + 1),
    ];
    _saveCart();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity <= 0) {
      removeFromCart(index);
      return;
    }

    state = [
      ...state.sublist(0, index),
      state[index].copyWith(quantity: quantity),
      ...state.sublist(index + 1),
    ];
    _saveCart();
  }

  void clearCart() {
    state = [];
    _saveCart();
  }

  double get totalPrice {
    return state.fold(0, (total, item) => total + item.totalPrice);
  }

  int get itemCount {
    return state.fold(0, (total, item) => total + item.quantity);
  }
}
