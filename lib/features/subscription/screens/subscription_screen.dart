import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter_paystack_plus/flutter_paystack_plus.dart';
import 'package:Watered/features/subscription/providers/subscription_providers.dart';
import 'package:Watered/features/subscription/services/subscription_service.dart';
import 'package:Watered/features/config/providers/global_settings_provider.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  bool _isLoading = false;
  late final Stream<List<PurchaseDetails>> _purchaseUpdated;

  @override
  void initState() {
    super.initState();
    _purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _purchaseUpdated.listen((purchaseDetailsList) {
      _handlePurchaseUpdates(purchaseDetailsList);
    }, onDone: () {
      // Handle when the stream is closed
    }, onError: (error) {
      // Handle stream errors
    });
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        setState(() => _isLoading = true);
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          setState(() => _isLoading = false);
          _showError(purchaseDetails.error?.message ?? 'Purchase failed');
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
                   purchaseDetails.status == PurchaseStatus.restored) {
          // Verify with backend
          try {
            await ref.read(subscriptionServiceProvider).verifyApplePurchase(
              planId: purchaseDetails.productID,
              receiptData: purchaseDetails.verificationData.serverVerificationData,
            );
            
            if (purchaseDetails.pendingCompletePurchase) {
              await InAppPurchase.instance.completePurchase(purchaseDetails);
            }
            
            ref.refresh(subscriptionStatusProvider);
            _showSuccess('Welcome to Premium!');
          } catch (e) {
            _showError('Backend verification failed: $e');
          } finally {
            setState(() => _isLoading = false);
          }
        }
        
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.green));
  }

  Future<void> _subscribe(BuildContext context, String planId) async {
    if (Platform.isIOS) {
      await _subscribeWithApple(planId);
    } else {
      await _subscribeWithPaystack(context, planId);
    }
  }

  Future<void> _subscribeWithApple(String planId) async {
    // Get the real product ID from settings
    final settings = ref.read(globalSettingsNotifierProvider).valueOrNull;
    final productId = (planId.contains('monthly')) 
        ? (settings?.premiumMonthlyId ?? planId) 
        : (settings?.premiumYearlyId ?? planId);

    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      _showError('App Store is currently unavailable');
      return;
    }

    const Set<String> _kIds = {}; // We'd ideally fetch these from settings too
    final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails({productId});
    
    if (response.notFoundIDs.contains(productId)) {
       _showError('Product not found in App Store');
       return;
    }

    final PurchaseParam purchaseParam = PurchaseParam(productDetails: response.productDetails.first);
    await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> _subscribeWithPaystack(BuildContext context, String planId) async {
    final settings = ref.read(globalSettingsNotifierProvider).valueOrNull;
    final publicKey = settings?.paystackPublicKey;
    final user = ref.read(authProvider).user;
    
    if (publicKey == null || publicKey.isEmpty) {
      _showError('Paystack is not configured in settings');
      return;
    }

    setState(() => _isLoading = true);
    
    try {
      // Dynamic amount from backend, fallback to hardcoded defaults
      final int amount = planId.contains('monthly')
          ? (settings?.premiumMonthlyAmount ?? 500000) 
          : (settings?.premiumYearlyAmount ?? 5000000);
      
      final String reference = 'sub_${DateTime.now().millisecondsSinceEpoch}';

      await FlutterPaystackPlus.openPaystackPopup(
        publicKey: publicKey,
        context: context,
        customerEmail: user?.email ?? 'customer@example.com',
        amount: amount.toString(), // amount from settings is already in kobo/cents
        reference: reference,
        onClosed: () {
          setState(() => _isLoading = false);
          _showError('Payment closed');
        },
        onSuccess: () async {
          try {
            await ref.read(subscriptionServiceProvider).verifyPaystackPayment(
              planId: planId,
              reference: reference,
            );
            ref.refresh(subscriptionStatusProvider);
            _showSuccess('Paystack payment successful!');
          } catch (e) {
            _showError('Verification failed: $e');
          } finally {
            setState(() => _isLoading = false);
          }
        },
      );
    } catch (e) {
      _showError('Paystack Error: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusAsync = ref.watch(subscriptionStatusProvider);
    final settings = ref.watch(globalSettingsNotifierProvider).valueOrNull;

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
                const SizedBox(height: 20),
                Icon(Icons.auto_awesome_rounded, size: 64, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 16),
                Text(
                  settings?.premiumTitle ?? 'WATERED PLUS+',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Cinzel', fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 4, color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 8),
                Text(
                  settings?.premiumSubtitle ?? 'Unlock the full depth of African spirituality.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white60, fontSize: 14),
                ),
                const SizedBox(height: 48),
                _PlanCard(
                  title: 'Monthly Plan',
                  price: settings?.premiumMonthlyPrice ?? '₦5,000 / month',
                  features: settings?.premiumFeatures ?? const ['Complete Sacred Library', 'Daily Audio Teachings', 'Community Access', 'Unlimited Rituals'],
                  onTap: () => _subscribe(context, 'monthly_premium'),
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 16),
                _PlanCard(
                  title: 'Yearly Plan',
                  price: settings?.premiumYearlyPrice ?? '₦50,000 / year',
                  features: settings?.premiumFeatures ?? const ['Everything in Monthly', '2 Months Free', 'Exclusive Yearly Content', 'Priority Support'],
                  isBestValue: true,
                  onTap: () => _subscribe(context, 'yearly_premium'),
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _isLoading ? null : () => _subscribe(context, 'free_trial'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white10,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1)),
                  ),
                  child: const Text('START 7-DAY FREE TRIAL', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                ),
                const SizedBox(height: 24),
                TextButton(
                    onPressed: _isLoading ? null : () async {
                      if (Platform.isIOS) {
                        setState(() => _isLoading = true);
                        await InAppPurchase.instance.restorePurchases();
                        setState(() => _isLoading = false);
                      }
                    },
                    child: Text('Restore Purchases', style: TextStyle(color: theme.textTheme.bodySmall?.color?.withOpacity(0.5)))
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
        border: isBestValue ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2) : null,
      ),
      child: Column(
        children: [
          if (isBestValue) ...[
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
               decoration: BoxDecoration(
                   color: Theme.of(context).colorScheme.primary,
                   borderRadius: BorderRadius.circular(12),
               ),
               child: const Text('BEST VALUE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
             ),
             const SizedBox(height: 12),
          ],
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(price, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
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
