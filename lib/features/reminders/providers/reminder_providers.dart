import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/reminders/models/reminder.dart';
import 'package:Watered/features/reminders/services/reminder_service.dart';

final remindersListProvider = FutureProvider.autoDispose<List<Reminder>>((ref) async {
  final service = ref.watch(reminderServiceProvider);
  return await service.getReminders();
});
