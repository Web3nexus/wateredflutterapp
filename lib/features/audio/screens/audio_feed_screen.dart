import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/audio/models/audio.dart';
import 'package:Watered/features/audio/providers/audio_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:Watered/features/audio/services/audio_service.dart';
import 'package:Watered/features/audio/providers/current_audio_provider.dart';
import 'package:Watered/features/audio/widgets/audio_player_bottom_sheet.dart';
import 'package:Watered/core/services/interaction_service.dart';
import 'package:Watered/core/widgets/comment_bottom_sheet.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/auth/screens/login_screen.dart';
import 'package:Watered/core/services/ad_service.dart';
import 'package:Watered/features/subscription/screens/subscription_screen.dart';
import 'package:Watered/features/activity/widgets/activity_tracker.dart';
import 'package:Watered/core/widgets/error_view.dart';
import 'package:Watered/core/widgets/loading_view.dart';

class AudioFeedScreen extends ConsumerStatefulWidget {
  final bool showAppBar;
  const AudioFeedScreen({super.key, this.showAppBar = true});

  @override
  ConsumerState<AudioFeedScreen> createState() => _AudioFeedScreenState();
}

class _AudioFeedScreenState extends ConsumerState<AudioFeedScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(audioCategoriesProvider);
    final audioState = ref.watch(
      audioListProvider(
        category: _selectedCategory == 'All' ? null : _selectedCategory,
      ),
    );
    final isPremium = ref.watch(authProvider).user?.isPremium ?? false;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: widget.showAppBar
          ? AppBar(
              title: const Text('AUDIO TEACHINGS'),
              actions: [
                if (!isPremium)
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SubscriptionScreen(),
                      ),
                    ),
                    child: Text(
                      'GET PLUS+',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
              ],
            )
          : null,
      body: ActivityTracker(
        pageName: 'audio_teachings',
        child: Column(
          children: [
            categoriesAsync.when(
              data: (categories) => SizedBox(
                height: 60,
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected =
                        _selectedCategory == category;

                    return FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    );
                  },
                ),
              ),
              loading: () => const SizedBox(height: 60),
              error: (_, __) => const SizedBox(height: 60),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref
                    .read(audioListProvider(
                            category: _selectedCategory == 'All'
                                ? null
                                : _selectedCategory)
                        .notifier)
                    .refresh(),
                child: audioState.when(
                  data: (audios) => audios.data.isEmpty
                      ? const _EmptyAudioFeed()
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: audios.data.length,
                          itemBuilder: (context, index) {
                            return _AudioCard(
                              audio: audios.data[index],
                            );
                          },
                        ),
                  loading: () => const LoadingView(),
                  error: (error, stack) =>
                      ErrorView(error: error, stackTrace: stack),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AudioCard extends ConsumerWidget {
  final Audio audio;
  const _AudioCard({required this.audio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final audioService = ref.read(audioServiceProvider);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () async {
          try {
            // 0️⃣ Ensure player is ready
            if (!audioService.isReady) {
              await ref.read(audioPlayerProvider.future);
            }

            // 1️⃣ Load audio FIRST
            if (!audioService.isAudioLoaded(audio.id)) {
              await audioService.loadAudio(audio);
            }

            // 2️⃣ Start playback
            if (!audioService.isPlaying) {
              await audioService.play();
            }

            // 3️⃣ Update current audio AFTER successful load/play
            ref.read(currentAudioProvider.notifier).state = audio;

            // 4️⃣ Show player sheet
            if (context.mounted) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => AudioPlayerBottomSheet(audio: audio),
              );
            }
          } catch (e) {
            print("Playback error: $e");
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to play audio. Please try again.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: audio.thumbnailUrl != null
                    ? CachedNetworkImage(
                        imageUrl: audio.thumbnailUrl!,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: theme.colorScheme.primary.withOpacity(0.05)),
                      )
                    : Container(
                        width: 70,
                        height: 70,
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        child: Icon(Icons.music_note_rounded,
                            color: theme.colorScheme.primary),
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      audio.title ?? "Unknown",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      audio.author ?? "Watered Scholar",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: theme.textTheme.bodyMedium?.color
                            ?.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined,
                            size: 12,
                            color: theme.colorScheme.primary.withOpacity(0.7)),
                        const SizedBox(width: 4),
                        Text(
                          audio.duration ?? "0:00",
                          style: TextStyle(
                              fontSize: 11,
                              color:
                                  theme.colorScheme.primary.withOpacity(0.7)),
                        ),
                        const Spacer(),
                        _InteractionButtons(audio: audio),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.play_arrow_rounded,
                    color: theme.colorScheme.primary, size: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InteractionButtons extends ConsumerWidget {
  final Audio audio;
  const _InteractionButtons({required this.audio});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Row(
      children: [
        InkWell(
          onTap: () async {
            if (!ref.read(authProvider).isAuthenticated) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const LoginScreen()));
              return;
            }
            await ref
                .read(interactionServiceProvider)
                .toggleLike('audio', audio.id);
            ref.refresh(audioListProvider(category: null));
          },
          child: Icon(
            audio.isLiked ?? false ? Icons.favorite : Icons.favorite_border,
            size: 16,
            color: audio.isLiked ?? false
                ? Colors.redAccent
                : theme.iconTheme.color?.withOpacity(0.4),
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          onTap: () => CommentBottomSheet.show(context, 'audio', audio.id),
          child: Icon(
            Icons.chat_bubble_outline_rounded,
            size: 16,
            color: theme.iconTheme.color?.withOpacity(0.4),
          ),
        ),
      ],
    );
  }
}

class _EmptyAudioFeed extends StatelessWidget {
  const _EmptyAudioFeed();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No audio available yet."),
    );
  }
}
