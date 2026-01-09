// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmark.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Bookmark _$BookmarkFromJson(Map<String, dynamic> json) {
  return _Bookmark.fromJson(json);
}

/// @nodoc
mixin _$Bookmark {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'bookmarkable_type')
  String get bookmarkableType => throw _privateConstructorUsedError;
  @JsonKey(name: 'bookmarkable_id')
  int get bookmarkableId => throw _privateConstructorUsedError; // We can include a generic 'data' map or specific fields to hydrate UI items
  // depending on how the backend returns the polymorphic relation.
  // For now, let's assume the backend 'embeds' the related model or we fetch it separately.
  // A simpler approach for the list is to include title/image metadata directly in the bookmark record
  // or nested 'bookmarkable' object if standard JSON:API.
  // Let's assume a 'bookmarkable' json object:
  Map<String, dynamic>? get bookmarkable => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Bookmark to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookmarkCopyWith<Bookmark> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarkCopyWith<$Res> {
  factory $BookmarkCopyWith(Bookmark value, $Res Function(Bookmark) then) =
      _$BookmarkCopyWithImpl<$Res, Bookmark>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'bookmarkable_type') String bookmarkableType,
    @JsonKey(name: 'bookmarkable_id') int bookmarkableId,
    Map<String, dynamic>? bookmarkable,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$BookmarkCopyWithImpl<$Res, $Val extends Bookmark>
    implements $BookmarkCopyWith<$Res> {
  _$BookmarkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bookmarkableType = null,
    Object? bookmarkableId = null,
    Object? bookmarkable = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            bookmarkableType: null == bookmarkableType
                ? _value.bookmarkableType
                : bookmarkableType // ignore: cast_nullable_to_non_nullable
                      as String,
            bookmarkableId: null == bookmarkableId
                ? _value.bookmarkableId
                : bookmarkableId // ignore: cast_nullable_to_non_nullable
                      as int,
            bookmarkable: freezed == bookmarkable
                ? _value.bookmarkable
                : bookmarkable // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BookmarkImplCopyWith<$Res>
    implements $BookmarkCopyWith<$Res> {
  factory _$$BookmarkImplCopyWith(
    _$BookmarkImpl value,
    $Res Function(_$BookmarkImpl) then,
  ) = __$$BookmarkImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'bookmarkable_type') String bookmarkableType,
    @JsonKey(name: 'bookmarkable_id') int bookmarkableId,
    Map<String, dynamic>? bookmarkable,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$BookmarkImplCopyWithImpl<$Res>
    extends _$BookmarkCopyWithImpl<$Res, _$BookmarkImpl>
    implements _$$BookmarkImplCopyWith<$Res> {
  __$$BookmarkImplCopyWithImpl(
    _$BookmarkImpl _value,
    $Res Function(_$BookmarkImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? bookmarkableType = null,
    Object? bookmarkableId = null,
    Object? bookmarkable = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$BookmarkImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        bookmarkableType: null == bookmarkableType
            ? _value.bookmarkableType
            : bookmarkableType // ignore: cast_nullable_to_non_nullable
                  as String,
        bookmarkableId: null == bookmarkableId
            ? _value.bookmarkableId
            : bookmarkableId // ignore: cast_nullable_to_non_nullable
                  as int,
        bookmarkable: freezed == bookmarkable
            ? _value._bookmarkable
            : bookmarkable // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BookmarkImpl implements _Bookmark {
  const _$BookmarkImpl({
    required this.id,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'bookmarkable_type') required this.bookmarkableType,
    @JsonKey(name: 'bookmarkable_id') required this.bookmarkableId,
    required final Map<String, dynamic>? bookmarkable,
    this.createdAt,
  }) : _bookmarkable = bookmarkable;

  factory _$BookmarkImpl.fromJson(Map<String, dynamic> json) =>
      _$$BookmarkImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'bookmarkable_type')
  final String bookmarkableType;
  @override
  @JsonKey(name: 'bookmarkable_id')
  final int bookmarkableId;
  // We can include a generic 'data' map or specific fields to hydrate UI items
  // depending on how the backend returns the polymorphic relation.
  // For now, let's assume the backend 'embeds' the related model or we fetch it separately.
  // A simpler approach for the list is to include title/image metadata directly in the bookmark record
  // or nested 'bookmarkable' object if standard JSON:API.
  // Let's assume a 'bookmarkable' json object:
  final Map<String, dynamic>? _bookmarkable;
  // We can include a generic 'data' map or specific fields to hydrate UI items
  // depending on how the backend returns the polymorphic relation.
  // For now, let's assume the backend 'embeds' the related model or we fetch it separately.
  // A simpler approach for the list is to include title/image metadata directly in the bookmark record
  // or nested 'bookmarkable' object if standard JSON:API.
  // Let's assume a 'bookmarkable' json object:
  @override
  Map<String, dynamic>? get bookmarkable {
    final value = _bookmarkable;
    if (value == null) return null;
    if (_bookmarkable is EqualUnmodifiableMapView) return _bookmarkable;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Bookmark(id: $id, userId: $userId, bookmarkableType: $bookmarkableType, bookmarkableId: $bookmarkableId, bookmarkable: $bookmarkable, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookmarkImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bookmarkableType, bookmarkableType) ||
                other.bookmarkableType == bookmarkableType) &&
            (identical(other.bookmarkableId, bookmarkableId) ||
                other.bookmarkableId == bookmarkableId) &&
            const DeepCollectionEquality().equals(
              other._bookmarkable,
              _bookmarkable,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    bookmarkableType,
    bookmarkableId,
    const DeepCollectionEquality().hash(_bookmarkable),
    createdAt,
  );

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookmarkImplCopyWith<_$BookmarkImpl> get copyWith =>
      __$$BookmarkImplCopyWithImpl<_$BookmarkImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BookmarkImplToJson(this);
  }
}

abstract class _Bookmark implements Bookmark {
  const factory _Bookmark({
    required final int id,
    @JsonKey(name: 'user_id') required final int userId,
    @JsonKey(name: 'bookmarkable_type') required final String bookmarkableType,
    @JsonKey(name: 'bookmarkable_id') required final int bookmarkableId,
    required final Map<String, dynamic>? bookmarkable,
    final DateTime? createdAt,
  }) = _$BookmarkImpl;

  factory _Bookmark.fromJson(Map<String, dynamic> json) =
      _$BookmarkImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'bookmarkable_type')
  String get bookmarkableType;
  @override
  @JsonKey(name: 'bookmarkable_id')
  int get bookmarkableId; // We can include a generic 'data' map or specific fields to hydrate UI items
  // depending on how the backend returns the polymorphic relation.
  // For now, let's assume the backend 'embeds' the related model or we fetch it separately.
  // A simpler approach for the list is to include title/image metadata directly in the bookmark record
  // or nested 'bookmarkable' object if standard JSON:API.
  // Let's assume a 'bookmarkable' json object:
  @override
  Map<String, dynamic>? get bookmarkable;
  @override
  DateTime? get createdAt;

  /// Create a copy of Bookmark
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookmarkImplCopyWith<_$BookmarkImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
