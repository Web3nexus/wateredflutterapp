import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/library/providers/bookmark_provider.dart';
import 'package:Watered/features/traditions/providers/tradition_provider.dart';
import 'package:Watered/features/traditions/screens/tradition_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Watered/features/audio/screens/audio_player_screen.dart';

class UserLibraryScreen extends ConsumerStatefulWidget {
  const UserLibraryScreen({super.key});

  @override
  ConsumerState<UserLibraryScreen> createState() => _UserLibraryScreenState();
}

class _UserLibraryScreenState extends ConsumerState<UserLibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Deep Dark Blue
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Collection',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headlineMedium?.color,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Custom Tab Bar (Pills)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                indicator: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary, // Gold
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
                  ],
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Audio'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                   const _BookmarkList(type: null), // All
                   const _BookmarkList(type: 'audio'), // Audio Only
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AllTab extends StatelessWidget {
  const _AllTab();
  @override 
  Widget build(BuildContext context) => const SizedBox.shrink(); // Deprecated
}

// Unused classes removed

class _BookmarkList extends ConsumerWidget {
  final String? type;
  const _BookmarkList({this.type});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookmarkListProvider);

    return state.when(
      data: (bookmarks) {
        if (bookmarks.isEmpty) {
           return const _EmptyBookmarks();
        }

        final filtered = type == null 
            ? bookmarks 
            : bookmarks.where((b) {
                final bType = b.bookmarkableType.toLowerCase();
                if (type == 'audio') return bType.contains('audio') || bType.contains('song');
                if (type == 'text') return bType.contains('text') || bType.contains('chapter');
                return bType.contains(type!);
              }).toList();

        if (filtered.isEmpty) {
          return const _EmptyBookmarks();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final bookmark = filtered[index];
            final data = bookmark.bookmarkable ?? {};
            final title = data['title'] ?? 'Unknown Item';
            final imageUrl = data['thumbnail_url'] ?? data['image_url'];
            
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(Theme.of(context).brightness == Brightness.dark ? 0.3 : 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    image: imageUrl != null 
                        ? DecorationImage(image: CachedNetworkImageProvider(imageUrl), fit: BoxFit.cover) 
                        : null,
                  ),
                  child: imageUrl == null 
                      ? Icon(_getIconForType(bookmark.bookmarkableType), color: Theme.of(context).colorScheme.primary) 
                      : null,
                ),
                title: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  bookmark.bookmarkableType.split('\\').last.toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.2)),
                onTap: () {
                   // Navigate based on type
                   final bType = bookmark.bookmarkableType.toLowerCase();
                   if (bType.contains('audio')) {
                      // Navigate to audio player
                      // Audio navigation logic here
                   }
                },
              ),
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary)),
      error: (err, stack) => Center(child: Text('Error loading collection: $err', style: const TextStyle(color: Colors.red))),
    );
  }

  IconData _getIconForType(String type) {
    if (type.toLowerCase().contains('audio')) return Icons.mic_none_rounded;
    return Icons.menu_book_rounded;
  }
}

class _EmptyBookmarks extends StatelessWidget {
  const _EmptyBookmarks();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border_rounded, size: 64, color: Colors.blueGrey.shade700),
          const SizedBox(height: 16),
          const Text('No saved items found.', style: TextStyle(color: Colors.blueGrey)),
        ],
      ),
    );
  }
}
