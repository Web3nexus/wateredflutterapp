import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/traditions/providers/text_collection_provider.dart';
import 'package:Watered/features/traditions/providers/chapter_provider.dart';
import 'package:Watered/features/traditions/providers/entry_provider.dart';
import 'package:Watered/features/traditions/models/chapter.dart';
import 'package:Watered/features/traditions/models/text_collection.dart';
import 'package:Watered/features/activity/widgets/activity_tracker.dart';
import 'package:Watered/core/widgets/error_view.dart';
import 'package:Watered/core/widgets/loading_view.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class NimaSedaniScreen extends ConsumerStatefulWidget {
  const NimaSedaniScreen({super.key});

  @override
  ConsumerState<NimaSedaniScreen> createState() => _NimaSedaniScreenState();
}

class _NimaSedaniScreenState extends ConsumerState<NimaSedaniScreen> {
  final ScrollController _scrollController = ScrollController();
  Chapter? _currentChapter;
  TextCollection? _currentCollection;

  void _showChapterSelector(BuildContext context, List<Chapter> chapters) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          final theme = Theme.of(context);
          return Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'SELECT CHAPTER',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemCount: chapters.length,
                    itemBuilder: (context, index) {
                      final chapter = chapters[index];
                      final isSelected = _currentChapter?.id == chapter.id;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _currentChapter = chapter;
                          });
                          Navigator.pop(context);
                          // Scroll to top when changing chapters
                          if (_scrollController.hasClients) {
                            _scrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.cardTheme.color,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : Colors.white.withOpacity(0.05),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${chapter.order}',
                              style: TextStyle(
                                fontFamily: 'Cinzel',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final booksAsync = ref.watch(textCollectionListProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'NIMA SEDANI',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 2,
                color: theme.colorScheme.primary,
              ),
            ),
            if (_currentChapter != null)
              Text(
                'CHAPTER ${_currentChapter!.order}',
                style: const TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        centerTitle: true,
        actions: [
          if (_currentCollection != null)
            Consumer(
              builder: (context, ref, _) {
                final chaptersAsync = ref.watch(
                  chapterListProvider(collectionId: _currentCollection!.id),
                );
                return chaptersAsync.when(
                  data: (chapters) => IconButton(
                    icon: const Icon(Icons.list_rounded),
                    tooltip: 'Chapters',
                    onPressed: () => _showChapterSelector(context, chapters.data),
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                );
              },
            ),
          IconButton(
            icon: const Icon(Icons.bookmark_border_rounded),
            onPressed: () {
              // TODO: Implement Bookmark
            },
          ),
        ],
      ),
      body: ActivityTracker(
        pageName: 'nima_sedani',
        child: booksAsync.when(
        data: (books) {
          if (books.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_stories_rounded,
                    size: 64,
                    color: theme.colorScheme.primary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'The Nima Sedani is being prepared...',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.textTheme.bodyLarge?.color?.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            );
          }

          // Auto-select first book if not set
          if (_currentCollection == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _currentCollection = books.first;
              });
            });
            return const LoadingView();
          }

          // Load chapters for the current collection
          return Consumer(
            builder: (context, ref, _) {
              final chaptersAsync = ref.watch(
                chapterListProvider(collectionId: _currentCollection!.id),
              );

              return chaptersAsync.when(
                data: (chapters) {
                  if (chapters.data.isEmpty) {
                    return const Center(
                      child: Text('No chapters available.'),
                    );
                  }

                  // Auto-select first chapter if not set
                  if (_currentChapter == null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _currentChapter = chapters.data.first;
                      });
                    });
                    return const LoadingView();
                  }

                  // Load entries for current chapter
                  return Consumer(
                    builder: (context, ref, _) {
                      final entriesAsync = ref.watch(
                        entryListProvider(chapterId: _currentChapter!.id),
                      );

                      return entriesAsync.when(
                        data: (entries) {
                          if (entries.data.isEmpty) {
                            return const Center(
                              child: Text(
                                'This chapter appears to be empty or yet to be transcribed.',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            );
                          }

                          return ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                            physics: const BouncingScrollPhysics(),
                            itemCount: entries.data.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 24, bottom: 40),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Nima Sedani Icon
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              theme.colorScheme.primary.withOpacity(0.2),
                                              theme.colorScheme.primary.withOpacity(0.05),
                                            ],
                                          ),
                                        ),
                                        child: Image.asset(
                                          'assets/images/sacred_book_icon.png',
                                          height: 60,
                                          width: 60,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                        'Chapter ${_currentChapter!.order}${_currentChapter!.name.isNotEmpty ? ": ${_currentChapter!.name}" : ""}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Cinzel',
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: theme.textTheme.headlineMedium?.color,
                                          height: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Container(
                                        width: 40,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              final entry = entries.data[index - 1];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 24),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${entry.order}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                        fontFeatures: const [FontFeature.superscripts()],
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
                                          color: theme.textTheme.bodyMedium?.color,
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
                        loading: () => const LoadingView(),
                        error: (error, stack) => ErrorView(
                          error: error,
                          stackTrace: stack,
                          onRetry: () => ref.invalidate(entryListProvider),
                        ),
                      );
                    },
                  );
                },
                loading: () => const LoadingView(),
                error: (error, stack) => ErrorView(
                  error: error,
                  stackTrace: stack,
                  onRetry: () => ref.invalidate(chapterListProvider),
                ),
              );
            },
          );
        },
        loading: () => const LoadingView(),
        error: (error, stack) => ErrorView(
          error: error,
          stackTrace: stack,
          onRetry: () => ref.invalidate(textCollectionListProvider),
        ),
      ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
