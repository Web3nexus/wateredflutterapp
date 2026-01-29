import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/commerce/providers/cart_provider.dart';
import 'package:Watered/features/commerce/providers/currency_provider.dart';
import 'package:Watered/features/commerce/utils/price_utils.dart';
import 'package:flutter_paystack_plus/flutter_paystack_plus.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';

class PaymentSelectionScreen extends ConsumerStatefulWidget {
  const PaymentSelectionScreen({super.key});

  @override
  ConsumerState<PaymentSelectionScreen> createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends ConsumerState<PaymentSelectionScreen> {
  String? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currency = ref.watch(currencyProvider);
    final cartItems = ref.watch(cartProvider);
    final totalValue = cartItems.fold(0.0, (sum, item) => sum + (PriceUtils.getRawPrice(item.product, currency) * item.quantity));

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('PAYMENT METHOD'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select how you would like to pay',
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7)),
            ),
            const SizedBox(height: 32),
            
            if (currency == 'USD') ...[
              _buildPaymentOption(
                'stripe',
                'Stripe (International Card)',
                Icons.credit_card_rounded,
                'Pay with Visa, Master, or AMEX',
              ),
            ] else ...[
              _buildPaymentOption(
                'paystack',
                'Paystack',
                Icons.account_balance_wallet_rounded,
                'Pay with Card, Bank or Transfer',
              ),
              const SizedBox(height: 16),
              _buildPaymentOption(
                'flutterwave',
                'Flutterwave',
                Icons.payments_rounded,
                'Alternative local payment method',
              ),
            ],
            
            const Spacer(),
            
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Amount to Pay', style: TextStyle(fontSize: 16)),
                      Text(
                        currency == 'NGN' ? '₦${totalValue.toStringAsFixed(0)}' : '\$${totalValue.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedMethod == null ? null : () => _handlePayment(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        disabledBackgroundColor: theme.colorScheme.primary.withOpacity(0.3),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('PAY NOW', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String id, String name, IconData icon, String subtitle) {
    final theme = Theme.of(context);
    final isSelected = _selectedMethod == id;

    return InkWell(
      onTap: () => setState(() => _selectedMethod = id),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: theme.colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: theme.textTheme.bodySmall?.color?.withOpacity(0.6))),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: theme.colorScheme.primary)
            else
              Icon(Icons.circle_outlined, color: theme.textTheme.bodySmall?.color?.withOpacity(0.2)),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePayment() async {
    final currency = ref.read(currencyProvider);
    final cartItems = ref.watch(cartProvider);
    final totalValue = cartItems.fold(0.0, (sum, item) => sum + (PriceUtils.getRawPrice(item.product, currency) * item.quantity));

    if (_selectedMethod == 'paystack') {
      try {
        await FlutterPaystackPlus.openPaystackPopup(
          publicKey: 'pk_test_placeholder', // User should replace with actual key
          context: context,
          amount: (totalValue * 100).toInt().toString(),
          customerEmail: ref.read(authProvider).user?.email ?? 'seeker@watered.app',
          reference: DateTime.now().millisecondsSinceEpoch.toString(),
          onClosed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment Cancelled')));
          },
          onSuccess: () {
             Navigator.pop(context, true);
          },
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Paystack Error: $e')));
      }
      return;
    }

    // Default simulation for others
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Processing payment with $_selectedMethod...')),
    );
    
    // Simulate checkout
    await Future.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      Navigator.pop(context, true);
    }
  }
}
