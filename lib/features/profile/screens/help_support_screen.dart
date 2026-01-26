import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
             subtitle: 'support@watered.app',
           ),
           _buildHelpItem(
             context,
             icon: Icons.question_answer_outlined,
             title: 'FAQs',
             subtitle: 'Find quick answers to common questions',
           ),
           _buildHelpItem(
             context,
             icon: Icons.library_books_outlined,
             title: 'User Guide',
             subtitle: 'Learn how to use the Watered app',
           ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(BuildContext context, {required IconData icon, required String title, required String subtitle}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: () {},
      ),
    );
  }
}
