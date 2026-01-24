import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/consultation/models/consultation_type.dart';
import 'package:Watered/features/consultation/services/booking_service.dart';

final consultationTypesProvider = FutureProvider.autoDispose<List<ConsultationType>>((ref) async {
  final service = ref.watch(bookingServiceProvider);
  return await service.getConsultationTypes();
});
