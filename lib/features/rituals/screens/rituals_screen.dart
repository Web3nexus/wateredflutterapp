import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/widgets/premium_gate.dart';
import 'package:Watered/features/activity/widgets/activity_tracker.dart';
import 'package:Watered/features/rituals/providers/ritual_providers.dart';
import 'package:Watered/features/rituals/screens/ritual_detail_screen.dart';
import 'package:Watered/core/widgets/error_view.dart';
import 'package:Watered/core/widgets/loading_view.dart';

class RitualsScreen extends ConsumerStatefulWidget {
  const RitualsScreen({super.key});

  @override
  ConsumerState<RitualsScreen> createState() => _RitualsScreenState();
}

class _RitualsScreenState extends ConsumerState<RitualsScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Cleansing',
    'Wealth',
    'Protection',
    'Healing',
    'Ancestral',
    'Offering'
  ];

  @override
  Widget build(BuildContext context) {
    final ritualsAsync = ref.watch(ritualsListProvider(_selectedCategory == 'All' ? null : _selectedCategory));
    final theme = Theme.of(context);

    return PremiumGate(
      message: 'Unlock sacred rituals and spiritual practices.',
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Rituals'),
        ),
        body: ActivityTracker(
          pageName: 'rituals',
          child: SingleChildScrollView(
            child: Column(
              children: [
            // Category Filter
            SizedBox(
              height: 60,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;
                  return Center(
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      backgroundColor: theme.cardTheme.color,
                      selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                      labelStyle: TextStyle(
                        color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: isSelected ? theme.colorScheme.primary : Colors.transparent),
                      ),
                    ),
                  );
                },
              ),
            ),
            ritualsAsync.when(
              data: (rituals) {
                final filteredRituals = rituals;

                if (filteredRituals.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Text(
                        'No rituals available in this category.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.textTheme.bodyLarge?.color?.withOpacity(0.5),
                        ),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredRituals.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final ritual = filteredRituals[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RitualDetailScreen(ritual: ritual),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      tileColor: theme.cardTheme.color,
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.auto_fix_high, color: theme.colorScheme.primary),
                      ),
                      title: Text(
                        ritual.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: ritual.description != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                ritual.description!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                                ),
                              ),
                            )
                          : null,
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                    );
                  },
                );
              },
              loading: () => const LoadingView(),
              error: (error, stack) => ErrorView(
                error: error,
                stackTrace: stack,
                onRetry: () => ref.invalidate(ritualsListProvider),
              ),
            ),
            const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    ),
  );
}
}
