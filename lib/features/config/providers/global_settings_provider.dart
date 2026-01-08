import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wateredflutterapp/core/network/api_client.dart';
import 'package:wateredflutterapp/core/network/api_error_handler.dart';
import 'package:wateredflutterapp/features/config/models/global_settings.dart';

part 'global_settings_provider.g.dart';

/// Provider for API client
@riverpod
ApiClient apiClient(ApiClientRef ref) {
  return ApiClient();
}

/// Provider for global settings
@riverpod
class GlobalSettingsNotifier extends _$GlobalSettingsNotifier {
  @override
  Future<GlobalSettings> build() async {
    return await fetchSettings();
  }

  /// Fetch global settings from API
  Future<GlobalSettings> fetchSettings() async {
    try {
      final apiClient = ref.read(apiClientProvider);
      final response = await apiClient.get('/settings');

      if (response.statusCode == 200 && response.data != null) {
        return GlobalSettings.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to load settings', response.statusCode);
      }
    } catch (e) {
      throw ApiErrorHandler.handleError(e);
    }
  }

  /// Refresh settings
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => fetchSettings());
  }
}
