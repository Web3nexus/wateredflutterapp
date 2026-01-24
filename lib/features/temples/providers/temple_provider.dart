import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/temples/models/temple.dart';
import 'package:Watered/features/temples/services/temple_service.dart';

final templeListProvider = FutureProvider.autoDispose<List<Temple>>((ref) async {
  final service = ref.watch(templeServiceProvider);
  return service.getTemples();
});

// Used when location is available
final nearbyTemplesProvider = FutureProvider.autoDispose.family<List<Temple>, ({double lat, double lng})>((ref, coords) async {
  final service = ref.watch(templeServiceProvider);
  return service.getTemplesNearMe(coords.lat, coords.lng);
});
