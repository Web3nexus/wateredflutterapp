import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/rituals/models/ritual.dart';

class RitualDetailScreen extends ConsumerWidget {
  final Ritual ritual;

  const RitualDetailScreen({super.key, required this.ritual});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(ritual.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ritual.description != null) ...[
              Text(
                ritual.description!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: theme.textTheme.bodyLarge?.color?.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
            ],
            
            Text(
              'Instructions',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            if (ritual.content != null)
              Text(
                ritual.content!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.8,
                  fontSize: 16,
                ),
              )
            else
              const Text('Content coming soon...'),
          ],
        ),
      ),
    );
  }
}
