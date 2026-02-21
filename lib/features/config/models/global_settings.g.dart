// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GlobalSettingsImpl _$$GlobalSettingsImplFromJson(Map<String, dynamic> json) =>
    _$GlobalSettingsImpl(
      primaryColor: json['primary_color'] as String,
      secondaryColor: json['secondary_color'] as String,
      defaultLanguage: json['default_language'] as String,
      supportedLanguages:
          (json['supported_languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      maintenanceMode: json['maintenance_mode'] as bool? ?? false,
      isAdsEnabled: json['is_ads_enabled'] as bool? ?? false,
      adUnitIdAndroid: json['ad_unit_id_android'] as String?,
      adUnitIdIos: json['ad_unit_id_ios'] as String?,
      adsScreens: (json['ads_screens'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      notificationSoundPath: json['notification_sound_path'] as String?,
      alarmSoundPath: json['alarm_sound_path'] as String?,
      siteName: json['site_name'] as String?,
      siteDescription: json['site_description'] as String?,
      logoPath: json['logo_path'] as String?,
      privacyPolicy: json['privacy_policy'] as String?,
      termsOfService: json['terms_of_service'] as String?,
      paystackPublicKey: json['paystack_public_key'] as String?,
      premiumMonthlyId: json['premium_monthly_id'] as String?,
      premiumYearlyId: json['premium_yearly_id'] as String?,
      premiumMonthlyPrice: json['premium_monthly_price'] as String?,
      premiumYearlyPrice: json['premium_yearly_price'] as String?,
      premiumMonthlyAmount: (json['premium_monthly_amount'] as num?)?.toInt(),
      premiumYearlyAmount: (json['premium_yearly_amount'] as num?)?.toInt(),
      contactEmail: json['contact_email'] as String?,
      contactPhone: json['contact_phone'] as String?,
      premiumTitle: json['premium_title'] as String?,
      premiumSubtitle: json['premium_subtitle'] as String?,
      premiumFeatures: (json['premium_features'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$GlobalSettingsImplToJson(
  _$GlobalSettingsImpl instance,
) => <String, dynamic>{
  'primary_color': instance.primaryColor,
  'secondary_color': instance.secondaryColor,
  'default_language': instance.defaultLanguage,
  'supported_languages': instance.supportedLanguages,
  'maintenance_mode': instance.maintenanceMode,
  'is_ads_enabled': instance.isAdsEnabled,
  'ad_unit_id_android': instance.adUnitIdAndroid,
  'ad_unit_id_ios': instance.adUnitIdIos,
  'ads_screens': instance.adsScreens,
  'notification_sound_path': instance.notificationSoundPath,
  'alarm_sound_path': instance.alarmSoundPath,
  'site_name': instance.siteName,
  'site_description': instance.siteDescription,
  'logo_path': instance.logoPath,
  'privacy_policy': instance.privacyPolicy,
  'terms_of_service': instance.termsOfService,
  'paystack_public_key': instance.paystackPublicKey,
  'premium_monthly_id': instance.premiumMonthlyId,
  'premium_yearly_id': instance.premiumYearlyId,
  'premium_monthly_price': instance.premiumMonthlyPrice,
  'premium_yearly_price': instance.premiumYearlyPrice,
  'premium_monthly_amount': instance.premiumMonthlyAmount,
  'premium_yearly_amount': instance.premiumYearlyAmount,
  'contact_email': instance.contactEmail,
  'contact_phone': instance.contactPhone,
  'premium_title': instance.premiumTitle,
  'premium_subtitle': instance.premiumSubtitle,
  'premium_features': instance.premiumFeatures,
};
