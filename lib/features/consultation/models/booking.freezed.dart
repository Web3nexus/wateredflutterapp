// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return _Booking.fromJson(json);
}

/// @nodoc
mixin _$Booking {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'consultation_type_id')
  int get consultationTypeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_time')
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'consultation_type')
  ConsultationType? get consultationType => throw _privateConstructorUsedError;

  /// Serializes this Booking to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookingCopyWith<Booking> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingCopyWith<$Res> {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) then) =
      _$BookingCopyWithImpl<$Res, Booking>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'consultation_type_id') int consultationTypeId,
    @JsonKey(name: 'start_time') DateTime scheduledAt,
    String status,
    String? notes,
    @JsonKey(name: 'consultation_type') ConsultationType? consultationType,
  });
}

/// @nodoc
class _$BookingCopyWithImpl<$Res, $Val extends Booking>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? consultationTypeId = null,
    Object? scheduledAt = null,
    Object? status = null,
    Object? notes = freezed,
    Object? consultationType = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            consultationTypeId: null == consultationTypeId
                ? _value.consultationTypeId
                : consultationTypeId // ignore: cast_nullable_to_non_nullable
                      as int,
            scheduledAt: null == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            consultationType: freezed == consultationType
                ? _value.consultationType
                : consultationType // ignore: cast_nullable_to_non_nullable
                      as ConsultationType?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookingImplCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$$BookingImplCopyWith(
    _$BookingImpl value,
    $Res Function(_$BookingImpl) then,
  ) = __$$BookingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'consultation_type_id') int consultationTypeId,
    @JsonKey(name: 'start_time') DateTime scheduledAt,
    String status,
    String? notes,
    @JsonKey(name: 'consultation_type') ConsultationType? consultationType,
  });
}

/// @nodoc
class __$$BookingImplCopyWithImpl<$Res>
    extends _$BookingCopyWithImpl<$Res, _$BookingImpl>
    implements _$$BookingImplCopyWith<$Res> {
  __$$BookingImplCopyWithImpl(
    _$BookingImpl _value,
    $Res Function(_$BookingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? consultationTypeId = null,
    Object? scheduledAt = null,
    Object? status = null,
    Object? notes = freezed,
    Object? consultationType = freezed,
  }) {
    return _then(
      _$BookingImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        consultationTypeId: null == consultationTypeId
            ? _value.consultationTypeId
            : consultationTypeId // ignore: cast_nullable_to_non_nullable
                  as int,
        scheduledAt: null == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        consultationType: freezed == consultationType
            ? _value.consultationType
            : consultationType // ignore: cast_nullable_to_non_nullable
                  as ConsultationType?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookingImpl implements _Booking {
  const _$BookingImpl({
    required this.id,
    @JsonKey(name: 'consultation_type_id') required this.consultationTypeId,
    @JsonKey(name: 'start_time') required this.scheduledAt,
    required this.status,
    this.notes,
    @JsonKey(name: 'consultation_type') this.consultationType,
  });

  factory _$BookingImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookingImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'consultation_type_id')
  final int consultationTypeId;
  @override
  @JsonKey(name: 'start_time')
  final DateTime scheduledAt;
  @override
  final String status;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'consultation_type')
  final ConsultationType? consultationType;

  @override
  String toString() {
    return 'Booking(id: $id, consultationTypeId: $consultationTypeId, scheduledAt: $scheduledAt, status: $status, notes: $notes, consultationType: $consultationType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.consultationTypeId, consultationTypeId) ||
                other.consultationTypeId == consultationTypeId) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.consultationType, consultationType) ||
                other.consultationType == consultationType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    consultationTypeId,
    scheduledAt,
    status,
    notes,
    consultationType,
  );

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      __$$BookingImplCopyWithImpl<_$BookingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookingImplToJson(this);
  }
}

abstract class _Booking implements Booking {
  const factory _Booking({
    required final int id,
    @JsonKey(name: 'consultation_type_id')
    required final int consultationTypeId,
    @JsonKey(name: 'start_time') required final DateTime scheduledAt,
    required final String status,
    final String? notes,
    @JsonKey(name: 'consultation_type')
    final ConsultationType? consultationType,
  }) = _$BookingImpl;

  factory _Booking.fromJson(Map<String, dynamic> json) = _$BookingImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'consultation_type_id')
  int get consultationTypeId;
  @override
  @JsonKey(name: 'start_time')
  DateTime get scheduledAt;
  @override
  String get status;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'consultation_type')
  ConsultationType? get consultationType;

  /// Create a copy of Booking
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingImplCopyWith<_$BookingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
