import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/core/network/api_client.dart';
import 'package:wateredflutterapp/features/commerce/models/product.dart';

final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService(ref.read(apiClientProvider));
});

class ProductService {
  final ApiClient _client;

  ProductService(this._client);

  Future<List<Product>> getProducts() async {
    try {
      final response = await _client.get('products');
      // Assuming generic collection wrap 'data'
      final List data = response.data['data'] ?? [];
      return data.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to load products.';
    }
  }

  Future<Product> getProduct(int id) async {
    try {
      final response = await _client.get('products/$id');
      return Product.fromJson(response.data['data']);
    } catch (e) {
      throw 'Failed to load product details.';
    }
  }
}
