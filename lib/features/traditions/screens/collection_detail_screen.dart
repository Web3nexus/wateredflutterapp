import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/traditions/models/text_collection.dart';
import 'package:Watered/features/traditions/models/chapter.dart';
import 'package:Watered/features/traditions/providers/chapter_provider.dart';
import 'package:Watered/features/traditions/screens/reading_screen.dart';
import 'package:Watered/core/widgets/error_view.dart';
import 'package:Watered/core/widgets/loading_view.dart';

class CollectionDetailScreen extends ConsumerStatefulWidget {
  final TextCollection collection;
  const CollectionDetailScreen({super.key, required this.collection});

  @override
  ConsumerState<CollectionDetailScreen> createState() => _CollectionDetailScreenState();
}

class _CollectionDetailScreenState extends ConsumerState<CollectionDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  void _onSearch(String query) {
    // Check for "Jump" command (e.g. 5:12)
    if (query.contains(':')) {
       final parts = query.split(':');
       if (parts.length == 2) {
         final chapSearch = int.tryParse(parts[0]);
         final verseSearch = int.tryParse(parts[1]);
         
         if (chapSearch != null && verseSearch != null) {
            _handleQuickJump(chapSearch, verseSearch);
            return;
         }
       }
    }
    
    setState(() {
      _searchQuery = query;
    });
  }

  Future<void> _handleQuickJump(int chapterOrder, int verseOrder) async {
     // We need to find the chapter matching this order
     // Since we don't have the full list in state easily without reading the provider,
     // we'll optimistically try to find it in the current provider state.
     
     final chaptersAsync = ref.read(chapterListProvider(collectionId: widget.collection.id));
     
     chaptersAsync.whenData((chapters) {
       final targetChapter = chapters.data.cast<Chapter?>().firstWhere(
         (c) => c?.order == chapterOrder,
         orElse: () => null,
       );

       if (targetChapter != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => ReadingScreen(
                chapter: targetChapter,
                collection: widget.collection,
                initialVerse: verseOrder,
              ),
            ),
          );
       } else {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Chapter $chapterOrder not found.')),
         );
       }
     });
  }

  @override
  Widget build(BuildContext context) {
    final chaptersState = ref.watch(chapterListProvider(collectionId: widget.collection.id));
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: _searchQuery.isEmpty 
          ? Text(widget.collection.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold))
          : TextField(
              controller: _searchController,
              onChanged: _onSearch,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Search Chapter or Jump (e.g. 5:12)',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(_searchQuery.isEmpty ? Icons.search : Icons.close),
            onPressed: () {
              setState(() {
                if (_searchQuery.isNotEmpty) {
                  _searchQuery = '';
                  _searchController.clear();
                } else {
                  _searchQuery = ' '; // Trigger search mode UI (hacky but works for toggle)
                  _searchController.clear();
                }
              });
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
          ),
        ),
      ),
      body: Container(
        color: theme.scaffoldBackgroundColor,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 120)),

            // Collection Header (Hide in search mode to focus on results)
            if (_searchQuery.trim().isEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.collection.name.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Cinzel',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.collection.description ??
                          'Study the sacred chapters of this collection.',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Divider(color: Colors.white10),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Chapters Grid/List
            chaptersState.when(
              data: (chapters) {
                // Filter Logic
                final filtered = _searchQuery.trim().isNotEmpty && !_searchQuery.contains(':')
                    ? chapters.data.where((c) => c.order.toString().contains(_searchQuery.trim()) || c.name.toLowerCase().contains(_searchQuery.trim().toLowerCase())).toList()
                    : chapters.data;
                
                if (filtered.isEmpty) {
                   return const SliverToBoxAdapter(child: _EmptyChapters());
                }

                return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 3,
                               mainAxisSpacing: 16,
                               crossAxisSpacing: 16,
                               childAspectRatio: 1,
                             ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final chapter = filtered[index];
                          return _ChapterGridItem(
                            chapter: chapter,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => ReadingScreen(
                                      chapter: chapter,
                                      collection: widget.collection,
                                    ),
                                  ),
                                );
                            },
                          );
                        }, childCount: filtered.length),
                      ),
                    );
              },
              loading: () => const SliverFillRemaining(
                child: LoadingView(),
              ),
              error: (error, stack) => SliverFillRemaining(
                child: ErrorView(
                  error: error,
                  stackTrace: stack,
                  onRetry: () => ref.invalidate(chapterListProvider(collectionId: widget.collection.id)),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

class _ChapterGridItem extends StatelessWidget {
  final Chapter chapter;
  final VoidCallback onTap;
  const _ChapterGridItem({required this.chapter, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${chapter.order}',
              style: TextStyle(
                fontFamily: 'Cinzel',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            if (chapter.name.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
                child: Text(
                  chapter.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _EmptyChapters extends StatelessWidget {
  const _EmptyChapters();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(48),
        child: Text(
          'No chapters recorded for this text.',
          style: TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
  }
}
