import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/community/providers/group_providers.dart';
import 'package:Watered/features/community/widgets/group_card.dart';
import 'package:Watered/features/community/models/group.dart';

class GroupsScreen extends ConsumerStatefulWidget {
  const GroupsScreen({super.key});

  @override
  ConsumerState<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends ConsumerState<GroupsScreen> {
  String _searchQuery = '';
  GroupType? _selectedType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final groupsAsync = ref.watch(groupsListProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.refresh(groupsListProvider),
      child: CustomScrollView(
        slivers: [
          // Search and Filter
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search groups...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: theme.cardTheme.color,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Filter Chips
                  Row(
                    children: [
                      FilterChip(
                        label: const Text('All'),
                        selected: _selectedType == null,
                        onSelected: (selected) {
                          setState(() {
                            _selectedType = null;
                          });
                        },
                        selectedColor: theme.colorScheme.primary.withOpacity(0.2),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Countries'),
                        selected: _selectedType == GroupType.country,
                        onSelected: (selected) {
                          setState(() {
                            _selectedType = selected ? GroupType.country : null;
                          });
                        },
                        selectedColor: Colors.blue.withOpacity(0.2),
                      ),
                      const SizedBox(width: 8),
                      FilterChip(
                        label: const Text('Tribes'),
                        selected: _selectedType == GroupType.tribe,
                        onSelected: (selected) {
                          setState(() {
                            _selectedType = selected ? GroupType.tribe : null;
                          });
                        },
                        selectedColor: Colors.purple.withOpacity(0.2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Groups List
          groupsAsync.when(
            data: (groups) {
              // Filter groups
              var filteredGroups = groups.where((group) {
                final matchesSearch = group.name.toLowerCase().contains(_searchQuery) ||
                    (group.description?.toLowerCase().contains(_searchQuery) ?? false);
                final matchesType = _selectedType == null || group.type == _selectedType;
                return matchesSearch && matchesType;
              }).toList();

              // Separate joined and available groups
              final joinedGroups = filteredGroups.where((g) => g.isJoined).toList();
              final availableGroups = filteredGroups.where((g) => !g.isJoined).toList();

              if (filteredGroups.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'No groups found',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodyLarge?.color?.withOpacity(0.5),
                      ),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildListDelegate([
                  // Joined Groups Section
                  if (joinedGroups.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: Text(
                        'MY GROUPS (${joinedGroups.length})',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    ...joinedGroups.map((group) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GroupCard(group: group),
                        )),
                    const SizedBox(height: 24),
                  ],

                  // Available Groups Section
                  if (availableGroups.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      child: Text(
                        'DISCOVER GROUPS (${availableGroups.length})',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    ...availableGroups.map((group) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GroupCard(group: group),
                        )),
                  ],
                  const SizedBox(height: 80), // Bottom padding
                ]),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => SliverFillRemaining(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.grey, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load groups',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => ref.refresh(groupsListProvider),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
