import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/subscription/models/subscription.dart';

final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  return SubscriptionService(ref.read(apiClientProvider));
});

class SubscriptionService {
  final ApiClient _client;

  SubscriptionService(this._client);

  Future<Subscription> getStatus() async {
    final response = await _client.get('subscription');
    return Subscription.fromJson(response.data);
  }

  Future<void> mockSubscribe(String planId) async {
    // Mock purchase
    await _client.post('subscription/verify', data: {
      'plan_id': planId,
      'provider': 'mock_provider',
      'provider_subscription_id': 'mock_${DateTime.now().millisecondsSinceEpoch}',
    });
  }
}
