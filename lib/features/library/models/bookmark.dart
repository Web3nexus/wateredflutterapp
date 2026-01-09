import 'package:freezed_annotation/freezed_annotation.dart';

part 'bookmark.freezed.dart';
part 'bookmark.g.dart';

@freezed
class Bookmark with _$Bookmark {
  const factory Bookmark({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'bookmarkable_type') required String bookmarkableType,
    @JsonKey(name: 'bookmarkable_id') required int bookmarkableId,
    // We can include a generic 'data' map or specific fields to hydrate UI items
    // depending on how the backend returns the polymorphic relation.
    // For now, let's assume the backend 'embeds' the related model or we fetch it separately.
    // A simpler approach for the list is to include title/image metadata directly in the bookmark record
    // or nested 'bookmarkable' object if standard JSON:API.
    // Let's assume a 'bookmarkable' json object:
    required Map<String, dynamic>? bookmarkable, 
    DateTime? createdAt,
  }) = _Bookmark;

  factory Bookmark.fromJson(Map<String, dynamic> json) => _$BookmarkFromJson(json);
}
