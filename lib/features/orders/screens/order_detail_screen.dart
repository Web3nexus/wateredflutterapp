import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/orders/models/order_model.dart';
import 'package:Watered/features/orders/services/order_application_service.dart';
import 'package:Watered/features/orders/screens/application_form_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  final int orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late OrderApplicationService _orderService;
  Order? _order;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _orderService = OrderApplicationService(context.read<ApiClient>());
    _loadOrder();
  }

  Future<void> _loadOrder() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final order = await _orderService.getOrderDetails(widget.orderId);
      setState(() {
        _order = order;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load details. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                      ElevatedButton(onPressed: _loadOrder, child: const Text('Retry')),
                    ],
                  ),
                )
              : _buildContent(context, _order!),
    );
  }

  Widget _buildContent(BuildContext context, Order order) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              order.title,
              style: const TextStyle(
                fontFamily: 'Cinzel',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            background: order.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: order.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: theme.colorScheme.surface),
                    errorWidget: (context, url, error) => Container(color: theme.colorScheme.surface),
                  )
                : Container(color: theme.colorScheme.surface),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        order.status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (order.orderLevel > 1)
                      Row(
                        children: List.generate(
                          order.orderLevel,
                          (index) => Icon(Icons.star, size: 16, color: Colors.amber),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'About this Path',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFamily: 'Cinzel',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  order.description ?? 'No description available.',
                  style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                ),
                const SizedBox(height: 32),
                if (order.status != 'closed')
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ApplicationFormScreen(order: order),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        order.ctaText,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
