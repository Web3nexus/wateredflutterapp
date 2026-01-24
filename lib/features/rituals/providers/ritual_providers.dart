import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/rituals/models/ritual.dart';
import 'package:Watered/features/rituals/services/ritual_service.dart';

final ritualsListProvider = FutureProvider.autoDispose<List<Ritual>>((ref) async {
  final service = ref.watch(ritualServiceProvider);
  return await service.getRituals();
});
