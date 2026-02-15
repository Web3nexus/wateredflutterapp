import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/profile/providers/informational_provider.dart';
import 'package:Watered/features/profile/models/informational.dart';
import 'package:url_launcher/url_launcher.dart';

class UserGuidesScreen extends ConsumerWidget {
  const UserGuidesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final guidesAsync = ref.watch(userGuidesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('USER GUIDES')),
      body: guidesAsync.when(
        data: (guides) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: guides.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final guide = guides[index];
            return _GuideCard(guide: guide);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Failed to load guides: $err')),
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  final UserGuide guide;
  const _GuideCard({required this.guide});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.menu_book_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          guide.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: (guide.content != null && guide.content!.isNotEmpty)
            ? Text(
                guide.content!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: theme.textTheme.bodySmall?.color?.withOpacity(0.7)),
              )
            : null,
        trailing: Icon(Icons.chevron_right, color: theme.dividerColor.withOpacity(0.2)),
        onTap: () async {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: theme.dialogBackgroundColor,
              title: Text(guide.title),
              content: SingleChildScrollView(child: Text(guide.content ?? '')),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('CLOSE')),
              ],
            ),
          );
        },
      ),
    );
  }
}

