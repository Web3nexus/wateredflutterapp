import 'package:freezed_annotation/freezed_annotation.dart';

part 'informational.freezed.dart';
part 'informational.g.dart';

@freezed
class Faq with _$Faq {
  const factory Faq({
    required int id,
    required String question,
    required String answer,
    String? category,
    @JsonKey(name: 'sort_order') required int sortOrder,
  }) = _Faq;

  factory Faq.fromJson(Map<String, dynamic> json) => _$FaqFromJson(json);
}

@freezed
class UserGuide with _$UserGuide {
  const factory UserGuide({
    required int id,
    required String title,
    String? content,
    @JsonKey(name: 'sort_order') required int sortOrder,
  }) = _UserGuide;

  factory UserGuide.fromJson(Map<String, dynamic> json) => _$UserGuideFromJson(json);
}
