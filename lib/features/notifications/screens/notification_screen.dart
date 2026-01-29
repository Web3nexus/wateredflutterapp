import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _selectedFilter = 'ALL';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Mock notifications with types
    final mockNotifications = [
      {
        'title': 'New Sacred Text Added',
        'body': 'A new chapter of the Ifa Corpus is now available in the Library.',
        'time': DateTime.now().subtract(const Duration(hours: 2)),
        'isRead': false,
        'type': 'UPDATE',
      },
      {
        'title': 'Upcoming Ritual',
        'body': 'Don\'t forget the Full Moon Ritual tonight at 8 PM.',
        'time': DateTime.now().subtract(const Duration(days: 1)),
        'isRead': true,
        'type': 'RITUAL',
      },
    ];

    final filtered = _selectedFilter == 'ALL' 
        ? mockNotifications 
        : mockNotifications.where((n) => n['type'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('NOTIFICATIONS')),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: filtered.isEmpty
                ? const _EmptyNotifications()
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final n = filtered[index];
                      return _NotificationCard(
                        title: n['title'] as String,
                        body: n['body'] as String,
                        time: n['time'] as DateTime,
                        isRead: n['isRead'] as bool,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: ['ALL', 'RITUAL', 'EVENT', 'UPDATE'].map((filter) {
          final isSelected = _selectedFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (val) => setState(() => _selectedFilter = filter),
              selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              labelStyle: TextStyle(
                color: isSelected ? Theme.of(context).colorScheme.primary : theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final DateTime time;
  final bool isRead;

  const _NotificationCard({
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: isRead ? null : Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (isRead ? Colors.blueGrey : Theme.of(context).colorScheme.primary).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isRead ? Icons.notifications_none_rounded : Icons.notifications_active_rounded,
              color: isRead ? Colors.blueGrey : Theme.of(context).colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7), fontSize: 13),
                ),
                const SizedBox(height: 8),
                Text(
                  DateFormat('MMM d, h:mm a').format(time),
                  style: TextStyle(color: theme.textTheme.bodySmall?.color?.withOpacity(0.4), fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 64, color: Colors.blueGrey),
          SizedBox(height: 16),
          Text('Nothing here yet...', style: TextStyle(color: Colors.blueGrey)),
        ],
      ),
    );
  }
}
