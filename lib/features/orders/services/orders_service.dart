import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/orders/models/order_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ordersServiceProvider = Provider((ref) => OrdersService(ref.read(apiClientProvider)));

class OrdersService {
  final ApiClient _apiClient;

  OrdersService(this._apiClient);

  Future<List<Order>> getOrders() async {
    try {
      final response = await _apiClient.get('orders');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => Order.fromJson(json)).toList();
      }
      throw Exception('Failed to load orders');
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}
