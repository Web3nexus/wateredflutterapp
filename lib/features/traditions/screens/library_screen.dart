import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/theme/theme_provider.dart';
import 'package:Watered/features/library/providers/library_providers.dart';
import 'package:Watered/features/home/providers/featured_content_provider.dart';
import 'package:Watered/features/audio/models/audio.dart';
import 'package:Watered/features/audio/screens/audio_feed_screen.dart'; // For navigation?
// We need specific detail screens or players. 
// For now, I'll use placeholders or existing navigations if possible.
// Provide generic navigation or TODOs.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Watered/core/widgets/notification_bell.dart';
import 'package:Watered/features/subscription/screens/subscription_screen.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/traditions/providers/tradition_provider.dart';
import 'package:Watered/features/traditions/screens/tradition_detail_screen.dart';
import 'package:Watered/features/deities/screens/deities_screen.dart';
import 'package:Watered/features/activity/widgets/activity_tracker.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ActivityTracker(
      pageName: 'Deities',
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Deities', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.textTheme.headlineSmall?.color)),
          backgroundColor: Colors.transparent,
          centerTitle: false,
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: theme.colorScheme.primary),
              onPressed: () {
                // TODO: Implement search navigation
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: RefreshIndicator(
          color: theme.colorScheme.primary,
          onRefresh: () async {
            ref.invalidate(traditionListProvider());
            ref.invalidate(libraryProvider);
          },
          child: _LibraryTabContent(filter: 'all'),
        ),
      ),
    );
  }
}

class _LibraryTabContent extends ConsumerWidget {
  final String filter; // 'all', 'audio'

  const _LibraryTabContent({required this.filter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryState = ref.watch(libraryProvider);
    final theme = Theme.of(context);

    // Filter content
    List<dynamic> content = [];
    if (filter == 'all') {
      content = libraryState.allContent;
    } else if (filter == 'audio') {
      content = libraryState.audios;
    }

    return CustomScrollView(
      slivers: [
        if (filter == 'all') ...[
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            // Featured THE GODS Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const DeitiesScreen()),
                    );
                  },
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.secondary,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -20,
                          bottom: -20,
                          child: Icon(
                            Icons.temple_hindu_rounded,
                            size: 150,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Text(
                                  'FEATURED',
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'DEITIES',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  fontFamily: 'Cinzel',
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Explore the stories and images of the divine.',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('SPIRITUAL PATHS', style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5), 
                  fontWeight: FontWeight.bold, 
                  letterSpacing: 1.0
                )),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            // The Traditions Section
            SliverToBoxAdapter(
              child: ref.watch(traditionListProvider()).when(
                data: (traditions) {
                   // Exclude Nima Sedani and maybe Yoruba/Kemet if they are "wrong"
                   // But user said "I noticed two path which is Hemet and Yoruba whihc is worng"
                   // Maybe I should filter them out for now.
                    final filteredTraditions = traditions.data.where((t) {
                      return t.name.toLowerCase() != 'nima sedani';
                    }).toList();
                    
                    // Prioritize "Watered" (formerly Four Witness) to be first
                    filteredTraditions.sort((a, b) {
                      if (a.name.toLowerCase() == 'watered') return -1;
                      if (b.name.toLowerCase() == 'watered') return 1;
                      return 0;
                    });
                  
                  if (filteredTraditions.isEmpty) return const SizedBox.shrink();

                  return SizedBox(
                    height: 320,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: filteredTraditions.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                           final tradition = filteredTraditions[index];
                           
                           return Container(
                             width: 260,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(24),
                               image: tradition.imageUrl != null 
                                   ? DecorationImage(
                                       image: CachedNetworkImageProvider(tradition.imageUrl!),
                                       fit: BoxFit.cover,
                                     )
                                   : null,
                               color: tradition.imageUrl == null ? theme.cardColor : null,
                             ),
                             child: Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(24),
                                 gradient: LinearGradient(
                                   begin: Alignment.topCenter,
                                   end: Alignment.bottomCenter,
                                   colors: [
                                     Colors.black.withOpacity(0.1),
                                     Colors.black.withOpacity(0.8),
                                   ],
                                 ),
                               ),
                               padding: const EdgeInsets.all(24),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Container(
                                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                     decoration: BoxDecoration(
                                       color: Colors.white.withOpacity(0.2),
                                       borderRadius: BorderRadius.circular(100),
                                       border: Border.all(color: Colors.white.withOpacity(0.1)),
                                     ),
                                     child: Text(
                                       'SACRED PATH',
                                       style: TextStyle(color: theme.colorScheme.primary, fontSize: 10, fontWeight: FontWeight.bold),
                                     ),
                                   ),
                                   const SizedBox(height: 16),
                                   Text(
                                     tradition.name,
                                     textAlign: TextAlign.center,
                                     style: const TextStyle(
                                       color: Colors.white, 
                                       fontWeight: FontWeight.bold, 
                                       fontSize: 22, 
                                       fontFamily: 'Cinzel'
                                     ),
                                     maxLines: 2,
                                     overflow: TextOverflow.ellipsis,
                                   ),
                                   const SizedBox(height: 12),
                                   Text(
                                     tradition.description ?? 'Explore the deities and ancient wisdom.',
                                     textAlign: TextAlign.center,
                                     style: TextStyle(
                                       color: Colors.white.withOpacity(0.8), 
                                       fontSize: 13,
                                       height: 1.4
                                     ),
                                     maxLines: 3,
                                     overflow: TextOverflow.ellipsis,
                                   ),
                                   const SizedBox(height: 24),
                                   ElevatedButton(
                                     onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => TraditionDetailScreen(tradition: tradition),
                                          ),
                                        );
                                     },
                                     style: ElevatedButton.styleFrom(
                                       backgroundColor: Colors.white,
                                       foregroundColor: Colors.black,
                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                       elevation: 0,
                                     ),
                                     child: const Text('Enter Path', style: TextStyle(fontWeight: FontWeight.bold)),
                                   ),
                                 ],
                                ),
                             ),
                           );
                      },
                    ),
                  );
                },
                loading: () => const SizedBox(height: 320, child: Center(child: CircularProgressIndicator())),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],

        if (libraryState.isLoading)
          const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}

class _LessonListItem extends StatelessWidget {
  final dynamic item;
  const _LessonListItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String title = '';
    String subtitle = '';
    String? imageUrl;
    IconData icon = Icons.article;
    VoidCallback? onTap;
    
    if (item is Audio) {
      title = item.title;
      subtitle = 'Audio • ${item.duration ?? "Unknown"}';
      imageUrl = item.thumbnailUrl;
      icon = Icons.mic_none_rounded;
      onTap = () {
         // Use Navigation to AudioPlayer
         // TODO: Ensure we have full audio object or fetch it
         Navigator.of(context).push(MaterialPageRoute(builder: (_) => AudioFeedScreen())); // Placeholder
      };
    }

    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(imageUrl ?? 'https://placehold.co/600x400/png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: theme.textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Outfit',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            Container(
               padding: const EdgeInsets.all(8),
               decoration: BoxDecoration(
                 color: theme.colorScheme.primary.withOpacity(0.1),
                 shape: BoxShape.circle,
               ),
               child: Icon(Icons.play_arrow_rounded, color: theme.colorScheme.primary, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
