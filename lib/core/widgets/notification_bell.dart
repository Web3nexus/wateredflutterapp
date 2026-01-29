import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/notifications/screens/notification_screen.dart';

class NotificationBell extends ConsumerWidget {
  const NotificationBell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Connect to a notification count provider
    const bool hasUnread = true; 

    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications_none_rounded, color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NotificationScreen()),
            );
          },
        ),
        if (hasUnread)
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
