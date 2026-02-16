import 'package:flutter/material.dart';
import 'package:Watered/features/calendar/models/calendar_day.dart';

import 'package:Watered/features/events/models/event.dart';
import 'package:intl/intl.dart';

class DayDetailView extends StatelessWidget {
  final CalendarDay day;
  final List<Event>? events;
  final DateTime? gregorianDate;

  const DayDetailView({super.key, required this.day, this.events, this.gregorianDate});

  static void show(BuildContext context, CalendarDay day, {List<Event>? events, DateTime? gregorianDate}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DayDetailView(day: day, events: events, gregorianDate: gregorianDate),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final baseTextColor = theme.textTheme.bodyLarge?.color ?? (isDark ? Colors.white : Colors.black);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: baseTextColor.withOpacity(0.1), 
                  borderRadius: BorderRadius.circular(2)
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                    Text(
                      '${DateFormat('EEEE, MMMM d, yyyy').format(gregorianDate ?? DateTime.now())}'.toUpperCase(),
                      style: TextStyle(
                        color: theme.colorScheme.primary, 
                        fontSize: 12, 
                        letterSpacing: 2, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      day.displayName,
                      style: TextStyle(
                        fontSize: 28, 
                        fontFamily: 'Cinzel', 
                        color: baseTextColor, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      '${day.month?.displayName} • Day ${day.dayNumber}',
                      style: TextStyle(
                        color: baseTextColor.withOpacity(0.6), 
                        fontSize: 16,
                        fontFamily: 'Cinzel',
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (events != null && events!.isNotEmpty) ...[
                      Text('EVENTS', 
                        style: TextStyle(
                          fontSize: 10, 
                          fontWeight: FontWeight.bold, 
                          color: baseTextColor.withOpacity(0.3), 
                          letterSpacing: 1.2
                        )
                      ),
                      const SizedBox(height: 12),
                      ...events!.map((e) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: baseTextColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: baseTextColor.withOpacity(0.1)),
                        ),
                        child: Row(
                          children: [
                             Container(
                                width: 40, height: 40,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primary.withOpacity(0.2), 
                                  shape: BoxShape.circle
                                ),
                                child: Icon(Icons.event, color: theme.colorScheme.primary, size: 20),
                             ),
                             const SizedBox(width: 12),
                             Expanded(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(e.title, style: TextStyle(color: baseTextColor, fontWeight: FontWeight.bold)),
                                   Text(DateFormat('h:mm a').format(e.startTime), 
                                     style: TextStyle(color: baseTextColor.withOpacity(0.5), fontSize: 12)
                                   ),
                                 ],
                               ),
                             )
                          ],
                        ),
                      )),
                      const SizedBox(height: 24),
                    ],
                    if (day.celebrationType != null) ...[
                      _buildInfoTag(context, Icons.festival_outlined, day.celebrationType!),
                      const SizedBox(height: 16),
                    ],
                    if (day.associatedDeities != null && day.associatedDeities!.isNotEmpty) ...[
                      Text('ASSOCIATED DEITIES', 
                        style: TextStyle(
                          fontSize: 10, 
                          fontWeight: FontWeight.bold, 
                          color: baseTextColor.withOpacity(0.3), 
                          letterSpacing: 1.2
                        )
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: day.associatedDeities!.map((d) => Chip(
                          label: Text(d, style: TextStyle(fontSize: 12, color: baseTextColor.withOpacity(0.7))),
                          backgroundColor: baseTextColor.withOpacity(0.05),
                          side: BorderSide(color: baseTextColor.withOpacity(0.1)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        )).toList(),
                      ),
                      const SizedBox(height: 32),
                    ],
                    Text('SACRED KNOWLEDGE', 
                      style: TextStyle(
                        fontSize: 10, 
                        fontWeight: FontWeight.bold, 
                        color: baseTextColor.withOpacity(0.3), 
                        letterSpacing: 1.2
                      )
                    ),
                    const SizedBox(height: 12),
                    Text(
                      day.content ?? 'No specific spiritual content has been added for this day yet. Spend time in meditation on the current season.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.7,
                        color: baseTextColor.withOpacity(0.9),
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoTag(BuildContext context, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
