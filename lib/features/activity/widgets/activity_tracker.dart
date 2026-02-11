import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/activity/services/user_activity_service.dart';

/// Wraps a screen to track how long the user stays on it.
/// Sends data to backend on dispose.
class ActivityTracker extends ConsumerStatefulWidget {
  final String pageName;
  final Widget child;

  const ActivityTracker({
    super.key,
    required this.pageName,
    required this.child,
  });

  @override
  ConsumerState<ActivityTracker> createState() => _ActivityTrackerState();
}

class _ActivityTrackerState extends ConsumerState<ActivityTracker> {
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
  }

  @override
  void dispose() {
    _trackDuration();
    super.dispose();
  }

  void _trackDuration() {
    if (_startTime == null) return;
    
    final endTime = DateTime.now();
    final duration = endTime.difference(_startTime!);
    
    // Only track if meaningful duration (e.g. > 1 sec)
    if (duration.inSeconds >= 1) {
      ref.read(userActivityServiceProvider).trackActivity(
        widget.pageName,
        duration.inSeconds,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
