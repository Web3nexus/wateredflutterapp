import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/core/network/api_client.dart';

final iapServiceProvider = Provider<IAPService>((ref) {
  return IAPService(ref);
});

class IAPService {
  final Ref _ref;
  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  IAPService(this._ref);

  void initialize() {
    final purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
      onDone: () => _subscription.cancel(),
      onError: (error) => print('IAP Error: $error'),
    );
  }

  Future<void> _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // Show pending UI if needed
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // Handle error
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
                   purchaseDetails.status == PurchaseStatus.restored) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
             _ref.read(authProvider.notifier).checkAuthStatus(); // Refresh user status
          }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _iap.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    try {
      final apiClient = _ref.read(apiClientProvider);
      final response = await apiClient.post('subscriptions/verify', data: {
        'product_id': purchaseDetails.productID,
        'purchase_token': purchaseDetails.verificationData.serverVerificationData,
        'platform': purchaseDetails.verificationData.source, // 'google_play' or 'apple_store'
      });
      return response.statusCode == 200;
    } catch (e) {
      print('Purchase verification failed: $e');
      return false;
    }
  }

  Future<void> buyProduct(String productId) async {
    final bool available = await _iap.isAvailable();
    if (!available) return;

    const Set<String> _kIds = {'premium_subscription_monthly', 'premium_subscription_yearly'};
    final ProductDetailsResponse response = await _iap.queryProductDetails({productId});
    
    if (response.notFoundIDs.isNotEmpty) {
      print('Product not found: $productId');
      return;
    }

    final PurchaseParam purchaseParam = PurchaseParam(productDetails: response.productDetails.first);
    await _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }
  
  void dispose() {
    _subscription.cancel();
  }
}
