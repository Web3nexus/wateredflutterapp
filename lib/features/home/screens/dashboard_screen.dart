import 'package:flutter/material.dart';
import 'package:Watered/core/widgets/premium_gate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/theme/theme_provider.dart';
import 'package:Watered/core/widgets/notification_bell.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/search/screens/search_screen.dart'; // Reuse dailyWisdomProvider
import 'package:Watered/features/home/providers/featured_content_provider.dart';
import 'package:Watered/features/home/providers/tab_provider.dart';
import 'package:Watered/features/audio/models/audio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:Watered/features/rituals/screens/rituals_screen.dart';
import 'package:Watered/features/incantations/screens/incantations_screen.dart';
import 'package:Watered/features/events/screens/events_screen.dart';

import 'package:Watered/features/audio/screens/audio_player_screen.dart';
import 'package:Watered/features/calendar/screens/calendar_home_screen.dart';
import 'package:Watered/features/reminders/widgets/upcoming_holiday_widget.dart';
import 'package:Watered/features/rituals/widgets/sacred_schedule_widget.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final wisdomAsync = ref.watch(dailyWisdomProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(dailyWisdomProvider);
            ref.invalidate(featuredContentProvider);
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header / Greeting
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side: Profile pic + Greeting/Name
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigate to Profile tab (Index 4)
                          ref.read(tabIndexProvider.notifier).state = 4;
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: user?.profileImage != null
                              ? CachedNetworkImageProvider(user!.profileImage!)
                              : null,
                          backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                          child: user?.profileImage == null
                              ? Icon(Icons.person, color: theme.colorScheme.primary)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getGreeting(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.name ?? 'Seeker',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Right side: Calendar icon + Notification bell
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.calendar_today_rounded, color: theme.colorScheme.primary),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const CalendarHomeScreen(),
                            ),
                          );
                        },
                      ),
                      const NotificationBell(),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Daily Wisdom Card
              Text(
                'DAILY WISDOM',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              wisdomAsync.when(
                data: (wisdom) {
                  if (wisdom == null) {
                    return Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: theme.cardTheme.color,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Center(child: Text('Wisdom awaits...')));
                  }
                  return Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 180),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary.withOpacity(0.8),
                          Color(0xFF121212), // Standard Dark
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      image: wisdom.backgroundImageUrl != null
                          ? DecorationImage(
                              image: CachedNetworkImageProvider(wisdom.backgroundImageUrl!),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5), // reduced opacity for gradient visibility
                                BlendMode.darken,
                              ),
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.format_quote_rounded, color: Colors.white.withOpacity(0.8), size: 32),
                      const SizedBox(height: 16),
                      Text(
                        wisdom.quote,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Cinzel',
                          height: 1.4,
                        ),
                      ),
                      if (wisdom.author != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          "- ${wisdom.author}",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
                },
                loading: () => Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                ),
                error: (_, __) => const SizedBox.shrink(),
              ),

              const SizedBox(height: 32),

              // Quick Actions
              Text(
                'QUICK ACTIONS',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                   _buildQuickAction(context, 'Rituals', Icons.auto_fix_high_rounded, () {
                     Navigator.of(context).push(MaterialPageRoute(
                       builder: (_) => const RitualsScreen(),
                     ));
                   }),
                   _buildQuickAction(context, 'Incantation', Icons.record_voice_over_rounded, () {
                     Navigator.of(context).push(MaterialPageRoute(
                       builder: (_) => const IncantationsScreen(),
                     ));
                   }),
                   _buildQuickAction(context, 'Consult', Icons.calendar_month_rounded, () {
                      ref.read(tabIndexProvider.notifier).state = 2;
                   }),
                   _buildQuickAction(context, 'Events', Icons.event_rounded, () {
                     Navigator.of(context).push(MaterialPageRoute(
                       builder: (_) => const EventsScreen(),
                     ));
                   }),
                ],
              ),

              // Upcoming Events Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'EVENTS',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const EventsScreen(),
                      ));
                    },
                    child: Text(
                      'SEE ALL',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ref.watch(eventsListProvider(const EventFilter(filter: 'upcoming'))).when(
                data: (events) {
                  if (events.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: events.take(5).map((event) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => EventDetailScreen(event: event),
                              ));
                            },
                            child: _buildFeaturedCard(
                              context, 
                              event.title, 
                              '${DateFormat('MMM d').format(event.startTime)} • ${event.location ?? "Online"}', 
                              event.effectiveImageUrl ?? 'https://Placehold.co/600x400/0077BE/FFFFFF/png?text=Event',
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
                loading: () => const SizedBox(height: 100, child: Center(child: CircularProgressIndicator())),
                error: (e, s) => const SizedBox.shrink(),
              ),

              const SizedBox(height: 32),

              // Upcoming Holidays
              const UpcomingHolidayWidget(),

              const SizedBox(height: 32),

              // Sacred Rituals Reminder Widget
              const SacredScheduleWidget(),

              const SizedBox(height: 32),
              
              // Featured Teachings
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'FEATURED TEACHINGS',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              ref.watch(featuredContentProvider).when(
                data: (content) {
                  final items = content.all;
                  if (items.isEmpty) {
                    return const SizedBox(
                      height: 100,
                      child: Center(child: Text("No featured content yet.")),
                    );
                  }
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: items.map((item) {
                        // Skip null items if any
                        if (item == null) return const SizedBox.shrink();

                        String title = '';
                        String subtitle = '';
                        String? imageUrl;
                        
                        if (item is Audio) {
                          title = item.title;
                          subtitle = 'Audio • ${item.duration ?? "Unknown"}';
                          imageUrl = item.thumbnailUrl;
                        } else {
                           // Handle unknown types or provide defaults to avoid "Type Null" or empty cards
                           return const SizedBox.shrink();
                        }

                        // Ensure imageUrl is not null before passing or handle it in widget
                        final finalImageUrl = imageUrl ?? 'https://Placehold.co/600x400/png?text=No+Image';

                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: InkWell(
                            onTap: () {
                              if (item is Audio) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => AudioPlayerScreen(audio: item),
                                ));
                              }
                            },
                            child: _buildFeaturedCard(context, title, subtitle, finalImageUrl),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
                loading: () => const SizedBox(height: 160, child: Center(child: CircularProgressIndicator())),
                error: (e, s) => const SizedBox(
                  height: 100,
                  child: Center(child: Text("No featured content yet.", style: TextStyle(color: Colors.white54))),
                ),
              ),

              const SizedBox(height: 32),
              
              const SizedBox(height: 100), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildFeaturedCard(BuildContext context, String title, String subtitle, String imageUrl) {
    return Container(
      width: 280,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: 'Cinzel',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.temple_hindu_rounded, color: Colors.white.withOpacity(0.9), size: 16),
                    const SizedBox(width: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: theme.colorScheme.primary, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
