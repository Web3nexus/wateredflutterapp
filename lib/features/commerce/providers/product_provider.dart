import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/features/commerce/models/product.dart';
import 'package:wateredflutterapp/features/commerce/services/product_service.dart';

final productListProvider = FutureProvider.autoDispose<List<Product>>((ref) async {
  final service = ref.watch(productServiceProvider);
  return service.getProducts();
});

final productDetailProvider = FutureProvider.autoDispose.family<Product, int>((ref, id) async {
  final service = ref.watch(productServiceProvider);
  return service.getProduct(id);
});
