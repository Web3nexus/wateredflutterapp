import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/calendar/models/calendar_month.dart';
import 'package:Watered/features/calendar/services/calendar_service.dart';

final fullCalendarProvider = FutureProvider<List<CalendarMonth>>((ref) async {
  return ref.watch(calendarServiceProvider).getFullCalendar();
});

final kemeticTodayProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return ref.watch(calendarServiceProvider).getToday();
});

final selectedMonthProvider = StateProvider<int>((ref) => 1);
