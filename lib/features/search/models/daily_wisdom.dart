import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_wisdom.freezed.dart';
part 'daily_wisdom.g.dart';

@freezed
class DailyWisdom with _$DailyWisdom {
  const factory DailyWisdom({
    required int id,
    required String quote,
    String? author,
    @JsonKey(name: 'background_image_url') String? backgroundImageUrl,
    @JsonKey(name: 'active_date') required DateTime publishDate,
  }) = _DailyWisdom;

  factory DailyWisdom.fromJson(Map<String, dynamic> json) => _$DailyWisdomFromJson(json);
}
