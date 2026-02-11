import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/reminders/models/holiday.dart';
import 'package:Watered/features/calendar/services/calendar_service.dart';

final holidayServiceProvider = Provider<HolidayService>((ref) {
  return HolidayService(ref.read(apiClientProvider), ref.read(calendarServiceProvider));
});

final holidaysListProvider = FutureProvider.autoDispose<List<Holiday>>((ref) async {
  final service = ref.watch(holidayServiceProvider);
  return await service.getHolidays();
});

class HolidayService {
  final ApiClient _client;
  final CalendarService _calendar;

  HolidayService(this._client, this._calendar);

  Future<List<Holiday>> getHolidays() async {
    // 1. Fetch backend holidays
    final response = await _client.get('holidays');
    final data = response.data['data'] as List;
    final List<Holiday> holidays = data.map((e) => Holiday.fromJson(e)).toList();

    // 2. Fetch sacred calendar days
    try {
      final specialDays = await _calendar.getSpecialDays();
      final now = DateTime.now();
      
      for (var day in specialDays) {
        // Try to parse gregorian day like "Jul 19"
        if (day.gregorianDay != null) {
          try {
            // "MMM d" format
            final dateParts = day.gregorianDay!.split(' ');
            if (dateParts.length < 2) continue;
            
            final monthStr = dateParts[0];
            final dayInt = int.parse(dateParts[1]);
            
            final monthMap = {
              'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
              'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
            };
            
            final monthInt = monthMap[monthStr] ?? 
                             monthMap[monthStr.substring(0, 3)]; // Handle full month names if needed

            if (monthInt != null) {
              var date = DateTime(now.year, monthInt, dayInt);
              
              // If the date has passed for this year, assume it's for next year
              // (Only if we are treating these as recurring annual events)
              // However, user said "upcoming", so if it's passed, it shouldn't show unless we project to next year.
              // Let's check if it's seemingly passed (yesterday or before)
              if (date.isBefore(DateTime(now.year, now.month, now.day))) {
                 date = DateTime(now.year + 1, monthInt, dayInt);
              }
              
              // Deduplicate: Check if this holiday already exists from backend
              final exists = holidays.any((h) => 
                h.name.toLowerCase().trim() == day.displayName.toLowerCase().trim() &&
                h.date.year == date.year &&
                h.date.month == date.month &&
                h.date.day == date.day
              );

              if (!exists) {
                holidays.add(Holiday(
                  id: -day.id, // Use negative id to avoid conflict
                  name: day.displayName,
                  date: date,
                  description: day.content,
                  theme: day.celebrationType,
                ));
              }
            }
          } catch (e) {
            print('Error parsing gregorian day: ${day.gregorianDay}');
          }
        }
      }
    } catch (e) {
      print('Error fetching special days: $e');
    }

    // Sort all by date
    holidays.sort((a, b) => a.date.compareTo(b.date));
    
    return holidays;
  }
}
