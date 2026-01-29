// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NotificationSettings _$NotificationSettingsFromJson(Map<String, dynamic> json) {
  return _NotificationSettings.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettings {
  @JsonKey(name: 'push_notifications')
  bool get pushNotifications => throw _privateConstructorUsedError;
  @JsonKey(name: 'ritual_reminders')
  bool get ritualReminders => throw _privateConstructorUsedError;
  @JsonKey(name: 'event_updates')
  bool get eventUpdates => throw _privateConstructorUsedError;
  @JsonKey(name: 'community_activity')
  bool get communityActivity => throw _privateConstructorUsedError;

  /// Serializes this NotificationSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsCopyWith<NotificationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsCopyWith<$Res> {
  factory $NotificationSettingsCopyWith(
    NotificationSettings value,
    $Res Function(NotificationSettings) then,
  ) = _$NotificationSettingsCopyWithImpl<$Res, NotificationSettings>;
  @useResult
  $Res call({
    @JsonKey(name: 'push_notifications') bool pushNotifications,
    @JsonKey(name: 'ritual_reminders') bool ritualReminders,
    @JsonKey(name: 'event_updates') bool eventUpdates,
    @JsonKey(name: 'community_activity') bool communityActivity,
  });
}

/// @nodoc
class _$NotificationSettingsCopyWithImpl<
  $Res,
  $Val extends NotificationSettings
>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushNotifications = null,
    Object? ritualReminders = null,
    Object? eventUpdates = null,
    Object? communityActivity = null,
  }) {
    return _then(
      _value.copyWith(
            pushNotifications: null == pushNotifications
                ? _value.pushNotifications
                : pushNotifications // ignore: cast_nullable_to_non_nullable
                      as bool,
            ritualReminders: null == ritualReminders
                ? _value.ritualReminders
                : ritualReminders // ignore: cast_nullable_to_non_nullable
                      as bool,
            eventUpdates: null == eventUpdates
                ? _value.eventUpdates
                : eventUpdates // ignore: cast_nullable_to_non_nullable
                      as bool,
            communityActivity: null == communityActivity
                ? _value.communityActivity
                : communityActivity // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationSettingsImplCopyWith<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  factory _$$NotificationSettingsImplCopyWith(
    _$NotificationSettingsImpl value,
    $Res Function(_$NotificationSettingsImpl) then,
  ) = __$$NotificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'push_notifications') bool pushNotifications,
    @JsonKey(name: 'ritual_reminders') bool ritualReminders,
    @JsonKey(name: 'event_updates') bool eventUpdates,
    @JsonKey(name: 'community_activity') bool communityActivity,
  });
}

/// @nodoc
class __$$NotificationSettingsImplCopyWithImpl<$Res>
    extends _$NotificationSettingsCopyWithImpl<$Res, _$NotificationSettingsImpl>
    implements _$$NotificationSettingsImplCopyWith<$Res> {
  __$$NotificationSettingsImplCopyWithImpl(
    _$NotificationSettingsImpl _value,
    $Res Function(_$NotificationSettingsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushNotifications = null,
    Object? ritualReminders = null,
    Object? eventUpdates = null,
    Object? communityActivity = null,
  }) {
    return _then(
      _$NotificationSettingsImpl(
        pushNotifications: null == pushNotifications
            ? _value.pushNotifications
            : pushNotifications // ignore: cast_nullable_to_non_nullable
                  as bool,
        ritualReminders: null == ritualReminders
            ? _value.ritualReminders
            : ritualReminders // ignore: cast_nullable_to_non_nullable
                  as bool,
        eventUpdates: null == eventUpdates
            ? _value.eventUpdates
            : eventUpdates // ignore: cast_nullable_to_non_nullable
                  as bool,
        communityActivity: null == communityActivity
            ? _value.communityActivity
            : communityActivity // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsImpl implements _NotificationSettings {
  const _$NotificationSettingsImpl({
    @JsonKey(name: 'push_notifications') this.pushNotifications = true,
    @JsonKey(name: 'ritual_reminders') this.ritualReminders = true,
    @JsonKey(name: 'event_updates') this.eventUpdates = true,
    @JsonKey(name: 'community_activity') this.communityActivity = true,
  });

  factory _$NotificationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsImplFromJson(json);

  @override
  @JsonKey(name: 'push_notifications')
  final bool pushNotifications;
  @override
  @JsonKey(name: 'ritual_reminders')
  final bool ritualReminders;
  @override
  @JsonKey(name: 'event_updates')
  final bool eventUpdates;
  @override
  @JsonKey(name: 'community_activity')
  final bool communityActivity;

  @override
  String toString() {
    return 'NotificationSettings(pushNotifications: $pushNotifications, ritualReminders: $ritualReminders, eventUpdates: $eventUpdates, communityActivity: $communityActivity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsImpl &&
            (identical(other.pushNotifications, pushNotifications) ||
                other.pushNotifications == pushNotifications) &&
            (identical(other.ritualReminders, ritualReminders) ||
                other.ritualReminders == ritualReminders) &&
            (identical(other.eventUpdates, eventUpdates) ||
                other.eventUpdates == eventUpdates) &&
            (identical(other.communityActivity, communityActivity) ||
                other.communityActivity == communityActivity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    pushNotifications,
    ritualReminders,
    eventUpdates,
    communityActivity,
  );

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
  get copyWith =>
      __$$NotificationSettingsImplCopyWithImpl<_$NotificationSettingsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsImplToJson(this);
  }
}

abstract class _NotificationSettings implements NotificationSettings {
  const factory _NotificationSettings({
    @JsonKey(name: 'push_notifications') final bool pushNotifications,
    @JsonKey(name: 'ritual_reminders') final bool ritualReminders,
    @JsonKey(name: 'event_updates') final bool eventUpdates,
    @JsonKey(name: 'community_activity') final bool communityActivity,
  }) = _$NotificationSettingsImpl;

  factory _NotificationSettings.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsImpl.fromJson;

  @override
  @JsonKey(name: 'push_notifications')
  bool get pushNotifications;
  @override
  @JsonKey(name: 'ritual_reminders')
  bool get ritualReminders;
  @override
  @JsonKey(name: 'event_updates')
  bool get eventUpdates;
  @override
  @JsonKey(name: 'community_activity')
  bool get communityActivity;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
  get copyWith => throw _privateConstructorUsedError;
}
