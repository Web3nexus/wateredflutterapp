import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_settings.freezed.dart';
part 'global_settings.g.dart';

/// Global application settings from backend
@freezed
class GlobalSettings with _$GlobalSettings {
  const factory GlobalSettings({
    required String primaryColor,
    required String secondaryColor,
    required String defaultLanguage,
    required List<String> supportedLanguages,
    required bool maintenanceMode,
    String? siteName,
    String? siteDescription,
    String? logoPath,
  }) = _GlobalSettings;

  factory GlobalSettings.fromJson(Map<String, dynamic> json) =>
      _$GlobalSettingsFromJson(json);
}
