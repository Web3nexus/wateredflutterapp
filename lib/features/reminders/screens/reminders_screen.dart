import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/reminders/providers/reminder_providers.dart';
import 'package:Watered/features/reminders/services/reminder_service.dart';
import 'package:Watered/features/config/providers/global_settings_provider.dart';
import 'package:Watered/features/audio/services/audio_service.dart'; // Add import
import 'package:Watered/features/audio/services/sacred_sound_service.dart'; // Add import
import 'package:Watered/core/widgets/premium_gate.dart';

import 'dart:async';
import 'package:Watered/features/reminders/providers/holiday_providers.dart';
import 'package:Watered/features/reminders/models/holiday.dart';
import 'package:Watered/features/reminders/models/reminder.dart';
import 'package:Watered/features/rituals/models/ritual.dart';
import 'package:Watered/features/rituals/providers/ritual_providers.dart';
import 'package:Watered/features/rituals/widgets/sacred_schedule_widget.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart'; // Add import

class RemindersScreen extends ConsumerStatefulWidget {
  const RemindersScreen({super.key});

  @override
  ConsumerState<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends ConsumerState<RemindersScreen> {

  Future<void> _addReminder() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null && mounted) {
      final titleController = TextEditingController();
      String? selectedSound = ref.read(globalSettingsNotifierProvider).asData?.value.alarmSoundPath;

      await showDialog(
          context: context,
          builder: (context) => Consumer(
            builder: (context, ref, _) {
              final sacredSoundsAsync = ref.watch(sacredSoundsProvider);
              
              // Build items list
              List<DropdownMenuItem<String>> soundItems = [];

              sacredSoundsAsync.whenData((sounds) {
                for (var sound in sounds) {
                  soundItems.add(DropdownMenuItem(
                    value: sound.filePath, // Use URL as value
                    child: Text(sound.title),
                  ));
                }
              });

              return AlertDialog(
                title: const Text('New Reminder'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: titleController, decoration: const InputDecoration(hintText: 'e.g. Morning Ritual')),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedSound,
                            decoration: const InputDecoration(labelText: 'Alarm Sound'),
                            items: soundItems,
                            onChanged: (val) {
                              selectedSound = val;
                              // Play preview logic could go here
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.play_arrow_rounded),
                          onPressed: () async {
                              final player = await ref.read(audioPlayerProvider.future);
                              // Determine asset path based on selection
                              /* 
                               * Simplified logic: We now only use URL-based sounds from backend.
                               * Local assets (nature, drums, etc.) are removed.
                               */
                              if (selectedSound == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please select a sound first')),
                                );
                                return;
                              }

                              try {
                                await player.stop();
                                await player.setAudioSource(
                                  AudioSource.uri(
                                    Uri.parse(selectedSound!),
                                    tag: MediaItem(
                                      id: selectedSound!,
                                      album: "Custom Sound",
                                      title: "Preview",
                                    ),
                                  ),
                                );
                                await player.play();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Preview unavailable for this sound')),
                                );
                              }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                  TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        if (titleController.text.isNotEmpty) {
                          await ref.read(reminderServiceProvider).saveReminder(
                                titleController.text,
                                time,
                                ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                                soundPath: selectedSound,
                              );
                          ref.refresh(remindersListProvider);
                        }
                      },
                      child: const Text('Save')),
                ],
              );
            }
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ritualsAsync = ref.watch(ritualsListProvider(null));
    final holidaysAsync = ref.watch(holidaysListProvider);
    final remindersAsync = ref.watch(remindersListProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Sacred Reminders')),
      body: CustomScrollView(
        slivers: [
          // Sacred Schedule Widget at the top
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SacredScheduleWidget(),
            ),
          ),
          
          const SliverToBoxAdapter(
            child: Divider(height: 32),
          ),
          
          // Countdown Section Removed
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UPCOMING HOLIDAYS',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  holidaysAsync.when(
                    data: (holidays) {
                      if (holidays.isEmpty) return const Text('No upcoming holidays.', style: TextStyle(color: Colors.grey));
                      
                      // Filter for upcoming holidays (next 30 days, including today)
                      final upcomingHolidays = holidays.where((h) {
                         final now = DateTime.now();
                         final date = DateTime(h.date.year, h.date.month, h.date.day);
                         return !date.isBefore(DateTime(now.year, now.month, now.day));
                      }).toList();
                      
                      // Sort by date
                      upcomingHolidays.sort((a, b) => a.date.compareTo(b.date));

                      if (upcomingHolidays.isEmpty) return const Text('No upcoming holidays.', style: TextStyle(color: Colors.grey));

                      return SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: upcomingHolidays.length,
                          itemBuilder: (context, index) {
                            final h = upcomingHolidays[index];
                            final now = DateTime.now();
                            final isToday = DateUtils.isSameDay(h.date, now);
                            
                            return Container(
                              width: 220,
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isToday ? theme.colorScheme.primary.withOpacity(0.1) : theme.cardTheme.color,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: isToday ? theme.colorScheme.primary.withOpacity(0.3) : Colors.white.withOpacity(0.05)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.secondary.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.celebration_rounded, color: theme.colorScheme.secondary, size: 20),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(h.name, 
                                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                          maxLines: 1, overflow: TextOverflow.ellipsis),
                                        Text(
                                          isToday ? 'TODAY' : DateFormat('MMM d, y').format(h.date),
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: isToday ? theme.colorScheme.primary : theme.colorScheme.primary.withOpacity(0.7),
                                            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'DAILY SACRED SCHEDULE',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Reminders List
          remindersAsync.when(
            data: (reminders) {
              // Merge Today's Holidays into the daily schedule
              final now = DateTime.now();
              final todayHolidays = holidaysAsync.asData?.value.where((h) => DateUtils.isSameDay(h.date, now)) ?? [];
              
              final List<Map<String, dynamic>> combinedItems = [];
              
              // Add Holidays for TODAY
              for (var h in todayHolidays) {
                combinedItems.add({
                  'type': 'holiday',
                  'title': h.name,
                  'time': const TimeOfDay(hour: 0, minute: 0), // Full day
                  'isPassed': false,
                  'data': h,
                });
              }
              
              // Add Reminders
              for (var r in reminders) {
                final reminderTime = DateTime(now.year, now.month, now.day, r.time.hour, r.time.minute);
                combinedItems.add({
                  'type': 'reminder',
                  'title': r.title,
                  'time': r.time,
                  // Check if time has passed TODAY
                  'isPassed': reminderTime.isBefore(now),
                  'data': r,
                });
              }
              
              // Sort by time
              combinedItems.sort((a, b) {
                final tA = a['time'] as TimeOfDay;
                final tB = b['time'] as TimeOfDay;
                if (tA.hour != tB.hour) return tA.hour.compareTo(tB.hour);
                return tA.minute.compareTo(tB.minute);
              });

              if (combinedItems.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.alarm_off_rounded, size: 60, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text('No reminders or holidays for today.', style: theme.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                );
              }

              final upcoming = combinedItems.where((i) => !i['isPassed']).toList();
              final passed = combinedItems.where((i) => i['isPassed']).toList();

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    if (upcoming.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      ...upcoming.map((item) => _buildReminderItem(context, item, theme, false)),
                    ],
                    if (passed.isNotEmpty) ...[
                      const SizedBox(height: 32),
                      Text(
                        'PASSED TODAY',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: theme.textTheme.bodySmall?.color?.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...passed.map((item) => _buildReminderItem(context, item, theme, true)),
                    ],
                  ]),
                ),
              );
            },
            loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
            error: (e, s) => SliverFillRemaining(child: Center(child: Text('Error: $e'))),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReminder,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildReminderItem(BuildContext context, Map<String, dynamic> item, ThemeData theme, bool isPassed) {
    if (item['type'] == 'holiday') {
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.secondary.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(Icons.celebration_rounded, color: theme.colorScheme.secondary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title'], style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const Text('Sacred Holiday', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final reminder = item['data'] as Reminder;
    return Opacity(
      opacity: isPassed ? 0.5 : 1.0,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Dismissible(
          key: Key(reminder.id.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(16)),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) async {
            await ref.read(reminderServiceProvider).deleteReminder(reminder.id!);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Text(
                  reminder.time.format(context),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isPassed ? theme.textTheme.bodySmall?.color?.withOpacity(0.5) : theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(reminder.title, 
                        style: theme.textTheme.titleMedium?.copyWith(
                          decoration: isPassed ? TextDecoration.lineThrough : null,
                        )),
                      const SizedBox(height: 4),
                      Text(reminder.soundPath ?? 'Default Sound', style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                if (!isPassed)
                  Switch(
                    value: reminder.isActive,
                    activeColor: theme.colorScheme.primary,
                    onChanged: (val) async {
                      await ref.read(reminderServiceProvider).updateReminder(reminder.id!, isActive: val);
                      ref.refresh(remindersListProvider);
                    },
                  )
                else
                  const Icon(Icons.check_circle_outline, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
