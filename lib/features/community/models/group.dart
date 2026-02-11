import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

enum GroupType {
  @JsonValue('country')
  country,
  @JsonValue('tribe')
  tribe,
}

@freezed
class Group with _$Group {
  const factory Group({
    required int id,
    required String name,
    required GroupType type,
    String? description,
    @JsonKey(name: 'member_count') @Default(0) int memberCount,
    @JsonKey(name: 'icon_url') String? iconUrl,
    @JsonKey(name: 'cover_image_url') String? coverImageUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @Default(false) bool isJoined, // Client-side only, not from API
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
