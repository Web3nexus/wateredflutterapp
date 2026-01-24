import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/subscription/models/subscription.dart';
import 'package:Watered/features/subscription/services/subscription_service.dart';

final subscriptionStatusProvider = FutureProvider.autoDispose<Subscription>((ref) async {
  final service = ref.watch(subscriptionServiceProvider);
  return await service.getStatus();
});
