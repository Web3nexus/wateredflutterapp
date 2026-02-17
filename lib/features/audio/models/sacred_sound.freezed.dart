// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sacred_sound.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SacredSound _$SacredSoundFromJson(Map<String, dynamic> json) {
  return _SacredSound.fromJson(json);
}

/// @nodoc
mixin _$SacredSound {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_path')
  String get filePath => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this SacredSound to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SacredSound
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SacredSoundCopyWith<SacredSound> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SacredSoundCopyWith<$Res> {
  factory $SacredSoundCopyWith(
    SacredSound value,
    $Res Function(SacredSound) then,
  ) = _$SacredSoundCopyWithImpl<$Res, SacredSound>;
  @useResult
  $Res call({
    int id,
    String title,
    @JsonKey(name: 'file_path') String filePath,
    String type,
  });
}

/// @nodoc
class _$SacredSoundCopyWithImpl<$Res, $Val extends SacredSound>
    implements $SacredSoundCopyWith<$Res> {
  _$SacredSoundCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SacredSound
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? filePath = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            filePath: null == filePath
                ? _value.filePath
                : filePath // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SacredSoundImplCopyWith<$Res>
    implements $SacredSoundCopyWith<$Res> {
  factory _$$SacredSoundImplCopyWith(
    _$SacredSoundImpl value,
    $Res Function(_$SacredSoundImpl) then,
  ) = __$$SacredSoundImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    @JsonKey(name: 'file_path') String filePath,
    String type,
  });
}

/// @nodoc
class __$$SacredSoundImplCopyWithImpl<$Res>
    extends _$SacredSoundCopyWithImpl<$Res, _$SacredSoundImpl>
    implements _$$SacredSoundImplCopyWith<$Res> {
  __$$SacredSoundImplCopyWithImpl(
    _$SacredSoundImpl _value,
    $Res Function(_$SacredSoundImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SacredSound
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? filePath = null,
    Object? type = null,
  }) {
    return _then(
      _$SacredSoundImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        filePath: null == filePath
            ? _value.filePath
            : filePath // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SacredSoundImpl implements _SacredSound {
  const _$SacredSoundImpl({
    required this.id,
    required this.title,
    @JsonKey(name: 'file_path') required this.filePath,
    required this.type,
  });

  factory _$SacredSoundImpl.fromJson(Map<String, dynamic> json) =>
      _$$SacredSoundImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  @JsonKey(name: 'file_path')
  final String filePath;
  @override
  final String type;

  @override
  String toString() {
    return 'SacredSound(id: $id, title: $title, filePath: $filePath, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SacredSoundImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, filePath, type);

  /// Create a copy of SacredSound
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SacredSoundImplCopyWith<_$SacredSoundImpl> get copyWith =>
      __$$SacredSoundImplCopyWithImpl<_$SacredSoundImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SacredSoundImplToJson(this);
  }
}

abstract class _SacredSound implements SacredSound {
  const factory _SacredSound({
    required final int id,
    required final String title,
    @JsonKey(name: 'file_path') required final String filePath,
    required final String type,
  }) = _$SacredSoundImpl;

  factory _SacredSound.fromJson(Map<String, dynamic> json) =
      _$SacredSoundImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  @JsonKey(name: 'file_path')
  String get filePath;
  @override
  String get type;

  /// Create a copy of SacredSound
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SacredSoundImplCopyWith<_$SacredSoundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
