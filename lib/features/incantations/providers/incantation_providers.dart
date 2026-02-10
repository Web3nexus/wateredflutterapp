import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/incantations/models/incantation.dart';
import 'package:Watered/features/incantations/services/incantation_service.dart';

final incantationsListProvider = FutureProvider.autoDispose.family<List<Incantation>, String?>((ref, category) async {
  final service = ref.watch(incantationServiceProvider);
  return await service.getIncantations(category: category);
});
