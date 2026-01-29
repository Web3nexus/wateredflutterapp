import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/notifications/providers/notification_provider.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(notificationSettingsNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('NOTIFICATION SETTINGS')),
      body: settingsAsync.when(
        data: (settings) => ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _buildToggleTile(
              context,
              'Push Notifications',
              'Enable or disable all push notifications.',
              settings.pushNotifications,
              (val) => ref.read(notificationSettingsNotifierProvider.notifier).togglePush(val),
            ),
            const Divider(height: 32),
            _buildSectionHeader(context, 'Content Alerts'),
            _buildToggleTile(
              context,
              'Ritual Reminders',
              'Get notified about upcoming rituals and moon phases.',
              settings.ritualReminders,
              (val) => ref.read(notificationSettingsNotifierProvider.notifier).toggleRituals(val),
            ),
            _buildToggleTile(
              context,
              'Event Updates',
              'Stay informed about new events and workshops.',
              settings.eventUpdates,
              (val) => ref.read(notificationSettingsNotifierProvider.notifier).toggleEvents(val),
            ),
            _buildToggleTile(
              context,
              'Community Activity',
              'Notifications for likes and comments on your posts.',
              settings.communityActivity,
              (val) => ref.read(notificationSettingsNotifierProvider.notifier).toggleCommunity(val),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Failed to load settings: $err')),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildToggleTile(
    BuildContext context,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6))),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }
}
