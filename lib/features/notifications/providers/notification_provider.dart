import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:Watered/core/network/api_client.dart';
import 'package:Watered/features/notifications/models/notification_settings.dart';

part 'notification_provider.g.dart';

@riverpod
class NotificationSettingsNotifier extends _$NotificationSettingsNotifier {
  @override
  Future<NotificationSettings> build() async {
    return await fetchSettings();
  }

  Future<NotificationSettings> fetchSettings() async {
    final response = await ref.read(apiClientProvider).get('notifications/settings');
    return NotificationSettings.fromJson(response.data['data']);
  }

  Future<void> updateSettings(NotificationSettings settings) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(apiClientProvider).post(
        'notifications/settings',
        data: settings.toJson(),
      );
      return settings;
    });
  }

  Future<void> togglePush(bool value) async {
    final current = state.value;
    if (current == null) return;
    await updateSettings(current.copyWith(pushNotifications: value));
  }

  Future<void> toggleRituals(bool value) async {
    final current = state.value;
    if (current == null) return;
    await updateSettings(current.copyWith(ritualReminders: value));
  }

  Future<void> toggleEvents(bool value) async {
    final current = state.value;
    if (current == null) return;
    await updateSettings(current.copyWith(eventUpdates: value));
  }
}

