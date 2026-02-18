import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:Watered/features/config/providers/global_settings_provider.dart';
import 'package:Watered/features/audio/services/audio_service.dart';
import 'package:just_audio_background/just_audio_background.dart';

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
      // 1. Initialize Background Audio
      print('🚀 [AppBoot] Waiting for audio initialization...');
      await ref.read(audioBackgroundInitProvider.future);

      // 2. Load global settings
      print('🚀 [AppBoot] Fetching global settings...');
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
