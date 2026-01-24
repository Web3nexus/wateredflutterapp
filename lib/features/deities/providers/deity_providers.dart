import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/deities/models/deity.dart';
import 'package:Watered/features/deities/services/deity_service.dart';
import 'package:Watered/features/traditions/models/tradition.dart';

// State for selected tradition filter
final selectedTraditionProvider = StateProvider<int?>((ref) => null);

final traditionsListProvider = FutureProvider.autoDispose<List<Tradition>>((ref) async {
  final service = ref.watch(deityServiceProvider);
  return await service.getTraditions();
});

final deitiesListProvider = FutureProvider.autoDispose<List<Deity>>((ref) async {
  final service = ref.watch(deityServiceProvider);
  final traditionId = ref.watch(selectedTraditionProvider);
  return await service.getDeities(traditionId: traditionId);
});
