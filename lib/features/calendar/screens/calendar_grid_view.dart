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

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
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
              _buildMonthSelector(ref, months, selectedMonthNum),
              _buildMonthHeader(selectedMonth),
              Expanded(
                child: _buildDaysGrid(selectedMonth.days ?? []),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37))),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
      ),
    );
  }

  Widget _buildMonthSelector(WidgetRef ref, List<CalendarMonth> months, int selected) {
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
                color: isSelected ? const Color(0xFFD4AF37) : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(30),
                border: isSelected ? null : Border.all(color: Colors.white10),
              ),
              child: Center(
                child: Text(
                  month.displayName.toUpperCase(),
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white60,
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

  Widget _buildMonthHeader(CalendarMonth month) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            month.season?.toUpperCase() ?? '',
            style: const TextStyle(color: Color(0xFFD4AF37), fontSize: 12, letterSpacing: 4, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            month.displayName,
            style: const TextStyle(fontSize: 32, fontFamily: 'Cinzel', color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            month.gregorianReference ?? '',
            style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDaysGrid(List<CalendarDay> days) {
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
        return _buildDayCell(context, day);
      },
    );
  }

  Widget _buildDayCell(BuildContext context, CalendarDay day) {
    return GestureDetector(
      onTap: () => DayDetailView.show(context, day),
      child: Container(
        decoration: BoxDecoration(
          color: day.isSacred 
              ? const Color(0xFFD4AF37).withOpacity(0.15) 
              : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: day.isSacred 
                ? const Color(0xFFD4AF37).withOpacity(0.5) 
                : Colors.white.withOpacity(0.05)
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
                color: day.isSacred ? const Color(0xFFD4AF37) : Colors.white70,
              ),
            ),
            if (day.celebrationType != null)
              Positioned(
                bottom: 4,
                child: Container(
                  width: 4, height: 4,
                  decoration: const BoxDecoration(color: Color(0xFFD4AF37), shape: BoxShape.circle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
