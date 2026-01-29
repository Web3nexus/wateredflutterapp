import 'package:flutter/material.dart';
import 'package:Watered/features/commerce/models/product.dart';

class PriceUtils {
  static String formatPrice(Product product, String currencyCode) {
    if (currencyCode == 'NGN') {
      final price = product.priceNgn ?? (product.price * 1500 / 100); // Guestimate if not set
      return '₦${price.toStringAsFixed(0)}';
    } else {
      final price = product.priceUsd ?? (product.price / 100);
      return '\$${price.toStringAsFixed(2)}';
    }
  }

  static double getRawPrice(Product product, String currencyCode) {
     if (currencyCode == 'NGN') {
      return product.priceNgn ?? (product.price * 1500 / 100);
    } else {
      return product.priceUsd ?? (product.price / 100);
    }
  }
}
