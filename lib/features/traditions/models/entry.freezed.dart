// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return _Entry.fromJson(json);
}

/// @nodoc
mixin _$Entry {
  int get id => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @JsonKey(name: 'chapter_id')
  int get chapterId => throw _privateConstructorUsedError;
  int? get order => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError; // Relationship data
  List<EntryTranslation>? get translations =>
      throw _privateConstructorUsedError;

  /// Serializes this Entry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryCopyWith<Entry> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryCopyWith<$Res> {
  factory $EntryCopyWith(Entry value, $Res Function(Entry) then) =
      _$EntryCopyWithImpl<$Res, Entry>;
  @useResult
  $Res call({
    int id,
    int number,
    String text,
    @JsonKey(name: 'chapter_id') int chapterId,
    int? order,
    Map<String, dynamic>? metadata,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    List<EntryTranslation>? translations,
  });
}

/// @nodoc
class _$EntryCopyWithImpl<$Res, $Val extends Entry>
    implements $EntryCopyWith<$Res> {
  _$EntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? text = null,
    Object? chapterId = null,
    Object? order = freezed,
    Object? metadata = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? translations = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as int,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            chapterId: null == chapterId
                ? _value.chapterId
                : chapterId // ignore: cast_nullable_to_non_nullable
                      as int,
            order: freezed == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            translations: freezed == translations
                ? _value.translations
                : translations // ignore: cast_nullable_to_non_nullable
                      as List<EntryTranslation>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EntryImplCopyWith<$Res> implements $EntryCopyWith<$Res> {
  factory _$$EntryImplCopyWith(
    _$EntryImpl value,
    $Res Function(_$EntryImpl) then,
  ) = __$$EntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int number,
    String text,
    @JsonKey(name: 'chapter_id') int chapterId,
    int? order,
    Map<String, dynamic>? metadata,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    List<EntryTranslation>? translations,
  });
}

/// @nodoc
class __$$EntryImplCopyWithImpl<$Res>
    extends _$EntryCopyWithImpl<$Res, _$EntryImpl>
    implements _$$EntryImplCopyWith<$Res> {
  __$$EntryImplCopyWithImpl(
    _$EntryImpl _value,
    $Res Function(_$EntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? text = null,
    Object? chapterId = null,
    Object? order = freezed,
    Object? metadata = freezed,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? translations = freezed,
  }) {
    return _then(
      _$EntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as int,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        chapterId: null == chapterId
            ? _value.chapterId
            : chapterId // ignore: cast_nullable_to_non_nullable
                  as int,
        order: freezed == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int?,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        translations: freezed == translations
            ? _value._translations
            : translations // ignore: cast_nullable_to_non_nullable
                  as List<EntryTranslation>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EntryImpl implements _Entry {
  const _$EntryImpl({
    required this.id,
    required this.number,
    required this.text,
    @JsonKey(name: 'chapter_id') required this.chapterId,
    this.order,
    final Map<String, dynamic>? metadata,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    final List<EntryTranslation>? translations,
  }) : _metadata = metadata,
       _translations = translations;

  factory _$EntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryImplFromJson(json);

  @override
  final int id;
  @override
  final int number;
  @override
  final String text;
  @override
  @JsonKey(name: 'chapter_id')
  final int chapterId;
  @override
  final int? order;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  // Relationship data
  final List<EntryTranslation>? _translations;
  // Relationship data
  @override
  List<EntryTranslation>? get translations {
    final value = _translations;
    if (value == null) return null;
    if (_translations is EqualUnmodifiableListView) return _translations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Entry(id: $id, number: $number, text: $text, chapterId: $chapterId, order: $order, metadata: $metadata, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, translations: $translations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.chapterId, chapterId) ||
                other.chapterId == chapterId) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(
              other._translations,
              _translations,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    number,
    text,
    chapterId,
    order,
    const DeepCollectionEquality().hash(_metadata),
    isActive,
    createdAt,
    updatedAt,
    const DeepCollectionEquality().hash(_translations),
  );

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryImplCopyWith<_$EntryImpl> get copyWith =>
      __$$EntryImplCopyWithImpl<_$EntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryImplToJson(this);
  }
}

abstract class _Entry implements Entry {
  const factory _Entry({
    required final int id,
    required final int number,
    required final String text,
    @JsonKey(name: 'chapter_id') required final int chapterId,
    final int? order,
    final Map<String, dynamic>? metadata,
    @JsonKey(name: 'is_active') required final bool isActive,
    @JsonKey(name: 'created_at') final DateTime? createdAt,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
    final List<EntryTranslation>? translations,
  }) = _$EntryImpl;

  factory _Entry.fromJson(Map<String, dynamic> json) = _$EntryImpl.fromJson;

  @override
  int get id;
  @override
  int get number;
  @override
  String get text;
  @override
  @JsonKey(name: 'chapter_id')
  int get chapterId;
  @override
  int? get order;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt; // Relationship data
  @override
  List<EntryTranslation>? get translations;

  /// Create a copy of Entry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryImplCopyWith<_$EntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EntryTranslation _$EntryTranslationFromJson(Map<String, dynamic> json) {
  return _EntryTranslation.fromJson(json);
}

/// @nodoc
mixin _$EntryTranslation {
  int get id => throw _privateConstructorUsedError;
  int get entryId => throw _privateConstructorUsedError;
  String get languageCode => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String? get translatorName => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this EntryTranslation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EntryTranslation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EntryTranslationCopyWith<EntryTranslation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryTranslationCopyWith<$Res> {
  factory $EntryTranslationCopyWith(
    EntryTranslation value,
    $Res Function(EntryTranslation) then,
  ) = _$EntryTranslationCopyWithImpl<$Res, EntryTranslation>;
  @useResult
  $Res call({
    int id,
    int entryId,
    String languageCode,
    String text,
    String? translatorName,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$EntryTranslationCopyWithImpl<$Res, $Val extends EntryTranslation>
    implements $EntryTranslationCopyWith<$Res> {
  _$EntryTranslationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EntryTranslation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entryId = null,
    Object? languageCode = null,
    Object? text = null,
    Object? translatorName = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            entryId: null == entryId
                ? _value.entryId
                : entryId // ignore: cast_nullable_to_non_nullable
                      as int,
            languageCode: null == languageCode
                ? _value.languageCode
                : languageCode // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            translatorName: freezed == translatorName
                ? _value.translatorName
                : translatorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EntryTranslationImplCopyWith<$Res>
    implements $EntryTranslationCopyWith<$Res> {
  factory _$$EntryTranslationImplCopyWith(
    _$EntryTranslationImpl value,
    $Res Function(_$EntryTranslationImpl) then,
  ) = __$$EntryTranslationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int entryId,
    String languageCode,
    String text,
    String? translatorName,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$EntryTranslationImplCopyWithImpl<$Res>
    extends _$EntryTranslationCopyWithImpl<$Res, _$EntryTranslationImpl>
    implements _$$EntryTranslationImplCopyWith<$Res> {
  __$$EntryTranslationImplCopyWithImpl(
    _$EntryTranslationImpl _value,
    $Res Function(_$EntryTranslationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EntryTranslation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entryId = null,
    Object? languageCode = null,
    Object? text = null,
    Object? translatorName = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$EntryTranslationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        entryId: null == entryId
            ? _value.entryId
            : entryId // ignore: cast_nullable_to_non_nullable
                  as int,
        languageCode: null == languageCode
            ? _value.languageCode
            : languageCode // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        translatorName: freezed == translatorName
            ? _value.translatorName
            : translatorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EntryTranslationImpl implements _EntryTranslation {
  const _$EntryTranslationImpl({
    required this.id,
    required this.entryId,
    required this.languageCode,
    required this.text,
    this.translatorName,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory _$EntryTranslationImpl.fromJson(Map<String, dynamic> json) =>
      _$$EntryTranslationImplFromJson(json);

  @override
  final int id;
  @override
  final int entryId;
  @override
  final String languageCode;
  @override
  final String text;
  @override
  final String? translatorName;
  @override
  final String? notes;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'EntryTranslation(id: $id, entryId: $entryId, languageCode: $languageCode, text: $text, translatorName: $translatorName, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EntryTranslationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.entryId, entryId) || other.entryId == entryId) &&
            (identical(other.languageCode, languageCode) ||
                other.languageCode == languageCode) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.translatorName, translatorName) ||
                other.translatorName == translatorName) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    entryId,
    languageCode,
    text,
    translatorName,
    notes,
    createdAt,
    updatedAt,
  );

  /// Create a copy of EntryTranslation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EntryTranslationImplCopyWith<_$EntryTranslationImpl> get copyWith =>
      __$$EntryTranslationImplCopyWithImpl<_$EntryTranslationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EntryTranslationImplToJson(this);
  }
}

abstract class _EntryTranslation implements EntryTranslation {
  const factory _EntryTranslation({
    required final int id,
    required final int entryId,
    required final String languageCode,
    required final String text,
    final String? translatorName,
    final String? notes,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$EntryTranslationImpl;

  factory _EntryTranslation.fromJson(Map<String, dynamic> json) =
      _$EntryTranslationImpl.fromJson;

  @override
  int get id;
  @override
  int get entryId;
  @override
  String get languageCode;
  @override
  String get text;
  @override
  String? get translatorName;
  @override
  String? get notes;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of EntryTranslation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EntryTranslationImplCopyWith<_$EntryTranslationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
