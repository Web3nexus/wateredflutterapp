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
    final viewMonth = ref.watch(viewMonthProvider);
    final viewYear = ref.watch(viewYearProvider);
    final eventsAsync = ref.watch(upcomingEventsProvider);
    final theme = Theme.of(context);

    // Get Gregorian days for the viewMonth/viewYear
    final firstDayOfMonth = DateTime(viewYear, viewMonth, 1);
    final lastDayOfMonth = DateTime(viewYear, viewMonth + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday % 7; // 0 for Sunday, 1 for Monday...

    final List<Event> allEvents = eventsAsync.asData?.value ?? [];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('WATERED CYCLE', 
          style: TextStyle(fontFamily: 'Cinzel', fontSize: 16, letterSpacing: 2)
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              ref.read(viewMonthProvider.notifier).state = DateTime.now().month;
              ref.read(viewYearProvider.notifier).state = DateTime.now().year;
            },
          ),
        ],
      ),
      body: calendarAsync.when(
        data: (months) {
          // Pre-process months into a map for quick lookup: "MMM d" -> CalendarDay
          final Map<String, (CalendarDay, CalendarMonth)> kemeticMap = {};
          for (var m in months) {
            for (var d in m.days ?? []) {
              if (d.gregorianDay != null) {
                kemeticMap[d.gregorianDay!] = (d, m);
              }
            }
          }

          return Column(
            children: [
              _buildMonthNavigator(ref, theme, viewMonth, viewYear),
              const SizedBox(height: 20),
              _buildWeekdayHeader(theme),
              Expanded(
                child: _buildGregorianGrid(
                  context, 
                  theme, 
                  viewYear, 
                  viewMonth, 
                  firstWeekday, 
                  daysInMonth, 
                  kemeticMap, 
                  allEvents
                ),
              ),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator(color: theme.colorScheme.primary)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
      ),
    );
  }

  Widget _buildMonthNavigator(WidgetRef ref, ThemeData theme, int month, int year) {
    final monthName = DateFormat('MMMM').format(DateTime(year, month));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              if (month == 1) {
                ref.read(viewMonthProvider.notifier).state = 12;
                ref.read(viewYearProvider.notifier).state = year - 1;
              } else {
                ref.read(viewMonthProvider.notifier).state = month - 1;
              }
            },
          ),
          Column(
            children: [
              Text(
                monthName.toUpperCase(),
                style: const TextStyle(fontSize: 24, fontFamily: 'Cinzel', fontWeight: FontWeight.bold, letterSpacing: 2),
              ),
              Text(
                '$year',
                style: TextStyle(color: theme.colorScheme.primary, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              if (month == 12) {
                ref.read(viewMonthProvider.notifier).state = 1;
                ref.read(viewYearProvider.notifier).state = year + 1;
              } else {
                ref.read(viewMonthProvider.notifier).state = month + 1;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'].map((day) => Expanded(
          child: Center(
            child: Text(
              day,
              style: TextStyle(
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.5),
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildGregorianGrid(
    BuildContext context,
    ThemeData theme,
    int year,
    int month,
    int firstWeekday,
    int daysInMonth,
    Map<String, (CalendarDay, CalendarMonth)> kemeticMap,
    List<Event> allEvents,
  ) {
    final totalCells = firstWeekday + daysInMonth;
    final rows = (totalCells / 7).ceil();

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        if (index < firstWeekday) {
          return const SizedBox.shrink();
        }

        final dayNum = index - firstWeekday + 1;
        final currentDT = DateTime(year, month, dayNum);
        final dateKey = DateFormat('MMM d').format(currentDT); // e.g., "Feb 16"
        
        final kemeticData = kemeticMap[dateKey];
        final dayEvents = allEvents.where((e) {
          final eStart = e.startTime;
          return eStart.year == year && eStart.month == month && eStart.day == dayNum;
        }).toList();

        return _buildGregorianDayCell(context, theme, dayNum, currentDT, kemeticData, dayEvents);
      },
    );
  }

  Widget _buildGregorianDayCell(
    BuildContext context, 
    ThemeData theme, 
    int gDay, 
    DateTime currentDT,
    (CalendarDay, CalendarMonth)? kemeticData, 
    List<Event> dayEvents
  ) {
    final isToday = DateUtils.isSameDay(DateTime.now(), currentDT);
    final hasEvents = dayEvents.isNotEmpty;
    final kDay = kemeticData?.$1;
    final isSacred = kDay?.isSacred ?? false;

    return GestureDetector(
      onTap: () {
        if (kDay != null) {
          DayDetailView.show(context, kDay, events: dayEvents, gregorianDate: currentDT);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isToday 
              ? theme.colorScheme.primary 
              : (isSacred 
                  ? theme.colorScheme.primary.withOpacity(0.08) 
                  : theme.dividerColor.withOpacity(0.05)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isToday 
                ? theme.colorScheme.primary 
                : (hasEvents 
                    ? Colors.amber.withOpacity(0.5) 
                    : theme.dividerColor.withOpacity(0.1)),
            width: isToday ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$gDay',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isToday ? Colors.black : theme.textTheme.bodyMedium?.color,
              ),
            ),
            if (kDay != null)
              Text(
                '${kDay.dayNumber}',
                style: TextStyle(
                  fontSize: 10,
                  color: isToday 
                      ? Colors.black.withOpacity(0.6) 
                      : (isSacred ? theme.colorScheme.primary : theme.textTheme.bodySmall?.color?.withOpacity(0.5)),
                  fontWeight: isSacred ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            if (hasEvents)
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: isToday ? Colors.black : Colors.amber,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
