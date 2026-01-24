import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/traditions/models/chapter.dart';
import 'package:Watered/features/traditions/models/text_collection.dart';
import 'package:Watered/features/traditions/models/entry.dart';
import 'package:Watered/features/traditions/providers/entry_provider.dart';

class ReadingScreen extends ConsumerWidget {
  final Chapter chapter;
  final TextCollection collection;

  const ReadingScreen({
    super.key,
    required this.chapter,
    required this.collection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesState = ref.watch(entryListProvider(chapterId: chapter.id));

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              collection.name.toUpperCase(),
              style: const TextStyle(fontSize: 10, letterSpacing: 2, color: Color(0xFFD4AF37)),
            ),
            Text(
              'CHAPTER ${chapter.order}',
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
        data: (entries) => entries.data.isEmpty
            ? const _EmptyReading()
            : ListView.builder(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
                physics: const BouncingScrollPhysics(),
                itemCount: entries.data.length,
                itemBuilder: (context, index) {
                  final entry = entries.data[index];
                  return _EntryItem(entry: entry);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37))),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _EntryItem extends StatelessWidget {
  final Entry entry;
  const _EntryItem({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            margin: const EdgeInsets.only(top: 4),
            child: Text(
              '${entry.order}',
              style: TextStyle(
                fontFamily: 'Cinzel',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFD4AF37).withOpacity(0.6),
              ),
            ),
          ),
          Expanded(
            child: Text(
              entry.text,
              style: const TextStyle(
                fontSize: 18,
                height: 1.8,
                letterSpacing: 0.3,
                color: Color(0xFFF1F5F9),
              ),
            ),
          ),
        ],
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
