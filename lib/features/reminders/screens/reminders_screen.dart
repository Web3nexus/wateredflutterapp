import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/reminders/providers/reminder_providers.dart';
import 'package:Watered/features/reminders/services/reminder_service.dart';
import 'package:Watered/features/config/providers/global_settings_provider.dart';

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
              builder: (context) => AlertDialog(
                  title: const Text('New Reminder'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(controller: titleController, decoration: const InputDecoration(hintText: 'e.g. Morning Ritual')),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: selectedSound,
                        decoration: const InputDecoration(labelText: 'Alarm Sound'),
                        items: const [
                          DropdownMenuItem(value: 'default', child: Text('Default Sound')),
                          DropdownMenuItem(value: 'nature', child: Text('Nature (African Savannah)')),
                          DropdownMenuItem(value: 'drums', child: Text('Sacred Drums')),
                          DropdownMenuItem(value: 'chant', child: Text('Ancient Chant')),
                        ],
                        onChanged: (val) => selectedSound = val,
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
                          child: const Text('Save')
                      ),
                  ],
              )
          );
      }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final remindersAsync = ref.watch(remindersListProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Daily Reminders')),
      body: remindersAsync.when(
        data: (reminders) {
          if (reminders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.alarm_off_rounded, size: 60, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('No reminders set.', style: theme.textTheme.bodyLarge),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: reminders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              return Dismissible(
                key: Key(reminder.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                    color: Colors.redAccent, 
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
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(reminder.title, style: theme.textTheme.titleMedium),
                            const SizedBox(height: 4),
                            Text(reminder.soundPath ?? 'Default Sound', style: theme.textTheme.bodySmall),
                          ],
                        ),
                      ),
                      Switch(
                        value: reminder.isActive,
                        activeColor: theme.colorScheme.primary,
                        onChanged: (val) async {
                            await ref.read(reminderServiceProvider).updateReminder(reminder.id!, isActive: val);
                            ref.refresh(remindersListProvider);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addReminder,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
