import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/features/traditions/models/tradition.dart';
import 'package:wateredflutterapp/features/traditions/models/text_collection.dart';
import 'package:wateredflutterapp/features/traditions/providers/collection_provider.dart';
import 'package:wateredflutterapp/features/traditions/screens/collection_detail_screen.dart';

class TraditionDetailScreen extends ConsumerWidget {
  final Tradition tradition;
  const TraditionDetailScreen({super.key, required this.tradition});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionsState = ref.watch(collectionListProvider(traditionId: tradition.id));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(tradition.name.toUpperCase()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header with Image
          SliverToBoxAdapter(
            child: Stack(
              children: [
                if (tradition.imageUrl != null)
                  Image.network(
                    tradition.imageUrl!,
                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                else
                  Container(
                    height: 350,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                      ),
                    ),
                  ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF0F172A).withOpacity(0.4),
                          const Color(0xFF0F172A),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 32,
                  left: 24,
                  right: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tradition.name.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: 'Cinzel',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD4AF37),
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (tradition.description != null)
                        Text(
                          tradition.description!,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 15,
                            height: 1.6,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Collections List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  children: [
                    const Icon(Icons.auto_stories_rounded, size: 20, color: Color(0xFFD4AF37)),
                    const SizedBox(width: 12),
                    Text(
                      'AVAILABLE TEXTS',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        color: const Color(0xFFD4AF37).withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          collectionsState.when(
            data: (collections) => collections.data.isEmpty
                ? const SliverToBoxAdapter(child: _EmptyCollections())
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final collection = collections.data[index];
                          return _CollectionItem(collection: collection);
                        },
                        childCount: collections.data.length,
                      ),
                    ),
                  ),
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37))),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(child: Text('Wisdom delayed: $err')),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _CollectionItem extends StatelessWidget {
  final TextCollection collection;
  const _CollectionItem({required this.collection});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CollectionDetailScreen(collection: collection),
            ),
          );
        },
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: Icon(Icons.book_rounded, color: Color(0xFFD4AF37)),
          ),
        ),
        title: Text(
          collection.name.toUpperCase(),
          style: const TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            collection.description ?? 'Sacred writing available for study.',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 13,
            ),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }
}

class _EmptyCollections extends StatelessWidget {
  const _EmptyCollections();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(Icons.auto_stories_rounded, size: 48, color: Colors.blueGrey.shade700),
            const SizedBox(height: 16),
            const Text(
              'No texts found in this tradition yet.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
