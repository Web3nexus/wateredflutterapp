import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/features/commerce/models/product.dart';
import 'package:wateredflutterapp/features/commerce/providers/cart_provider.dart';
import 'package:wateredflutterapp/features/commerce/screens/cart_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
         backgroundColor: Colors.transparent,
         actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFFD4AF37)),
                  onPressed: () {
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const CartScreen()),
                     );
                  },
                ),
                 if (ref.watch(cartProvider).isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(minWidth: 8, minHeight: 8),
                    ),
                  ),
              ],
            )
         ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Image
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                   product.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: product.imageUrl!,
                          fit: BoxFit.cover,
                          height: 400,
                          width: double.infinity,
                        )
                      : Container(
                          color: Colors.white10,
                          child: const Center(child: Icon(Icons.diamond_outlined, size: 80, color: Colors.white24)),
                        ),
                   Container(
                     decoration: BoxDecoration(
                       gradient: LinearGradient(
                         begin: Alignment.topCenter,
                         end: Alignment.bottomCenter,
                         colors: [Colors.black.withOpacity(0.4), Colors.transparent, const Color(0xFF0F172A)],
                       ),
                     ),
                   ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name.toUpperCase(),
                    style: const TextStyle(
                      fontFamily: 'Cinzel',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${(product.price / 100).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Color(0xFFD4AF37),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (product.description != null)
                    Text(
                      product.description!,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.white.withOpacity(0.8),
                        fontFamily: 'Outfit',
                      ),
                    ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
               ref.read(cartProvider.notifier).addToCart(product);
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('${product.name} added to cart')),
               );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('ADD TO CART', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
        ),
      ),
    );
  }
}
