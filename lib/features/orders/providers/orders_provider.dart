import 'package:Watered/features/orders/models/order_model.dart';
import 'package:Watered/features/orders/services/orders_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ordersProvider = FutureProvider.autoDispose<List<Order>>((ref) async {
  final ordersService = ref.watch(ordersServiceProvider);
  return await ordersService.getOrders();
});
