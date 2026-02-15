import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/events/models/event.dart';
import 'package:Watered/features/events/providers/events_providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      imageUrl: event.effectiveImageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.white.withOpacity(0.05),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.white.withOpacity(0.05),
                        child: const Icon(Icons.error_outline),
                      ),
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
                          event.isPaid ? '₦${event.price?.toStringAsFixed(2)}' : 'FREE',
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          if (event.isRegistered)
                             Chip(
                               label: const Text('Registered'),
                               backgroundColor: Colors.green.withOpacity(0.2),
                               labelStyle: const TextStyle(color: Colors.green),
                               avatar: const Icon(Icons.check, color: Colors.green, size: 18),
                             ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: controller.isLoading 
                                ? null 
                                : () => ref.read(eventControllerProvider.notifier).toggleReminder(event.id, event.hasReminder),
                            icon: Icon(
                              event.hasReminder ? Icons.notifications_active : Icons.notifications_none,
                              color: event.hasReminder ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                            ),
                            tooltip: event.hasReminder ? 'Remove Reminder' : 'Set Reminder',
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    event.title,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.textTheme.bodyMedium?.color,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (!event.startTime.isBefore(DateTime.now()))
                    _CountdownTimer(startTime: event.startTime),
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
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      event.description!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                        fontSize: 15,
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
                    } else if (event.isPaid) {
                        // Payment flow
                        final paymentData = await ref.read(eventControllerProvider.notifier).initiateEventPayment(event.id);
                        if (paymentData != null && paymentData['authorization_url'] != null) {
                           final url = Uri.parse(paymentData['authorization_url']);
                           if (await canLaunchUrl(url)) {
                             await launchUrl(url, mode: LaunchMode.externalApplication);
                           } else {
                             ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(content: Text('Could not open payment page.'))
                             );
                           }
                        }
                    } else {
                        await ref.read(eventControllerProvider.notifier).registerForEvent(event.id);
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
                    event.isRegistered 
                        ? 'CANCEL REGISTRATION' 
                        : (event.isPaid ? 'REGISTER & PAY' : 'REGISTER NOW'),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
          ),
        ),
      ),
    );
  }
}

class _CountdownTimer extends StatefulWidget {
  final DateTime startTime;
  const _CountdownTimer({required this.startTime});

  @override
  State<_CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<_CountdownTimer> {
  late Duration _remaining;
  late final Stream<Duration> _stream;

  @override
  void initState() {
    super.initState();
    _remaining = widget.startTime.difference(DateTime.now());
    _stream = Stream.periodic(const Duration(seconds: 1), (_) => widget.startTime.difference(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: _stream,
      initialData: _remaining,
      builder: (context, snapshot) {
        final duration = snapshot.data ?? Duration.zero;
        if (duration.isNegative) return const SizedBox.shrink();

        final days = duration.inDays;
        final hours = duration.inHours % 24;
        final minutes = duration.inMinutes % 60;
        final seconds = duration.inSeconds % 60;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.timer_outlined, size: 18),
              const SizedBox(width: 12),
              _buildTimeUnit(days.toString().padLeft(2, '0'), 'Days'),
              _buildDivider(),
              _buildTimeUnit(hours.toString().padLeft(2, '0'), 'Hrs'),
              _buildDivider(),
              _buildTimeUnit(minutes.toString().padLeft(2, '0'), 'Min'),
              _buildDivider(),
              _buildTimeUnit(seconds.toString().padLeft(2, '0'), 'Sec'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeUnit(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.bodySmall?.color)),
      ],
    );
  }

  Widget _buildDivider() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 12),
    child: Text(':', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
  );
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
