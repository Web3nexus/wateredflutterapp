import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/reminders/models/holiday.dart';
import 'package:Watered/features/reminders/services/holiday_reminder_service.dart';
import 'package:Watered/features/reminders/providers/holiday_reminder_provider.dart';
import 'package:intl/intl.dart';

class HolidayReminderBottomSheet extends ConsumerStatefulWidget {
  final Holiday holiday;
  final List<dynamic> existingReminders; // Existing HolidayReminder objects

  const HolidayReminderBottomSheet({
    super.key,
    required this.holiday,
    this.existingReminders = const [],
  });

  static void show(BuildContext context, Holiday holiday, List<dynamic> existing) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => HolidayReminderBottomSheet(holiday: holiday, existingReminders: existing),
    );
  }

  @override
  ConsumerState<HolidayReminderBottomSheet> createState() => _HolidayReminderBottomSheetState();
}

class _HolidayReminderBottomSheetState extends ConsumerState<HolidayReminderBottomSheet> {
  bool _dayOf = false;
  bool _dayBefore = false;
  DateTime? _customDateTime;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Initialize from existing
    for (var r in widget.existingReminders) {
      if (r.type == 'day_of') _dayOf = true;
      if (r.type == '24h_before') _dayBefore = true;
    }
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    try {
      final List<Map<String, dynamic>> reminders = [];
      
      if (_dayOf) {
        reminders.add({
          'time': DateTime(widget.holiday.date.year, widget.holiday.date.month, widget.holiday.date.day, 9, 0).toIso8601String(),
          'type': 'day_of',
        });
      }
      
      if (_dayBefore) {
        final dayBefore = widget.holiday.date.subtract(const Duration(days: 1));
        reminders.add({
          'time': DateTime(dayBefore.year, dayBefore.month, dayBefore.day, 9, 0).toIso8601String(),
          'type': '24h_before',
        });
      }

      if (_customDateTime != null) {
        reminders.add({
          'time': _customDateTime!.toIso8601String(),
          'type': 'custom',
        });
      }

      await ref.read(holidayReminderServiceProvider).saveHolidayReminders(
        holidayId: widget.holiday.id > 0 ? widget.holiday.id : null,
        calendarDayId: widget.holiday.id < 0 ? widget.holiday.id.abs() : null,
        holidayName: widget.holiday.name,
        reminders: reminders,
      );

      ref.invalidate(holidayRemindersListProvider);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save reminders: $e')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sacred Reminder',
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Cinzel'),
              ),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Keep path with ${widget.holiday.name}',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary),
          ),
          const SizedBox(height: 24),
          
          _buildToggle(
            'Morning of the holy day',
            'Notification at 9:00 AM',
            _dayOf,
            (v) => setState(() => _dayOf = v),
          ),
          const SizedBox(height: 16),
          _buildToggle(
            '24 hours before',
            'Get ready for the celebration',
            _dayBefore,
            (v) => setState(() => _dayBefore = v),
          ),
          const SizedBox(height: 16),
          
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(Icons.calendar_today_rounded, color: theme.colorScheme.primary),
            ),
            title: const Text('Custom Reminder', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(_customDateTime == null ? 'Set a specific date and time' : DateFormat('MMM d, h:mm a').format(_customDateTime!)),
            trailing: TextButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: widget.holiday.date.isAfter(DateTime.now()) ? widget.holiday.date : DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: widget.holiday.date.add(const Duration(days: 1)),
                );
                if (date != null && mounted) {
                  final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                  if (time != null) {
                    setState(() {
                      _customDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                    });
                  }
                }
              },
              child: Text(_customDateTime == null ? 'Set' : 'Change'),
            ),
          ),
          
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isSaving ? null : _save,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: _isSaving 
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) 
                : const Text('Save Reminders', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildToggle(String title, String subtitle, bool value, Function(bool) onChanged) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: value ? theme.colorScheme.primary.withOpacity(0.3) : theme.dividerColor.withOpacity(0.05)),
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        value: value,
        onChanged: onChanged,
        activeColor: theme.colorScheme.primary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
