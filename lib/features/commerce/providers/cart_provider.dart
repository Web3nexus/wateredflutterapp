import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/features/commerce/models/cart_item.dart';
import 'package:wateredflutterapp/features/commerce/models/product.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product) {
    // Check if exists
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      // Increment
      final item = state[index];
      state = [
        ...state.sublist(0, index),
        item.copyWith(quantity: item.quantity + 1),
        ...state.sublist(index + 1),
      ];
    } else {
      // Add new
      state = [...state, CartItem(product: product)];
    }
  }

  void removeFromCart(Product product) {
    state = state.where((item) => item.product.id != product.id).toList();
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      removeFromCart(product);
      return;
    }
    
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
        final item = state[index];
        state = [
          ...state.sublist(0, index),
          item.copyWith(quantity: quantity),
          ...state.sublist(index + 1),
        ];
    }
  }

  void clearCart() {
    state = [];
  }
  
  // Getters for totals
  int get itemCount => state.fold(0, (sum, item) => sum + item.quantity);
  int get totalPrice => state.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
}
