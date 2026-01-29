import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/commerce/providers/cart_provider.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Watered/features/commerce/screens/payment_selection_screen.dart';
import 'package:Watered/features/commerce/providers/currency_provider.dart';
import 'package:Watered/features/commerce/utils/price_utils.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.read(cartProvider.notifier).totalPrice;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currency = ref.watch(currencyProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('YOUR CART'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.colorScheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text('Your cart is empty.', style: TextStyle(color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5))),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    separatorBuilder: (context, index) => Divider(color: theme.dividerColor.withOpacity(0.1)),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: theme.colorScheme.primary.withOpacity(0.05),
                          ),
                          child: item.product.imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: item.product.imageUrl!,
                                fit: BoxFit.cover,
                              ),
                            ) 
                          : const Icon(Icons.diamond_outlined, color: Colors.white24),
                        ),
                        title: Text(item.product.name, style: TextStyle(color: theme.textTheme.titleMedium?.color, fontWeight: FontWeight.bold, fontFamily: 'Cinzel')),
                        subtitle: Text('${PriceUtils.formatPrice(item.product, currency)} x ${item.quantity}', style: TextStyle(color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6))),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                          onPressed: () {
                             ref.read(cartProvider.notifier).updateQuantity(item.product, item.quantity - 1);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    border: Border(top: BorderSide(color: theme.dividerColor.withOpacity(0.05))),
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: TextStyle(color: theme.textTheme.titleLarge?.color, fontSize: 18, fontWeight: FontWeight.bold)),
                             Text(
                              currency == 'NGN' 
                                ? '₦${cartItems.fold(0, (sum, item) => sum + (PriceUtils.getRawPrice(item.product, 'NGN') * item.quantity).toInt())}'
                                : '\$${(total / 100).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 24,
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                               // Perform Checkout
                               try {
                                   final client = ref.read(apiClientProvider);
                                   await client.post('/checkout', data: {
                                      'items': cartItems.map((e) => {
                                          'product_id': e.product.id,
                                          'quantity': e.quantity,
                                      }).toList()
                                   });
                                   
                                   ref.read(cartProvider.notifier).clearCart();
                                   if (context.mounted) {
                                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order placed successfully!')));
                                       Navigator.pop(context);
                                   }
                               } catch (e) {
                                   if (context.mounted) {
                                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Checkout failed: $e'), backgroundColor: Colors.red));
                                   }
                               }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('CHECKOUT', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
