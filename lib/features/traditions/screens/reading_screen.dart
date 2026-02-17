import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/traditions/models/chapter.dart';
import 'package:Watered/features/traditions/models/text_collection.dart';
import 'package:Watered/features/traditions/models/entry.dart';
import 'package:Watered/features/traditions/providers/entry_provider.dart';

class ReadingScreen extends ConsumerStatefulWidget {
  final Chapter chapter;
  final TextCollection collection;
  final int? initialVerse;

  const ReadingScreen({
    super.key,
    required this.chapter,
    required this.collection,
    this.initialVerse,
  });

  @override
  ConsumerState<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends ConsumerState<ReadingScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolled = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToVerse() {
    if (_hasScrolled || widget.initialVerse == null) return;
    
    // Simple estimation: assume each verse is approx 100px. 
    // Ideally we'd use scrollable_positioned_list but avoiding new deps for now.
    // Or we can wait for frame and find render object.
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
       if (mounted && _scrollController.hasClients) {
          // Calculate approximate target. Each verse is roughly 120-150px.
          final target = (widget.initialVerse! - 1) * 120.0; 
          _scrollController.animateTo(
            target.clamp(0.0, _scrollController.position.maxScrollExtent), 
            duration: const Duration(milliseconds: 800), 
            curve: Curves.fastOutSlowIn,
          );
          _hasScrolled = true;
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    final entriesState = ref.watch(entryListProvider(chapterId: widget.chapter.id));

    // Try to scroll when data is loaded
    ref.listen(entryListProvider(chapterId: widget.chapter.id), (previous, next) {
        if (next is AsyncData && !_hasScrolled && widget.initialVerse != null) {
            _scrollToVerse();
        }
    });

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              widget.collection.name.toUpperCase(),
              style: TextStyle(fontSize: 10, letterSpacing: 2, color: Theme.of(context).colorScheme.primary),
            ),
            Text(
              'CHAPTER ${widget.chapter.order}',
              style: const TextStyle(fontFamily: 'Cinzel', fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded),
            onPressed: () {
              // TODO: Implement Bookmark
            },
          ),
          IconButton(
            icon: const Icon(Icons.ios_share_rounded, size: 20),
            onPressed: () {
              // TODO: Implement Share
            },
          ),
        ],
      ),
      body: entriesState.when(
        data: (entries) {
          if (entries.data.isEmpty) return const _EmptyReading();
          
          // Trigger scroll if first load
          if (!_hasScrolled && widget.initialVerse != null) {
              _scrollToVerse();
          }

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
            physics: const BouncingScrollPhysics(),
            itemCount: entries.data.length + 1, // +1 for Header
            itemBuilder: (context, index) {
              if (index == 0) {
                final collectionName = widget.collection.name.isNotEmpty 
                    ? widget.collection.name.toUpperCase() 
                    : "SACRED TEXT";
                final chapterTitle = widget.chapter.name.isNotEmpty 
                    ? widget.chapter.name 
                    : "Chapter ${widget.chapter.order}";

                return Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        collectionName,
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        chapterTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headlineMedium?.color,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 40, 
                        height: 4, 
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                );
              }

              final entry = entries.data[index - 1];
              final isTarget = widget.initialVerse != null && entry.order == widget.initialVerse;
              
              return Container(
                margin: const EdgeInsets.only(bottom: 24),
                decoration: isTarget 
                    ? BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      )
                    : null,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                        '${entry.order}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary, // Gold verse number
                          fontFeatures: [FontFeature.superscripts()], 
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: HtmlWidget(
                          entry.text,
                          textStyle: TextStyle(
                            fontSize: 19,
                            height: 1.8,
                            letterSpacing: 0.3,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                            fontFamily: 'Outfit',
                          ),
                          onTapUrl: (url) async {
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            }
                            return true;
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _EmptyReading extends StatelessWidget {
  const _EmptyReading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This chapter appears to be empty or yet to be transcribed.',      style: TextStyle(color: Colors.blueGrey)),
    );
  }
}
