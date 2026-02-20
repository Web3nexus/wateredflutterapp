import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/deities/providers/deity_providers.dart';
import 'package:Watered/features/deities/screens/deity_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Watered/core/widgets/premium_gate.dart';
import 'package:Watered/features/activity/widgets/activity_tracker.dart';

class DeitiesScreen extends ConsumerStatefulWidget {
  const DeitiesScreen({super.key});

  @override
  ConsumerState<DeitiesScreen> createState() => _DeitiesScreenState();
}

class _DeitiesScreenState extends ConsumerState<DeitiesScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(deitiesListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final traditionsAsync = ref.watch(traditionsListProvider);
    final deitiesAsync = ref.watch(deitiesListProvider);
    final selectedTradition = ref.watch(selectedTraditionProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Deities'),
      ),
      body: ActivityTracker(
        pageName: 'deities',
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  ref.read(deitySearchQueryProvider.notifier).state = value;
                },
                decoration: InputDecoration(
                  hintText: 'Search deities...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty 
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(deitySearchQueryProvider.notifier).state = '';
                        },
                      )
                    : null,
                  filled: true,
                  fillColor: theme.cardTheme.color,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
            
            // Filter List
            SizedBox(
              height: 60,
              child: traditionsAsync.when(
                data: (traditions) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: traditions.length + 1, // +1 for "All"
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final isAll = index == 0;
                      final tradition = isAll ? null : traditions[index - 1];
                      final isSelected = isAll ? selectedTradition == null : selectedTradition == tradition?.id;

                      return Center(
                        child: FilterChip(
                          label: Text(isAll ? 'All' : tradition!.name),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            if (selected) {
                               ref.read(selectedTraditionProvider.notifier).state = tradition?.id;
                            }
                          },
                          backgroundColor: theme.cardTheme.color,
                          selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                          labelStyle: TextStyle(
                            color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          checkmarkColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                              )
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(strokeWidth: 2),
                )),
                error: (e, s) => Center(child: Text('Error: $e', style: const TextStyle(fontSize: 10, color: Colors.red))),
              ),
            ),
            
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.invalidate(traditionsListProvider);
                  ref.invalidate(deitiesListProvider);
                },
                child: deitiesAsync.when(
                  data: (paginated) {
                    if (paginated.items.isEmpty) {
                      return Center(
                        child: Text(
                          'No spirits found.',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.textTheme.bodyLarge?.color?.withOpacity(0.5),
                          ),
                        ),
                      );
                    }
                    return CustomScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        // Featured Deities Section
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/deities_bg.jpg'),
                                  fit: BoxFit.cover,
                                  opacity: 0.3,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    theme.colorScheme.primary.withOpacity(0.8),
                                    theme.colorScheme.secondary.withOpacity(0.6),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.primary.withOpacity(0.2),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    right: -10,
                                    bottom: -10,
                                    child: Icon(
                                      Icons.auto_awesome_rounded,
                                      size: 100,
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'THE DIVINE',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                            fontFamily: 'Cinzel',
                                            letterSpacing: 2,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Discover the holy echoes of the ancients.',
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
                        SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final deity = paginated.items[index];
                                return _DeityCard(deity: deity);
                              },
                              childCount: paginated.items.length,
                            ),
                          ),
                        ),
                        if (paginated.isLoadingMore)
                          const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          ),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => Center(child: Text('Error: $error')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeityCard extends StatelessWidget {
  final dynamic deity;
  const _DeityCard({required this.deity});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DeityDetailScreen(deity: deity),
            ),
          );
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          image: const DecorationImage(
            image: AssetImage('assets/images/deities_bg.jpg'),
            fit: BoxFit.cover,
            opacity: 0.15, // Subtle background
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: deity.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: deity.imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : Container(color: theme.colorScheme.primary.withOpacity(0.1)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.0),
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    deity.name,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cinzel',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

