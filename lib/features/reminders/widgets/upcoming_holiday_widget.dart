import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:Watered/features/reminders/providers/holiday_providers.dart';
import 'package:Watered/features/reminders/providers/holiday_reminder_provider.dart';
import 'package:Watered/features/reminders/widgets/holiday_reminder_bottom_sheet.dart';

class UpcomingHolidayWidget extends ConsumerWidget {
  const UpcomingHolidayWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holidaysAsync = ref.watch(holidaysListProvider);
    final remindersAsync = ref.watch(holidayRemindersListProvider);
    final theme = Theme.of(context);
    final now = DateTime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            'UPCOMING HOLIDAYS',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 12),
        holidaysAsync.when(
          data: (holidays) {
            // Filter for upcoming holidays (next 60 days, including today)
            final upcomingHolidays = holidays.where((h) {
              final today = DateTime(now.year, now.month, now.day);
              final date = DateTime(h.date.year, h.date.month, h.date.day);
              return !date.isBefore(today);
            }).toList();

            if (upcomingHolidays.isEmpty) {
              return Text(
                'No upcoming holy days found.',
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
              );
            }

            return SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: upcomingHolidays.length,
                itemBuilder: (context, index) {
                  final h = upcomingHolidays[index];
                  final isToday = DateUtils.isSameDay(h.date, now);
                  
                  // Check if any reminder exists for this holiday
                  final reminders = remindersAsync.when(
                    data: (list) => list.where((r) => 
                      (h.id > 0 && r.holidayId == h.id) || 
                      (h.id < 0 && r.calendarDayId == h.id.abs())
                    ).toList(),
                    loading: () => [],
                    error: (_, __) => [],
                  );
                  final hasReminder = reminders.isNotEmpty;

                  return InkWell(
                    onTap: () => HolidayReminderBottomSheet.show(context, h, reminders),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      width: 240,
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isToday 
                            ? theme.colorScheme.primary.withOpacity(0.1) 
                            : theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isToday 
                              ? theme.colorScheme.primary.withOpacity(0.4) 
                              : (hasReminder ? theme.colorScheme.primary.withOpacity(0.2) : theme.dividerColor.withOpacity(0.05)),
                        ),
                        boxShadow: isToday ? [
                          BoxShadow(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ] : null,
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isToday ? Icons.auto_awesome : Icons.celebration_rounded,
                                  color: theme.colorScheme.primary,
                                  size: 24,
                                ),
                              ),
                              if (hasReminder)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: theme.scaffoldBackgroundColor, width: 2),
                                    ),
                                    child: const Icon(Icons.notifications_active, color: Colors.white, size: 8),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  h.name,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isToday ? 'CELEBRATING TODAY' : DateFormat('MMMM d, y').format(h.date),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isToday 
                                        ? theme.colorScheme.primary 
                                        : theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, ss) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

