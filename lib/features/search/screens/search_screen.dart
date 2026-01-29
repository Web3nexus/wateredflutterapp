import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/search/services/search_service.dart';
import 'package:Watered/features/search/models/daily_wisdom.dart';
import 'package:Watered/features/search/models/search_result.dart';
// Assuming this exists or generic player
import 'package:Watered/features/commerce/screens/product_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';

final dailyWisdomProvider = FutureProvider.autoDispose<DailyWisdom?>((
  ref,
) async {
  return ref.read(searchServiceProvider).getDailyWisdom();
});

final searchResultsProvider = FutureProvider.autoDispose
    .family<SearchResult, String>((ref, query) async {
      return ref.read(searchServiceProvider).search(query);
    });

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _query = query;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final wisdomAsync = ref.watch(dailyWisdomProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search wisdom, products, videos...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
          ),
          autofocus: true,
        ),
        backgroundColor: const Color(0xFF0F172A),
      ),
      body: _query.isEmpty
          ? _buildDailyWisdom(wisdomAsync)
          : _buildSearchResults(),
    );
  }

  Widget _buildDailyWisdom(AsyncValue<DailyWisdom?> wisdomAsync) {
    return wisdomAsync.when(
      data: (wisdom) {
        if (wisdom == null) return const SizedBox.shrink();
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: wisdom.backgroundImageUrl != null
              ? BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      wisdom.backgroundImageUrl!,
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.7),
                      BlendMode.darken,
                    ),
                  ),
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'DAILY WISDOM',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '"${wisdom.quote}"',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Cinzel',
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                if (wisdom.author != null)
                  Text(
                    '- ${wisdom.author}',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildSearchResults() {
    final resultsAsync = ref.watch(searchResultsProvider(_query));

    return resultsAsync.when(
      data: (results) {
        if (results.videos.isEmpty &&
            results.products.isEmpty &&
            results.temples.isEmpty) {
          return const Center(
            child: Text(
              'No results found.',
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (results.videos.isNotEmpty) ...[
              const _SectionHeader(title: 'VIDEOS'),
              ...results.videos.map(
                (v) => ListTile(
                  title: Text(
                    v.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  leading: const Icon(
                    Icons.play_circle_outline,
                    color: Colors.white54,
                  ),
                  onTap: () {
                    // Nav to player
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (results.products.isNotEmpty) ...[
              const _SectionHeader(title: 'SACRED OBJECTS'),
              ...results.products.map(
                (p) => ListTile(
                  title: Text(
                    p.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: Text(
                    '\$${(p.price / 100).toStringAsFixed(0)}',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  leading: p.imageUrl != null
                      ? CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            p.imageUrl!,
                          ),
                        )
                      : const Icon(Icons.diamond_outlined),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: p),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (results.temples.isNotEmpty) ...[
              const _SectionHeader(title: 'TEMPLES'),
              ...results.temples.map(
                (t) => ListTile(
                  title: Text(
                    t.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: t.address != null
                      ? Text(
                          t.address!,
                          style: const TextStyle(color: Colors.white38),
                        )
                      : null,
                  leading: const Icon(
                    Icons.place_outlined,
                    color: Colors.white54,
                  ),
                ),
              ),
            ],
          ],
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary),
      ),
      error: (err, _) => Center(
        child: Text(
          'Error searching: $err',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
