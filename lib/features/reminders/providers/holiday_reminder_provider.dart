import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/reminders/models/holiday_reminder.dart';
import 'package:Watered/features/reminders/services/holiday_reminder_service.dart';

final holidayRemindersListProvider = FutureProvider.autoDispose<List<HolidayReminder>>((ref) async {
  final service = ref.watch(holidayReminderServiceProvider);
  return await service.getHolidayReminders();
});
