import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings.freezed.dart';
part 'notification_settings.g.dart';

@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    @JsonKey(name: 'push_notifications') @Default(true) bool pushNotifications,
    @JsonKey(name: 'ritual_reminders') @Default(true) bool ritualReminders,
    @JsonKey(name: 'event_updates') @Default(true) bool eventUpdates,
    @JsonKey(name: 'community_activity') @Default(true) bool communityActivity,
  }) = _NotificationSettings;

  factory NotificationSettings.fromJson(Map<String, dynamic> json) => _$NotificationSettingsFromJson(json);
}
