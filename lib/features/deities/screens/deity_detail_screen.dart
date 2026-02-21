import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/deities/models/deity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DeityDetailScreen extends ConsumerWidget {
  final Deity deity;

  const DeityDetailScreen({super.key, required this.deity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                deity.name,
                style: const TextStyle(
                  fontFamily: 'Cinzel',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFF7D6), // Golden White
                  shadows: [Shadow(color: Colors.black, blurRadius: 10)],
                ),
              ),
              centerTitle: true,
              background: deity.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: deity.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            theme.colorScheme.primary.withOpacity(0.7),
                            theme.colorScheme.primary.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Origin Badge
                  if (deity.origin != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: theme.colorScheme.primary.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.public_rounded,
                            size: 16,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Origin: ${deity.origin!}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Description
                  if (deity.description != null) ...[
                    _SectionTitle(title: 'About', theme: theme),
                    const SizedBox(height: 12),
                    Text(
                      deity.description!,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.8,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Mythology Story
                  if (deity.mythologyStory != null) ...[
                    _SectionTitle(title: 'Mythology', theme: theme),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: theme.colorScheme.primary.withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        deity.mythologyStory!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.8,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Domains
                  if (deity.domains != null) ...[
                    _SectionTitle(title: 'Domains', theme: theme),
                    const SizedBox(height: 12),
                    _InfoCard(
                      icon: Icons.category_rounded,
                      content: deity.domains!,
                      theme: theme,
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Symbols
                  if (deity.symbols != null) ...[
                    _SectionTitle(title: 'Sacred Symbols', theme: theme),
                    const SizedBox(height: 12),
                    _InfoCard(
                      icon: Icons.auto_awesome_rounded,
                      content: deity.symbols!,
                      theme: theme,
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Sacred Elements
                  if (deity.sacredElements != null) ...[
                    _SectionTitle(title: 'Sacred Elements', theme: theme),
                    const SizedBox(height: 12),
                    _InfoCard(
                      icon: Icons.water_drop_rounded,
                      content: deity.sacredElements!,
                      theme: theme,
                    ),
                    const SizedBox(height: 24),
                  ],

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final ThemeData theme;

  const _SectionTitle({required this.title, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cinzel',
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String content;
  final ThemeData theme;

  const _InfoCard({
    required this.icon,
    required this.content,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              content,
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.6,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
