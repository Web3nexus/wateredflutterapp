import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/theme/theme_provider.dart';
import 'package:Watered/features/deities/screens/deities_screen.dart';
import 'package:Watered/features/traditions/models/tradition.dart';
import 'package:Watered/features/traditions/providers/tradition_provider.dart';
import 'package:Watered/features/traditions/screens/tradition_detail_screen.dart';
import 'package:Watered/features/calendar/screens/calendar_home_screen.dart';
import 'package:Watered/features/subscription/screens/subscription_screen.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/core/widgets/notification_bell.dart';
import 'package:Watered/core/services/ad_service.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final traditionsState = ref.watch(traditionListProvider());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('SACRED LIBRARY'),
        leading: const NotificationBell(),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today_rounded, color: Color(0xFFD4AF37)),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CalendarHomeScreen()),
              );
            },
          ),
          if (!(ref.watch(authProvider).user?.isPremium ?? false))
            TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SubscriptionScreen())),
              child: const Text('GET PLUS+', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          const SizedBox(width: 8),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF0F172A),
                const Color(0xFF0F172A).withOpacity(0),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(traditionListProvider().notifier).refresh(),
        child: Column(
          children: [
            const AdBanner(screenKey: 'library'),
            Expanded(
              child: traditionsState.when(
                data: (traditions) => traditions.data.isEmpty
                    ? const _EmptyLibrary()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 120, 16, 100),
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: traditions.data.length,
                        itemBuilder: (context, index) {
                          final tradition = traditions.data[index];
                          return _TraditionCard(tradition: tradition);
                        },
                      ),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Color(0xFFD4AF37)),
                ),
                error: (err, stack) => _ErrorView(error: err.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TraditionCard extends StatelessWidget {
  final Tradition tradition;
  const _TraditionCard({required this.tradition});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TraditionDetailScreen(tradition: tradition),
              ),
            );
          },
          child: Stack(
            children: [
              // Background Image/Gradient
              if (tradition.imageUrl != null)
                Image.network(
                  tradition.imageUrl!,
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _buildPlaceholder(),
                )
              else
                _buildPlaceholder(),

              // Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Positioned.fill(
                child: Opacity(
                  opacity: 0.05,
                  child: Center(
                    child: Image.asset(
                      'assets/icon/splashicon.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Library Actions Side-by-Side
                      Row(
                        children: [
                          _buildLibraryAction(
                            context,
                            'Spirits',
                            Icons.auto_awesome,
                            () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const DeitiesScreen()),
                              );
                            },
                          ),
                          const SizedBox(width: 12),
                          _buildLibraryAction(context, 'Saved', Icons.bookmark, () {
                            // TODO: Navigate to Bookmarks
                          }),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4AF37).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3)),
                        ),
                        child: const Text(
                          'TRADITION',
                          style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tradition.name.toUpperCase(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                      ),
                      if (tradition.description != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          tradition.description!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Navigation Arrow
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFD4AF37),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.arrow_forward_rounded, color: Colors.black, size: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 240,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E293B), Color(0xFF334155)],
        ),
      ),
      child: Icon(Icons.temple_hindu_rounded, size: 60, color: Colors.white.withOpacity(0.1)),
    );
  }

  Widget _buildLibraryAction(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyLibrary extends StatelessWidget {
  const _EmptyLibrary();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_stories_rounded, size: 64, color: Colors.blueGrey.shade700),
          const SizedBox(height: 16),
          const Text('The library is currently silent.', style: TextStyle(color: Colors.blueGrey)),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String error;
  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 48),
            const SizedBox(height: 16),
            Text(
              'Wisdom paused: $error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}
