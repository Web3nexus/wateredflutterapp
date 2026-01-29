import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/services/location_service.dart';

final userCountryProvider = FutureProvider<String>((ref) async {
  final locationService = ref.watch(locationServiceProvider);
  return await locationService.getCountryCode();
});

final currencyProvider = Provider<String>((ref) {
  final countryCode = ref.watch(userCountryProvider).value ?? 'US';
  return countryCode == 'NG' ? 'NGN' : 'USD';
});
