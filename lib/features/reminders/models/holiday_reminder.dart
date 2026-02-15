class HolidayReminder {
  final int id;
  final int? holidayId;
  final int? calendarDayId;
  final String holidayName;
  final DateTime reminderTime;
  final String type; // day_of, 24h_before, custom
  final String status;

  HolidayReminder({
    required this.id,
    this.holidayId,
    this.calendarDayId,
    required this.holidayName,
    required this.reminderTime,
    required this.type,
    required this.status,
  });

  factory HolidayReminder.fromJson(Map<String, dynamic> json) {
    return HolidayReminder(
      id: json['id'],
      holidayId: json['holiday_id'],
      calendarDayId: json['calendar_day_id'],
      holidayName: json['holiday_name'],
      reminderTime: DateTime.parse(json['reminder_time']),
      type: json['reminder_type'],
      status: json['status'],
    );
  }
}
