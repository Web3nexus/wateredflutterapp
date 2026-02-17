
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sacred_sound.freezed.dart';
part 'sacred_sound.g.dart';

@freezed
class SacredSound with _$SacredSound {
  const factory SacredSound({
    required int id,
    required String title,
    @JsonKey(name: 'file_path') required String filePath,
    required String type,
  }) = _SacredSound;

  factory SacredSound.fromJson(Map<String, dynamic> json) => _$SacredSoundFromJson(json);
}
