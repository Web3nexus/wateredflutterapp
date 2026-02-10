import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/incantations/providers/incantation_providers.dart';
import 'package:Watered/features/incantations/screens/incantation_detail_screen.dart';
import 'package:Watered/core/widgets/premium_gate.dart';

class IncantationsScreen extends ConsumerStatefulWidget {
  const IncantationsScreen({super.key});

  @override
  ConsumerState<IncantationsScreen> createState() => _IncantationsScreenState();
}

class _IncantationsScreenState extends ConsumerState<IncantationsScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Protection',
    'Love',
    'Prosperity',
    'Healing',
    'Power',
    'Wisdom',
    'Peace'
  ];

  @override
  Widget build(BuildContext context) {
    final incantationsAsync = ref.watch(incantationsListProvider(_selectedCategory == 'All' ? null : _selectedCategory));
    final theme = Theme.of(context);

    return PremiumGate(
      message: 'Access powerful ancient incantations and oral traditions.',
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Incantations'),
        ),
        body: Column(
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
            Expanded(
              child: incantationsAsync.when(
                data: (incantations) {
                  final filteredIncantations = incantations;

                  if (filteredIncantations.isEmpty) {
                    return Center(
                      child: Text(
                        'No incantations available in this category.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.textTheme.bodyLarge?.color?.withOpacity(0.5),
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredIncantations.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final incantation = filteredIncantations[index];
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => IncantationDetailScreen(incantation: incantation),
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
                          child: Icon(Icons.record_voice_over_outlined, color: theme.colorScheme.primary),
                        ),
                        title: Text(
                          incantation.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: incantation.description != null ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            incantation.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                            ),
                          ),
                        ) : null,
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
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
