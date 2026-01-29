import 'calendar_month.dart';

class CalendarDay {
  final int id;
  final int calendarMonthId;
  final int dayNumber;
  final String? customDayName;
  final String? gregorianDay;
  final String? content;
  final List<String>? associatedDeities;
  final String? celebrationType;
  final bool isSacred;
  final String? uiColor;
  final List<String>? activities;
  final List<String>? restrictions;
  final CalendarMonth? month;

  CalendarDay({
    required this.id,
    required this.calendarMonthId,
    required this.dayNumber,
    this.customDayName,
    this.gregorianDay,
    this.content,
    this.associatedDeities,
    this.celebrationType,
    required this.isSacred,
    this.uiColor,
    this.activities,
    this.restrictions,
    this.month,
  });

  factory CalendarDay.fromJson(Map<String, dynamic> json) {
    return CalendarDay(
      id: json['id'],
      calendarMonthId: json['calendar_month_id'],
      dayNumber: json['day_number'],
      customDayName: json['custom_day_name'],
      gregorianDay: json['gregorian_day'],
      content: json['content'],
      associatedDeities: json['associated_deities'] != null
          ? List<String>.from(json['associated_deities'])
          : null,
      celebrationType: json['celebration_type'],
      isSacred: json['is_sacred'] == 1 || json['is_sacred'] == true,
      uiColor: json['ui_color'],
      activities: json['activities'] != null ? List<String>.from(json['activities']) : null,
      restrictions: json['restrictions'] != null ? List<String>.from(json['restrictions']) : null,
      month: json['month'] != null ? CalendarMonth.fromJson(json['month']) : null,
    );
  }

  String get displayName => customDayName ?? 'Day $dayNumber';
}
