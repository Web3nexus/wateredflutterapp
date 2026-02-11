import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/deities/providers/deity_providers.dart';
import 'package:Watered/features/deities/screens/deity_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Watered/features/activity/widgets/activity_tracker.dart';

class DeitiesScreen extends ConsumerWidget {
  const DeitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final traditionsAsync = ref.watch(traditionsListProvider);
    final deitiesAsync = ref.watch(deitiesListProvider);
    final selectedTradition = ref.watch(selectedTraditionProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('The Gods'),
      ),
      body: ActivityTracker(
        pageName: 'gods',
        child: Column(
        children: [
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => const SizedBox(),
            ),
          ),
          
          Expanded(
            child: deitiesAsync.when(
              data: (deities) {
                if (deities.isEmpty) {
                  return Center(
                    child: Text(
                      'No spirits found.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                         color: theme.textTheme.bodyLarge?.color?.withOpacity(0.5),
                      ),
                    ),
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: deities.length,
                  itemBuilder: (context, index) {
                    final deity = deities[index];
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    deity.name,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Cinzel',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
```
