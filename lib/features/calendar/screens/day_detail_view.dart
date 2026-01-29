import 'package:flutter/material.dart';
import 'package:Watered/features/calendar/models/calendar_day.dart';

class DayDetailView extends StatelessWidget {
  final CalendarDay day;

  const DayDetailView({super.key, required this.day});

  static void show(BuildContext context, CalendarDay day) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DayDetailView(day: day),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1E293B),
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                    Text(
                      '${day.month?.displayName} Day ${day.dayNumber}'.toUpperCase(),
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12, letterSpacing: 2, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      day.displayName,
                      style: const TextStyle(fontSize: 28, fontFamily: 'Cinzel', color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    if (day.gregorianDay != null)
                      Text(
                        'Gregorian Alignment: ${day.gregorianDay}',
                        style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
                      ),
                    const SizedBox(height: 32),
                    if (day.celebrationType != null) ...[
                      _buildInfoTag(Icons.festival_outlined, day.celebrationType!),
                      const SizedBox(height: 16),
                    ],
                    if (day.associatedDeities != null && day.associatedDeities!.isNotEmpty) ...[
                      const Text('ASSOCIATED DEITIES', 
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white30, letterSpacing: 1.2)
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: day.associatedDeities!.map((d) => Chip(
                          label: Text(d, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                          backgroundColor: Colors.white.withOpacity(0.05),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        )).toList(),
                      ),
                      const SizedBox(height: 32),
                    ],
                    const Text('SACRED KNOWLEDGE', 
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white30, letterSpacing: 1.2)
                    ),
                    const SizedBox(height: 12),
                    Text(
                      day.content ?? 'No specific spiritual content has been added for this day yet. Spend time in meditation on the current season.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.7,
                        color: Colors.white.withOpacity(0.9),
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

  Widget _buildInfoTag(IconData icon, String text) {
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
