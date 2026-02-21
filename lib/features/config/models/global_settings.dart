import 'package:freezed_annotation/freezed_annotation.dart';

part 'global_settings.freezed.dart';
part 'global_settings.g.dart';

/// Global application settings from backend
@freezed
class GlobalSettings with _$GlobalSettings {
  const factory GlobalSettings({
    @JsonKey(name: 'primary_color') required String primaryColor,
    @JsonKey(name: 'secondary_color') required String secondaryColor,
    @JsonKey(name: 'default_language') required String defaultLanguage,
    @JsonKey(name: 'supported_languages') @Default([]) List<String> supportedLanguages,
    @JsonKey(name: 'maintenance_mode') @Default(false) bool maintenanceMode,
    @JsonKey(name: 'is_ads_enabled') @Default(false) bool isAdsEnabled,
    @JsonKey(name: 'ad_unit_id_android') String? adUnitIdAndroid,
    @JsonKey(name: 'ad_unit_id_ios') String? adUnitIdIos,
    @JsonKey(name: 'ads_screens') List<String>? adsScreens,
    @JsonKey(name: 'notification_sound_path') String? notificationSoundPath,
    @JsonKey(name: 'alarm_sound_path') String? alarmSoundPath,
    @JsonKey(name: 'site_name') String? siteName,
    @JsonKey(name: 'site_description') String? siteDescription,
    @JsonKey(name: 'logo_path') String? logoPath,
    @JsonKey(name: 'privacy_policy') String? privacyPolicy,
    @JsonKey(name: 'terms_of_service') String? termsOfService,
    @JsonKey(name: 'paystack_public_key') String? paystackPublicKey,
    @JsonKey(name: 'premium_monthly_id') String? premiumMonthlyId,
    @JsonKey(name: 'premium_yearly_id') String? premiumYearlyId,
    @JsonKey(name: 'premium_monthly_price') String? premiumMonthlyPrice,
    @JsonKey(name: 'premium_yearly_price') String? premiumYearlyPrice,
    @JsonKey(name: 'premium_monthly_amount') int? premiumMonthlyAmount,
    @JsonKey(name: 'premium_yearly_amount') int? premiumYearlyAmount,
    @JsonKey(name: 'contact_email') String? contactEmail,
    @JsonKey(name: 'contact_phone') String? contactPhone,
    @JsonKey(name: 'premium_title') String? premiumTitle,
    @JsonKey(name: 'premium_subtitle') String? premiumSubtitle,
    @JsonKey(name: 'premium_features') List<String>? premiumFeatures,
  }) = _GlobalSettings;

  factory GlobalSettings.fromJson(Map<String, dynamic> json) =>
      _$GlobalSettingsFromJson(json);
}
