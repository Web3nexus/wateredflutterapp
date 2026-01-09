import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/features/consultation/models/consultation_type.dart';
import 'package:wateredflutterapp/features/consultation/models/booking.dart';
import 'package:wateredflutterapp/features/consultation/services/booking_service.dart';

final consultationTypesProvider = FutureProvider.autoDispose<List<ConsultationType>>((ref) async {
  final service = ref.watch(bookingServiceProvider);
  return service.getConsultationTypes();
});

final myBookingsProvider = FutureProvider.autoDispose<List<Booking>>((ref) async {
  final service = ref.watch(bookingServiceProvider);
  return service.getMyBookings();
});
