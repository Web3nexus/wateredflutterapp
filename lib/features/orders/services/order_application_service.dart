import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/orders/models/order_application_model.dart';
import 'package:Watered/features/orders/models/order_model.dart';

class OrderApplicationService {
  final ApiClient _apiClient;

  OrderApplicationService(this._apiClient);

  Future<Order> getOrderDetails(int orderId) async {
    try {
      final response = await _apiClient.get('orders/$orderId');
      return Order.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderApplication>> getUserApplications() async {
    try {
      final response = await _apiClient.get('order-applications');
      final List data = response.data['data'];
      return data.map((json) => OrderApplication.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<OrderApplication> submitApplication(int orderId, Map<String, dynamic> answers) async {
    try {
      final response = await _apiClient.post(
        'orders/$orderId/apply',
        data: {'answers': answers},
      );
      return OrderApplication.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
