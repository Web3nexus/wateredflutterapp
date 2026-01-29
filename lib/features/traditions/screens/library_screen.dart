import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/theme/theme_provider.dart';
import 'package:Watered/features/library/providers/library_providers.dart';
import 'package:Watered/features/home/providers/featured_content_provider.dart';
import 'package:Watered/features/videos/models/video.dart';
import 'package:Watered/features/audio/models/audio.dart';
import 'package:Watered/features/videos/screens/feed_screen.dart'; // For navigation? Or player
import 'package:Watered/features/audio/screens/audio_feed_screen.dart'; // For navigation?
// We need specific detail screens or players. 
// For now, I'll use placeholders or existing navigations if possible.
// Provide generic navigation or TODOs.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Watered/core/widgets/notification_bell.dart';
import 'package:Watered/features/videos/providers/video_feed_providers.dart';
import 'package:Watered/features/subscription/screens/subscription_screen.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/traditions/providers/tradition_provider.dart';
import 'package:Watered/features/traditions/screens/tradition_detail_screen.dart';


class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        ref.read(videoHeaderVisibleProvider.notifier).state = true;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final isHeaderVisible = ref.watch(videoHeaderVisibleProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(isHeaderVisible ? 56 : 0),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isHeaderVisible ? 1.0 : 0.0,
          child: AppBar(
            title: Text('Library', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.textTheme.headlineSmall?.color)),
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
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: isHeaderVisible ? 68 : 0,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.dark ? const Color(0xFF1E293B) : Colors.grey.withOpacity(0.1), 
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.black, // Text on Gold
                        unselectedLabelColor: Colors.grey,
                        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                        tabs: const [
                          Tab(text: 'All'),
                          Tab(text: 'Audio'),
                          Tab(text: 'Video'),
                        ],
                        dividerColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          color: theme.colorScheme.primary,
          onRefresh: () async {
            ref.invalidate(traditionListProvider());
            ref.invalidate(libraryProvider);
          },
          child: TabBarView(
            controller: _tabController,
            children: [
              _LibraryTabContent(filter: 'all'),
              _LibraryTabContent(filter: 'audio'),
              const FeedScreen(showAppBar: false),
            ],
          ),
        ),
      ),
    );
  }
}

class _LibraryTabContent extends ConsumerWidget {
  final String filter; // 'all', 'audio', 'video'

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
    } else if (filter == 'video') {
      content = libraryState.videos;
    }

    return CustomScrollView(
      slivers: [
        if (filter == 'all') ...[
           const SliverToBoxAdapter(child: SizedBox(height: 16)),
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
           // Show Traditions (Spiritual Paths) instead of featured content
           SliverToBoxAdapter(
            child: ref.watch(traditionListProvider()).when(
              data: (traditions) {
                if (traditions.data.isEmpty) return const SizedBox.shrink();
                return SizedBox(
                  height: 320,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: traditions.data.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                         final tradition = traditions.data[index];
                         
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
                                     'SPIRITUAL PATH',
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
                                   tradition.description ?? 'Explore the ancient wisdom within the sacred scrolls.',
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
                                   child: const Text('Open Path', style: TextStyle(fontWeight: FontWeight.bold)),
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
        ],

        const SliverToBoxAdapter(child: SizedBox(height: 32)),
        
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  filter == 'audio' ? 'Audio Teachings' : (filter == 'video' ? 'Video Lessons' : 'Recent Lessons'),
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.textTheme.titleLarge?.color),
                ),
                TextButton(
                  onPressed: () {
                    if (filter == 'audio') {
                       Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AudioFeedScreen()));
                    } else if (filter == 'video') {
                       Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FeedScreen()));
                    }
                  },
                  child: Text('View all', style: TextStyle(color: theme.colorScheme.primary, fontSize: 13)),
                ),
              ],
            ),
          ),
        ),
        
        const SliverToBoxAdapter(child: SizedBox(height: 8)),

        if (libraryState.isLoading)
          const SliverToBoxAdapter(child: Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator())))
        else if (content.isEmpty)
           const SliverToBoxAdapter(child: Center(child: Padding(padding: EdgeInsets.all(20), child: Text("No lessons found.")))),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = content[index];
              return _LessonListItem(item: item);
            },
            childCount: content.length,
          ),
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
    
    if (item is Video) {
      title = item.title;
      subtitle = 'Video • ${item.duration ?? "Unknown"}';
      imageUrl = item.thumbnailUrl;
      icon = Icons.play_circle_outline_rounded;
      onTap = () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => FeedScreen(initialVideoId: item.id)));
      };
    } else if (item is Audio) {
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
