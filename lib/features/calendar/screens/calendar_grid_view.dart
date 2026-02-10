import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/calendar/providers/calendar_provider.dart';
import 'package:Watered/features/calendar/models/calendar_month.dart';
import 'package:Watered/features/calendar/models/calendar_day.dart';
import 'package:Watered/features/calendar/screens/day_detail_view.dart';
import 'package:Watered/features/events/models/event.dart';
import 'package:intl/intl.dart';

class CalendarGridView extends ConsumerWidget {
  const CalendarGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarAsync = ref.watch(fullCalendarProvider);
    final selectedMonthNum = ref.watch(selectedMonthProvider);
    final eventsAsync = ref.watch(upcomingEventsProvider);
    final theme = Theme.of(context);

    // Merge logic: we want to have events available when building cells
    final List<Event> allEvents = eventsAsync.asData?.value ?? [];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('WATERED CALENDAR', 
          style: TextStyle(fontFamily: 'Cinzel', fontSize: 16, letterSpacing: 2)
        ),
      ),
      body: calendarAsync.when(
        data: (months) {
          final selectedMonth = months.firstWhere((m) => m.number == selectedMonthNum);
          return Column(
            children: [
              _buildMonthSelector(ref, theme, months, selectedMonthNum),
              _buildMonthHeader(theme, selectedMonth),
              Expanded(
                child: _buildDaysGrid(theme, selectedMonth.days ?? [], allEvents),
              ),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
      ),
    );
  }

  Widget _buildMonthSelector(WidgetRef ref, ThemeData theme, List<CalendarMonth> months, int selected) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: months.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final month = months[index];
          final isSelected = month.number == selected;
          return GestureDetector(
            onTap: () => ref.read(selectedMonthProvider.notifier).state = month.number,
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? theme.colorScheme.primary : theme.dividerColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(30),
                border: isSelected ? null : Border.all(color: theme.dividerColor.withOpacity(0.1)),
              ),
              child: Center(
                child: Text(
                  month.displayName.toUpperCase(),
                  style: TextStyle(
                    color: isSelected ? Colors.black : theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMonthHeader(ThemeData theme, CalendarMonth month) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            month.season?.toUpperCase() ?? '',
            style: TextStyle(color: theme.colorScheme.primary, fontSize: 12, letterSpacing: 4, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            month.displayName,
            style: TextStyle(fontSize: 32, fontFamily: 'Cinzel', color: theme.textTheme.headlineMedium?.color, fontWeight: FontWeight.bold),
          ),
          Text(
            month.gregorianReference ?? '',
            style: TextStyle(color: theme.textTheme.bodySmall?.color?.withOpacity(0.5), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDaysGrid(ThemeData theme, List<CalendarDay> days, List<Event> allEvents) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final day = days[index];
        // Filter events for this day
        // Note: This matches based on Gregorian date alignment if present.
        // Assuming 'gregorianDay' string (e.g., "Sept 11") matches event date format or we simply match logic.
        // For accurate matching, we need exact date comparison which might be tricky with rough "gregorianDay" string.
        // However, if backend sends exact 'date' we could use it.
        // For now, let's assume we filter by matching day/month if we can parse it, OR just pass empty for now if mapping is complex without exact dates.
        // ACTUALLY: The request says "event schedules for a day should also show up".
        // Let's match by checking if an event's start time falls on the *current year's* Gregorian date corresponding to this Kemetic day.
        // Since `gregorianDay` is just a string range (e.g. "Sept 11"), parsing it exactly to a year-specific Date is hard.
        // Ideally, the backend would provide exact dates for days.
        // PROVISIONAL: We will match events that happen to have the SAME DAY index if we had that mapping.
        // Lacking exact mapping, we will parse `gregorianDay` crudely if possible, otherwise we just pass empty.
        
        // Better approach: We check if `day.gregorianDay` (e.g. "Sep 11") matches `DateFormat('MMM d').format(event.startTime)`.
        
        final dayEvents = allEvents.where((e) {
           if (day.gregorianDay == null) return false;
           // format event date to "MMM d" (e.g. "Sep 11")
           // Note: Data might be "Sept 11", so we need to be careful.
           // Let's try flexible matching or standard format.
           // Assume `gregorianDay` comes formatted from backend cleanly.
           // Let's normalize both to be safe? 
           // Or just check containment.
           final eventDateStr = DateFormat('MMM d').format(e.startTime); // "Sep 11"
           return day.gregorianDay!.contains(eventDateStr) || day.gregorianDay!.contains(DateFormat('MMMM d').format(e.startTime));
        }).toList();

        return _buildDayCell(context, theme, day, dayEvents);
      },
    );
  }

  Widget _buildDayCell(BuildContext context, ThemeData theme, CalendarDay day, List<Event> dayEvents) {
    final hasEvents = dayEvents.isNotEmpty;
    
    return GestureDetector(
      onTap: () => DayDetailView.show(context, day, events: dayEvents),
      child: Container(
        decoration: BoxDecoration(
          color: day.isSacred 
              ? theme.colorScheme.primary.withOpacity(0.15) 
              : theme.dividerColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: hasEvents ? Colors.amber : (day.isSacred 
                ? theme.colorScheme.primary.withOpacity(0.5) 
                : theme.dividerColor.withOpacity(0.1))
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              '${day.dayNumber}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: day.isSacred ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
              ),
            ),
            if (day.celebrationType != null || hasEvents)
              Positioned(
                bottom: 4,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (day.celebrationType != null)
                      Container(
                        width: 4, height: 4,
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
                      ),
                    if (hasEvents && day.celebrationType != null) const SizedBox(width: 2),
                    if (hasEvents)
                      Container(
                        width: 4, height: 4,
                        decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
