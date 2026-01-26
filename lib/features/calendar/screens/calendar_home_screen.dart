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
      backgroundColor: const Color(0xFF0F172A),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: todayAsync.when(
                data: (data) => _buildTodayContent(context, data),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
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
        backgroundColor: const Color(0xFFD4AF37),
        icon: const Icon(Icons.calendar_month, color: Colors.black),
        label: const Text('FULL CALENDAR', 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: const Color(0xFF0F172A),
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
                    const Color(0xFF0F172A),
                  ],
                ),
              ),
            ),
            const Center(
              child: Opacity(
                opacity: 0.1,
                child: Icon(Icons.wb_sunny_rounded, size: 150, color: Color(0xFFD4AF37)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayContent(BuildContext context, Map<String, dynamic> data) {
    final kemetic = data['kemetic_date'];
    final dayDetails = data['day_details'] != null 
        ? CalendarDay.fromJson(data['day_details']) 
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDateCard(kemetic),
        const SizedBox(height: 24),
        if (dayDetails != null) ...[
          _buildSectionHeader('TODAY\'S REFLECTION'),
          const SizedBox(height: 12),
          _buildReflectionCard(dayDetails),
        ],
        const SizedBox(height: 24),
        _buildSectionHeader('UPCOMING FESTIVALS'),
        // Placeholder for upcoming festivals
        _buildPlaceholderList(),
      ],
    );
  }

  Widget _buildDateCard(Map<String, dynamic> kemetic) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            '${kemetic['month_name']}'.toUpperCase(),
            style: const TextStyle(
              fontSize: 28,
              fontFamily: 'Cinzel',
              color: Color(0xFFD4AF37),
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Day ${kemetic['day_number']}',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
             'Year ${kemetic['year'] ?? ''} • ${kemetic['season'] ?? ''}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.6),
              letterSpacing: 1.5,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(color: Colors.white10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time, size: 14, color: Colors.white.withOpacity(0.4)),
              const SizedBox(width: 8),
              Text(
                'Matches: ${DateFormat('MMMM dd, yyyy').format(DateTime.now())}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReflectionCard(CalendarDay day) {
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
              style: const TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: Color(0xFFD4AF37)
              )
            ),
          const SizedBox(height: 8),
          Text(
            day.content ?? 'Spend today in quiet contemplation of the Divine Cycle. Reconnect with the waters of Nun and find your center.',
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.white.withOpacity(0.8),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Color(0xFFD4AF37),
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildPlaceholderList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(
                color: Colors.white10,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star_border, color: Color(0xFFD4AF37)),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Coming Soon', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                   Text('Festival details being updated...', style: TextStyle(fontSize: 12, color: Colors.white38)),
                ],
              ),
            ),
          ],
        ),
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
            color: const Color(0xFFD4AF37).withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Color(0xFFD4AF37), size: 18),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'The Kemetic calendar consists of 12 months of 30 days, followed by 5 Epagomenal days.',
                  style: TextStyle(fontSize: 11, color: Colors.white54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
