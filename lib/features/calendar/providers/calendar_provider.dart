import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/calendar/models/calendar_month.dart';
import 'package:Watered/features/calendar/services/calendar_service.dart';
import 'package:Watered/features/events/models/event.dart';

final fullCalendarProvider = FutureProvider<List<CalendarMonth>>((ref) async {
  return ref.watch(calendarServiceProvider).getFullCalendar();
});

final kemeticTodayProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  return ref.watch(calendarServiceProvider).getToday();
});

// Current Gregorian Month and Year view
final viewMonthProvider = StateProvider<int>((ref) => DateTime.now().month);
final viewYearProvider = StateProvider<int>((ref) => DateTime.now().year);

final selectedMonthProvider = StateProvider<int>((ref) => 1);

final upcomingEventsProvider = FutureProvider<List<Event>>((ref) async {
  return ref.watch(calendarServiceProvider).getUpcomingEvents();
});
