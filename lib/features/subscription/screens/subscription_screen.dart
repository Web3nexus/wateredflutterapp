import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/subscription/providers/subscription_providers.dart';
import 'package:Watered/features/subscription/services/subscription_service.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  bool _isLoading = false;

  Future<void> _subscribe(String planId) async {
    setState(() => _isLoading = true);
    try {
      await ref.read(subscriptionServiceProvider).mockSubscribe(planId);
      ref.refresh(subscriptionStatusProvider); // Refresh status
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Welcome to Premium!')),
         );
      }
    } catch (e) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Error: $e')),
         );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusAsync = ref.watch(subscriptionStatusProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Premium Access')),
      body: statusAsync.when(
        data: (subscription) {
          if (subscription.isPremium) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.verified_user_rounded, size: 64, color: Colors.green),
                  const SizedBox(height: 16),
                  Text(
                    'You are a Premium Member',
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enjoy your exclusive access.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            );
          }

          // Show Plans
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PlanCard(
                  title: 'Monthly Plan',
                  price: '\$9.99 / month',
                  features: const ['Unlimited Incantations', 'Access to Rituals', 'Priority Booking'],
                  onTap: () => _subscribe('monthly_premium'),
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 16),
                _PlanCard(
                  title: 'Yearly Plan',
                  price: '\$99.99 / year',
                  features: const ['All Monthly Features', '2 Months Free', 'Badge on Profile'],
                  isBestValue: true,
                  onTap: () => _subscribe('yearly_premium'),
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 32),
                TextButton(
                    onPressed: _isLoading ? null : () {},
                    child: Text('Restore Purchases', style: TextStyle(color: theme.textTheme.bodySmall?.color))
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final VoidCallback onTap;
  final bool isBestValue;
  final bool isLoading;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.features,
    required this.onTap,
    this.isBestValue = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: isBestValue ? Border.all(color: const Color(0xFFD4AF37), width: 2) : null,
      ),
      child: Column(
        children: [
          if (isBestValue) ...[
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
               decoration: BoxDecoration(
                   color: const Color(0xFFD4AF37),
                   borderRadius: BorderRadius.circular(12),
               ),
               child: const Text('BEST VALUE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
             ),
             const SizedBox(height: 12),
          ],
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(price, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFFD4AF37))),
          const SizedBox(height: 24),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: Colors.green, size: 20),
                const SizedBox(width: 12),
                Text(f, style: theme.textTheme.bodyMedium),
              ],
            ),
          )),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : onTap,
              style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: isLoading 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('SUBSCRIBE NOW', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
