import 'package:flutter/material.dart';
import 'package:Watered/features/commerce/models/product.dart';
import 'package:intl/intl.dart';

class PriceUtils {
  static String formatPrice(Product product, String currencyCode) {
    final price = product.priceNgn ?? (product.price * 1500 / 100); // Guestimate if not set
    return '₦${NumberFormat('#,###').format(price)}';
  }

  static double getRawPrice(Product product, String currencyCode) {
    return product.priceNgn ?? (product.price * 1500 / 100);
  }
}
