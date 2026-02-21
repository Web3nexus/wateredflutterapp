import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/orders/providers/orders_provider.dart';
import 'package:Watered/features/orders/widgets/order_card.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final ordersAsync = ref.watch(ordersProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('ORDERS', style: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.bold, letterSpacing: 2)),
      ),
      body: ordersAsync.when(
        data: (orders) {
          if (orders.isEmpty) {
            return const Center(child: Text('No orders available at this time.'));
          }
          
          return RefreshIndicator(
            onRefresh: () async => ref.refresh(ordersProvider),
            child: ListView.separated(
              padding: const EdgeInsets.all(24.0),
              itemCount: orders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(order: order);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              const Text('Failed to load orders Phase', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(error.toString(), textAlign: TextAlign.center, style: theme.textTheme.bodySmall),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(ordersProvider),
                child: const Text('Try Again'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
