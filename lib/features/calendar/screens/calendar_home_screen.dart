import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/calendar/providers/calendar_provider.dart';
import 'package:Watered/features/calendar/models/calendar_day.dart';
import 'package:Watered/features/calendar/screens/calendar_grid_view.dart';
import 'package:intl/intl.dart';

class CalendarHomeScreen extends ConsumerWidget {
  const CalendarHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayAsync = ref.watch(kemeticTodayProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: todayAsync.when(
                data: (data) => _buildTodayContent(context, ref, data),
                loading: () => Center(
                  child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
                ),
                error: (err, stack) => Center(
                  child: Text('Failed to load calendar: $err',
                      style: const TextStyle(color: Colors.red)),
                ),
              ),
            ),
          ),
          _buildQuickInfo(context),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CalendarGridView()),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        icon: const Icon(Icons.calendar_month, color: Colors.black),
        label: const Text('FULL CALENDAR', 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('THE SACRED CYCLE',
            style: TextStyle(
                fontFamily: 'Cinzel',
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 16)),
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                ),
              ),
            ),
            Center(
              child: Opacity(
                opacity: 0.1,
                child: Icon(Icons.wb_sunny_rounded, size: 150, color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayContent(BuildContext context, WidgetRef ref, Map<String, dynamic> data) {
    final kemetic = data['kemetic_date'];
    final dayDetails = data['day_details'] != null 
        ? CalendarDay.fromJson(data['day_details']) 
        : null;

    final upcomingEventsAsync = ref.watch(upcomingEventsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDateCard(context, kemetic),
        const SizedBox(height: 24),
        if (dayDetails != null) ...[
          _buildSectionHeader(context, 'TODAY\'S REFLECTION'),
          const SizedBox(height: 12),
          _buildReflectionCard(context, dayDetails),
        ],
        const SizedBox(height: 24),
        _buildSectionHeader(context, 'UPCOMING FESTIVALS'),
        const SizedBox(height: 12),
        upcomingEventsAsync.when(
          data: (events) {
            if (events.isEmpty) {
              return const Text('No upcoming festivals scheduled.', style: TextStyle(color: Colors.grey));
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: events.length > 3 ? 3 : events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.02),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.event, color: Theme.of(context).colorScheme.primary, size: 20),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('MMMM dd, yyyy').format(event.startTime),
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
            loading: () => const Center(child: LinearProgressIndicator()),
            error: (err, _) => Text('Failed to load events', style: TextStyle(color: Colors.red.withOpacity(0.8), fontSize: 12)),
          ),
        ],
      );
    }
  Widget _buildDateCard(BuildContext context, Map<String, dynamic> kemetic) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            '${kemetic['month_name']}'.toUpperCase(),
            style: TextStyle(
              fontSize: 28,
              fontFamily: 'Cinzel',
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Day ${kemetic['day_number']}',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).textTheme.headlineMedium?.color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
             'Year ${kemetic['year'] ?? ''} • ${kemetic['season'] ?? ''}',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.4),
              letterSpacing: 1.5,
            ),
          ),
          if (kemetic['deities'] != null) ...[
            const SizedBox(height: 16),
            Text(
              'DEITY: ${kemetic['deities']}'.toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
          if (kemetic['meaning'] != null && kemetic['meaning'].toString().isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              '${kemetic['meaning']}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Colors.black12),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time, size: 14, color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.4)),
              const SizedBox(width: 8),
              Text(
                'Matches: ${DateFormat('MMMM dd, yyyy').format(DateTime.now())}',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReflectionCard(BuildContext context, CalendarDay day) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (day.customDayName != null)
            Text(day.customDayName!, 
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: Theme.of(context).colorScheme.primary
              )
            ),
          const SizedBox(height: 8),
          Text(
            day.content ?? 'Spend today in quiet contemplation of the Divine Cycle. Reconnect with the waters of Nun and find your center.',
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
              fontStyle: FontStyle.italic,
            ),
          ),
          if (day.activities != null && day.activities!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('REQUIRED ACTIVITIES', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: 8),
            ...day.activities!.map((a) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 14),
                  const SizedBox(width: 8),
                  Expanded(child: Text(a, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7), fontSize: 13))),
                ],
              ),
            )),
          ],
          if (day.restrictions != null && day.restrictions!.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text('RESTRICTIONS / TABOOS', style: TextStyle(color: Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
            const SizedBox(height: 8),
            ...day.restrictions!.map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  const Icon(Icons.block_rounded, color: Colors.redAccent, size: 14),
                  const SizedBox(width: 8),
                  Expanded(child: Text(r, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7), fontSize: 13))),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildQuickInfo(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary, size: 18),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'The Watered Calendar overlays African deities and spiritual meanings onto the standard Gregorian year.',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
