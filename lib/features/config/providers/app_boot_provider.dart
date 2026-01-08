import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wateredflutterapp/features/config/providers/global_settings_provider.dart';

part 'app_boot_provider.g.dart';

/// App bootstrap state
enum BootStatus {
  loading,
  ready,
  error,
  maintenance,
}

/// App boot provider - loads config before app starts
@riverpod
class AppBoot extends _$AppBoot {
  @override
  Future<BootStatus> build() async {
    return await initialize();
  }

  /// Initialize app by loading global settings
  Future<BootStatus> initialize() async {
    try {
      // Load global settings
      final settingsAsync = await ref.read(globalSettingsNotifierProvider.future);

      // Check maintenance mode
      if (settingsAsync.maintenanceMode) {
        return BootStatus.maintenance;
      }

      // App is ready
      return BootStatus.ready;
    } catch (e) {
      print('App boot error: $e');
      return BootStatus.error;
    }
  }

  /// Retry initialization
  Future<void> retry() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => initialize());
  }
}
