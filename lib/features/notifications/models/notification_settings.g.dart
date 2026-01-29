// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationSettingsImpl _$$NotificationSettingsImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationSettingsImpl(
  pushNotifications: json['push_notifications'] as bool? ?? true,
  ritualReminders: json['ritual_reminders'] as bool? ?? true,
  eventUpdates: json['event_updates'] as bool? ?? true,
  communityActivity: json['community_activity'] as bool? ?? true,
);

Map<String, dynamic> _$$NotificationSettingsImplToJson(
  _$NotificationSettingsImpl instance,
) => <String, dynamic>{
  'push_notifications': instance.pushNotifications,
  'ritual_reminders': instance.ritualReminders,
  'event_updates': instance.eventUpdates,
  'community_activity': instance.communityActivity,
};
