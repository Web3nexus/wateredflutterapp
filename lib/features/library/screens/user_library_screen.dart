import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/features/library/providers/bookmark_provider.dart';
import 'package:wateredflutterapp/features/library/models/bookmark.dart';
import 'package:shimmer/shimmer.dart';

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
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('MY COLLECTION'),
        backgroundColor: const Color(0xFF0F172A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFFD4AF37)),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFFD4AF37),
          unselectedLabelColor: Colors.white54,
          indicatorColor: const Color(0xFFD4AF37),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'ALL'),
            Tab(text: 'VIDEO'),
            Tab(text: 'AUDIO'),
            Tab(text: 'TEXT'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _BookmarkList(type: null), // All
          _BookmarkList(type: 'video'),
          _BookmarkList(type: 'audio'),
          _BookmarkList(type: 'text'), 
        ],
      ),
    );
  }
}

class _BookmarkList extends ConsumerWidget {
  final String? type; // 'video', 'audio', 'text' or null (for all)
  
  const _BookmarkList({this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bookmarkListProvider);

    return state.when(
      data: (bookmarks) {
        // Filter based on type simple string match for now
        // Assuming backend returns type like 'App\Models\Video'
        final filtered = type == null 
            ? bookmarks 
            : bookmarks.where((b) => b.bookmarkableType.toLowerCase().contains(type!)).toList();

        if (filtered.isEmpty) {
          return const _EmptyBookmarks();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            return _BookmarkCard(bookmark: filtered[index]);
          },
        );
      },
      loading: () => const _LoadingBookmarks(),
      error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
    );
  }
}

class _BookmarkCard extends StatelessWidget {
  final Bookmark bookmark;
  const _BookmarkCard({required this.bookmark});

  @override
  Widget build(BuildContext context) {
    // Extract data from 'bookmarkable' map if waiting for backend
    // Or just use generic placeholder data
    final data = bookmark.bookmarkable ?? {};
    final title = data['title'] ?? 'Unknown Title';
    final subtitle = bookmark.bookmarkableType.split('\\').last.toUpperCase();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getIconForType(bookmark.bookmarkableType),
            color: const Color(0xFFD4AF37),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white24),
        onTap: () {
          // TODO: Navigate to detail based on type
        },
      ),
    );
  }

  IconData _getIconForType(String type) {
    if (type.toLowerCase().contains('video')) return Icons.play_arrow_rounded;
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
          const Text('No saved items yet.', style: TextStyle(color: Colors.blueGrey)),
        ],
      ),
    );
  }
}

class _LoadingBookmarks extends StatelessWidget {
  const _LoadingBookmarks();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Colors.white10,
        highlightColor: Colors.white.withOpacity(0.05),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
