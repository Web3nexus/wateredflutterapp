import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:Watered/features/config/providers/global_settings_provider.dart';

class LegalDocumentScreen extends ConsumerWidget {
  final String title;
  final String type; // 'privacy_policy' or 'terms_of_service'

  const LegalDocumentScreen({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We can use globalSettingsNotifierProvider which loads settings.
    // However, the legal docs might be large and in the main settings object?
    // Based on backend implementation, legal docs ARE in the main settings object.
    
    final settingsAsync = ref.watch(globalSettingsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: settingsAsync.when(
        data: (settings) {
          if (settings == null) {
            return const Center(child: Text('Settings not loaded.'));
          }

          String? content;
          if (type == 'privacy_policy') {
            content = settings.privacyPolicy;
          } else if (type == 'terms_of_service') {
            content = settings.termsOfService;
          }

          if (content == null || content.isEmpty) {
            return const Center(child: Text('No content available.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: HtmlWidget(
              content,
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
