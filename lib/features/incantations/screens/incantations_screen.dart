import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/incantations/providers/incantation_providers.dart';
import 'package:Watered/features/incantations/screens/incantation_detail_screen.dart';

class IncantationsScreen extends ConsumerWidget {
  const IncantationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final incantationsAsync = ref.watch(incantationsListProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Incantations'),
      ),
      body: incantationsAsync.when(
        data: (incantations) {
          if (incantations.isEmpty) {
            return Center(
              child: Text(
                'No incantations available.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.textTheme.bodyLarge?.color?.withOpacity(0.5),
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: incantations.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final incantation = incantations[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => IncantationDetailScreen(incantation: incantation),
                    ),
                  );
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                tileColor: theme.cardTheme.color,
                contentPadding: const EdgeInsets.all(16),
                leading: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.record_voice_over_outlined, color: theme.colorScheme.primary),
                ),
                title: Text(
                  incantation.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: incantation.description != null ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    incantation.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                ) : null,
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
