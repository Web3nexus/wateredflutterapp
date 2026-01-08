import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

/// Category model for organizing traditions
@freezed
class Category with _$Category {
  const factory Category({
    required int id,
    required String name,
    required String slug,
    String? description,
    int? parentId,
    int? order,
    required bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
