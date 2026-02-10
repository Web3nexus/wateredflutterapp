import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/events/providers/events_providers.dart';
import 'package:Watered/features/events/screens/event_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import 'package:Watered/features/traditions/providers/tradition_provider.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  String _selectedRecurrence = 'All';
  String _selectedCategory = 'All';
  int? _selectedTraditionId;

  final List<String> _recurrences = ['All', 'Weekly', 'Monthly', 'Yearly', 'Special'];
  final List<String> _categories = ['All', 'Sacred Celebration', 'Symposium', 'Workshop', 'Lecture'];

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsListProvider(EventFilter(
      category: _selectedCategory == 'All' ? null : _selectedCategory,
      recurrence: _selectedRecurrence == 'All' ? null : _selectedRecurrence,
      traditionId: _selectedTraditionId,
    )));
    final traditionsAsync = ref.watch(traditionListProvider());
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Upcoming Events'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                return _buildModernFilter(
                  label: cat,
                  isSelected: _selectedCategory == cat,
                  onTap: () => setState(() => _selectedCategory = cat),
                  theme: theme,
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Recurrence Factor Filter
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _recurrences.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final rec = _recurrences[index];
                return _buildModernFilter(
                  label: rec,
                  isSelected: _selectedRecurrence == rec,
                  onTap: () => setState(() => _selectedRecurrence = rec),
                  theme: theme,
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Tradition Filter
          SizedBox(
            height: 50,
            child: traditionsAsync.when(
              data: (traditions) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: traditions.data.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final isAll = index == 0;
                    final tradition = isAll ? null : traditions.data[index - 1];
                    final isSelected = isAll ? _selectedTraditionId == null : _selectedTraditionId == tradition?.id;

                    return _buildModernFilter(
                      label: isAll ? 'All Traditions' : tradition!.name,
                      isSelected: isSelected,
                      onTap: () => setState(() => _selectedTraditionId = tradition?.id),
                      theme: theme,
                    );
                  },
                );
              },
              loading: () => const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          Expanded(
            child: eventsAsync.when(
              data: (events) {
                final filteredEvents = events;

                if (filteredEvents.isEmpty) {
                  return Center(
                    child: Text(
                      'No upcoming events match these filters.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodyLarge?.color?.withOpacity(0.5),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: filteredEvents.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final event = filteredEvents[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => EventDetailScreen(event: event),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.cardTheme.color,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.05)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (event.imageUrl != null)
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: CachedNetworkImage(
                                  imageUrl: event.imageUrl!,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          DateFormat('MMM d, y • h:mm a').format(event.startTime),
                                          style: TextStyle(
                                            color: theme.colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      if (event.recurrence != null)
                                        Text(
                                          event.recurrence!.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: theme.colorScheme.secondary,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    event.title,
                                    style: theme.textTheme.titleLarge?.copyWith(fontSize: 20),
                                  ),
                                  const SizedBox(height: 4),
                                  if (event.location != null)
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 16,
                                          color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          event.location!,
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernFilter({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : theme.cardTheme.color,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : theme.dividerColor.withOpacity(0.1),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
