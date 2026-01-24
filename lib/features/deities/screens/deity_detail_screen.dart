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
                      shadows: [Shadow(color: Colors.black, blurRadius: 10)]
                  ),
              ),
              centerTitle: true,
              background: deity.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: deity.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Container(color: theme.colorScheme.surface),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    deity.description ?? 'No description available.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.8,
                      fontSize: 16,
                    ),
                  ),
                  
                  // Future section: Related Traditions/Texts
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
