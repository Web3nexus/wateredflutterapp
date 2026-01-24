import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/events/models/event.dart';
import 'package:Watered/features/events/providers/events_providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class EventDetailScreen extends ConsumerWidget {
  final Event event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final controller = ref.watch(eventControllerProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: event.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: event.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(color: theme.colorScheme.surface),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          event.isPaid ? '\$${event.price?.toStringAsFixed(2)}' : 'FREE',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (event.isRegistered)
                         Chip(
                           label: const Text('Registered'),
                           backgroundColor: Colors.green.withOpacity(0.2),
                           labelStyle: const TextStyle(color: Colors.green),
                           avatar: const Icon(Icons.check, color: Colors.green, size: 18),
                         ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    event.title,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.textTheme.bodyMedium?.color,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    text: DateFormat('EEEE, MMM d, y').format(event.startTime),
                    theme: theme,
                  ),
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: Icons.access_time,
                    text: '${DateFormat('h:mm a').format(event.startTime)} - ${event.endTime != null ? DateFormat('h:mm a').format(event.endTime!) : 'End'}',
                    theme: theme,
                  ),
                  if (event.location != null) ...[
                    const SizedBox(height: 8),
                    _InfoRow(
                      icon: Icons.location_on_outlined,
                      text: event.location!,
                      theme: theme,
                    ),
                  ],
                  const SizedBox(height: 24),
                  if (event.description != null) ...[
                    Text(
                      'About this Event',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event.description!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                      ),
                    ),
                  ],
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
        ),
        child: SafeArea( // Handle bottom notch/bar
          child: ElevatedButton(
            onPressed: controller.isLoading 
                ? null 
                : () async {
                    if (event.isRegistered) {
                        await ref.read(eventControllerProvider.notifier).cancelRegistration(event.id);
                        if (context.mounted) Navigator.of(context).pop(); // Simple UX: close or refresh
                    } else {
                        await ref.read(eventControllerProvider.notifier).registerForEvent(event.id);
                        if (context.mounted) Navigator.of(context).pop();
                    }
                },
            style: ElevatedButton.styleFrom(
              backgroundColor: event.isRegistered ? Colors.redAccent.withOpacity(0.1) : theme.colorScheme.primary,
              foregroundColor: event.isRegistered ? Colors.redAccent : Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: controller.isLoading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : Text(
                    event.isRegistered ? 'CANCEL REGISTRATION' : 'REGISTER NOW',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final ThemeData theme;

  const _InfoRow({
    required this.icon,
    required this.text,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
