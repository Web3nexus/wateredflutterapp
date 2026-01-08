// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiClientHash() => r'830b3339c24d952121db45e5d7278545d0d2fbfd';

/// Provider for API client
///
/// Copied from [apiClient].
@ProviderFor(apiClient)
final apiClientProvider = AutoDisposeProvider<ApiClient>.internal(
  apiClient,
  name: r'apiClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apiClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiClientRef = AutoDisposeProviderRef<ApiClient>;
String _$globalSettingsNotifierHash() =>
    r'2dfb2326f79018ed52c37e520962f6f47b62ef00';

/// Provider for global settings
///
/// Copied from [GlobalSettingsNotifier].
@ProviderFor(GlobalSettingsNotifier)
final globalSettingsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      GlobalSettingsNotifier,
      GlobalSettings
    >.internal(
      GlobalSettingsNotifier.new,
      name: r'globalSettingsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$globalSettingsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GlobalSettingsNotifier = AutoDisposeAsyncNotifier<GlobalSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
