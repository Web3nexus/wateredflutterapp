import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/theme/theme_provider.dart';
import 'package:Watered/features/notifications/screens/notification_settings_screen.dart';
import 'package:Watered/features/profile/screens/faq_screen.dart';
import 'package:Watered/features/profile/screens/user_guides_screen.dart';
import 'package:Watered/features/landing/landing_page_screen.dart';
import 'package:Watered/features/config/screens/legal_document_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader(context, 'Preferences'),
          ListTile(
            title: const Text('Appearance'),
            subtitle: Text(themeMode == ThemeMode.dark ? 'Dark Mode' : 'Light Mode'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
               ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
          const Divider(),
          _buildSectionHeader(context, 'Account'),
          ListTile(
            title: const Text('Notifications'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationSettingsScreen()),
              );
            },
          ),
          ListTile(
             title: const Text('Frequently Asked Questions'),
             trailing: const Icon(Icons.chevron_right),
             onTap: () {
               Navigator.of(context).push(
                 MaterialPageRoute(builder: (_) => const FaqScreen()),
               );
             },
          ),
          ListTile(
             title: const Text('User Guides'),
             trailing: const Icon(Icons.chevron_right),
             onTap: () {
               Navigator.of(context).push(
                 MaterialPageRoute(builder: (_) => const UserGuidesScreen()),
               );
             },
          ),
          ListTile(
             title: const Text('Landing Page'),
             trailing: const Icon(Icons.chevron_right),
             onTap: () {
               Navigator.of(context).push(
                 MaterialPageRoute(builder: (_) => const LandingPageScreen()),
               );
             },
          ),
          ListTile(
             title: const Text('Privacy Policy'),
             trailing: const Icon(Icons.chevron_right),
             onTap: () {
               Navigator.of(context).push(
                 MaterialPageRoute(
                   builder: (_) => const LegalDocumentScreen(
                     title: 'Privacy Policy',
                     type: 'privacy_policy',
                   ),
                 ),
               );
             },
          ),
          ListTile(
             title: const Text('Terms of Service'),
             trailing: const Icon(Icons.chevron_right),
             onTap: () {
               Navigator.of(context).push(
                 MaterialPageRoute(
                   builder: (_) => const LegalDocumentScreen(
                     title: 'Terms of Service',
                     type: 'terms_of_service',
                   ),
                 ),
               );
             },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
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
}
