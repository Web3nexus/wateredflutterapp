// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_boot_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appBootHash() => r'c6d7022dad27bcb47bda66f77294b701ff30a45e';

/// App boot provider - loads config before app starts
///
/// Copied from [AppBoot].
@ProviderFor(AppBoot)
final appBootProvider =
    AutoDisposeAsyncNotifierProvider<AppBoot, BootStatus>.internal(
      AppBoot.new,
      name: r'appBootProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appBootHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppBoot = AutoDisposeAsyncNotifier<BootStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
