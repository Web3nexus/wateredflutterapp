import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/profile/screens/faq_screen.dart';
import 'package:Watered/features/profile/screens/user_guides_screen.dart';
import 'package:Watered/features/config/providers/global_settings_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends ConsumerWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(globalSettingsNotifierProvider).asData?.value;
    final supportEmail = settings?.contactEmail ?? 'support@mywatered.com';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
           const Text(
             'How can we assist you?',
             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Cinzel'),
           ),
           const SizedBox(height: 24),
           _buildHelpItem(
             context,
             icon: Icons.email_outlined,
             title: 'Contact Us',
             subtitle: supportEmail,
             onTap: () async {
               final Uri emailLaunchUri = Uri(
                 scheme: 'mailto',
                 path: supportEmail,
                 query: encodeQueryParameters(<String, String>{
                   'subject': 'Watered App Support Request',
                 }),
               );

               if (await canLaunchUrl(emailLaunchUri)) {
                 await launchUrl(emailLaunchUri);
               } else {
                 if (context.mounted) {
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('Could not open email app')),
                   );
                 }
               }
             },
           ),
           _buildHelpItem(
             context,
             icon: Icons.question_answer_outlined,
             title: 'FAQs',
             subtitle: 'Find quick answers to common questions',
             onTap: () => Navigator.of(context).push(
               MaterialPageRoute(builder: (_) => const FaqScreen()),
             ),
           ),
           _buildHelpItem(
             context,
             icon: Icons.library_books_outlined,
             title: 'User Guide',
             subtitle: 'Learn how to use the Watered app',
             onTap: () => Navigator.of(context).push(
               MaterialPageRoute(builder: (_) => const UserGuidesScreen()),
             ),
           ),
        ],
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Widget _buildHelpItem(BuildContext context, {required IconData icon, required String title, required String subtitle, VoidCallback? onTap}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
