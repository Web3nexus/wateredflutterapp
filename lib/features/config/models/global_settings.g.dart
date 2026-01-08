// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GlobalSettingsImpl _$$GlobalSettingsImplFromJson(Map<String, dynamic> json) =>
    _$GlobalSettingsImpl(
      primaryColor: json['primaryColor'] as String,
      secondaryColor: json['secondaryColor'] as String,
      defaultLanguage: json['defaultLanguage'] as String,
      supportedLanguages: (json['supportedLanguages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      maintenanceMode: json['maintenanceMode'] as bool,
      siteName: json['siteName'] as String?,
      siteDescription: json['siteDescription'] as String?,
      logoPath: json['logoPath'] as String?,
    );

Map<String, dynamic> _$$GlobalSettingsImplToJson(
  _$GlobalSettingsImpl instance,
) => <String, dynamic>{
  'primaryColor': instance.primaryColor,
  'secondaryColor': instance.secondaryColor,
  'defaultLanguage': instance.defaultLanguage,
  'supportedLanguages': instance.supportedLanguages,
  'maintenanceMode': instance.maintenanceMode,
  'siteName': instance.siteName,
  'siteDescription': instance.siteDescription,
  'logoPath': instance.logoPath,
};
