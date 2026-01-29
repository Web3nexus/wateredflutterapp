import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/calendar/providers/calendar_provider.dart';
import 'package:Watered/features/calendar/models/calendar_month.dart';
import 'package:Watered/features/calendar/models/calendar_day.dart';
import 'package:Watered/features/calendar/screens/day_detail_view.dart';

class CalendarGridView extends ConsumerWidget {
  const CalendarGridView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarAsync = ref.watch(fullCalendarProvider);
    final selectedMonthNum = ref.watch(selectedMonthProvider);
    final theme = Theme.of(context);

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
                child: _buildDaysGrid(theme, selectedMonth.days ?? []),
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

  Widget _buildDaysGrid(ThemeData theme, List<CalendarDay> days) {
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
        return _buildDayCell(context, theme, day);
      },
    );
  }

  Widget _buildDayCell(BuildContext context, ThemeData theme, CalendarDay day) {
    return GestureDetector(
      onTap: () => DayDetailView.show(context, day),
      child: Container(
        decoration: BoxDecoration(
          color: day.isSacred 
              ? theme.colorScheme.primary.withOpacity(0.15) 
              : theme.dividerColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: day.isSacred 
                ? theme.colorScheme.primary.withOpacity(0.5) 
                : theme.dividerColor.withOpacity(0.1)
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
            if (day.celebrationType != null)
              Positioned(
                bottom: 4,
                child: Container(
                  width: 4, height: 4,
                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
