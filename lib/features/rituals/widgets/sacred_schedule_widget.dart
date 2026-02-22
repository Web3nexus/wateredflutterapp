import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/rituals/models/ritual.dart';
import 'package:Watered/features/rituals/providers/ritual_providers.dart';
import 'package:Watered/features/rituals/screens/ritual_detail_screen.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart'; // Add import
import 'package:Watered/features/reminders/services/reminder_service.dart';
import 'package:Watered/features/audio/services/audio_service.dart'; // Add import
import 'package:Watered/features/audio/services/sacred_sound_service.dart'; // Add import
import 'package:Watered/features/audio/models/sacred_sound.dart'; // Add import

class SacredScheduleWidget extends ConsumerStatefulWidget {
  const SacredScheduleWidget({super.key});

  @override
  ConsumerState<SacredScheduleWidget> createState() => _SacredScheduleWidgetState();
}

class _SacredScheduleWidgetState extends ConsumerState<SacredScheduleWidget> {
  Timer? _timer;
  late DateTime _now;
  // final AudioPlayer _audioPlayer = AudioPlayer(); // Removed local instance
  bool _notificationsEnabled = true;
  String _selectedSound = 'Ancient Chant';
  String? _currentlyPlayingUrl;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  // Fallback sounds removed as per request to use only backend sounds
  // final List<Map<String, String>> _defaultSounds = [];
  String? _lastTriggeredMinute; // To prevent double triggers in the same minute

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        final now = DateTime.now();
        setState(() {
          _now = now;
        });
        
        // Sound Trigger Logic
        _checkAndPlayRitualSound(now);
      }
    });

    // Initialize audio listener
    Future.microtask(() => _setupAudioListener());
  }

  void _setupAudioListener() {
    final audioService = ref.read(audioServiceProvider);
    _playerStateSubscription = audioService.player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (mounted && _currentlyPlayingUrl != null) {
          setState(() {
            _currentlyPlayingUrl = null;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _playerStateSubscription?.cancel();
    // _audioPlayer.dispose(); // Do not dispose shared player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ritualsAsync = ref.watch(ritualsListProvider(null));
    final theme = Theme.of(context);

    return ritualsAsync.when(
      data: (rituals) {
        // Filter for permanent sacred daily rituals only
        final dailyRituals = rituals
            .where((r) => r.isSacredDaily)
            .toList()
          ..sort((a, b) => a.timeOfDay!.compareTo(b.timeOfDay!));

        if (dailyRituals.isEmpty) return const SizedBox.shrink();

        // Find the next ritual
        Ritual? nextRitual;
        bool isTomorrow = false;

        for (final ritual in dailyRituals) {
          if (!ritual.isPast) {
            nextRitual = ritual;
            break;
          }
        }

        // If all are past, use the first one of "tomorrow"
        if (nextRitual == null && dailyRituals.isNotEmpty) {
          nextRitual = dailyRituals.first;
          isTomorrow = true;
        }
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, "Sacred Rituals", "${dailyRituals.length} daily prayers"),
            const SizedBox(height: 16),
            if (nextRitual != null) _buildNextRitualCard(context, nextRitual, isTomorrow: isTomorrow),
            const SizedBox(height: 24),
            ...dailyRituals.map((r) => _buildRitualListItem(context, r)),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, ss) => const SizedBox.shrink(),
    );
  }

  Widget _buildHeader(BuildContext context, String title, String subtitle) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.water_drop_outlined, color: theme.colorScheme.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.6)),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.settings_outlined, size: 20, color: theme.textTheme.bodySmall?.color?.withOpacity(0.5)),
              onPressed: () => _showSettingsModal(context),
            ),
            _buildRemindButton(context),
          ],
        ),
      ],
    );
  }

  Widget _buildRemindButton(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _activateReminder(context),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.notifications_none_rounded, size: 16, color: theme.textTheme.bodyMedium?.color),
            const SizedBox(width: 4),
            Text(
              "Remind Me",
              style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _activateReminder(BuildContext context) async {
    final ritualsAsync = ref.read(ritualsListProvider(null));
    ritualsAsync.whenData((rituals) async {
      final nextRitual = rituals.firstWhere((r) => !r.isPast, orElse: () => rituals.first);
      final reminderService = ref.read(reminderServiceProvider);
      
      try {
        await reminderService.saveReminder(
          "Ritual: ${nextRitual.title}",
          TimeOfDay.fromDateTime(nextRitual.scheduledTime ?? DateTime.now()),
          ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
          soundPath: _selectedSound, // Store name or URL? ReminderService expects soundPath. Storing URL for now.
        );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Reminder set for ${nextRitual.title}!"),
              behavior: SnackBarBehavior.floating,
              backgroundColor: const Color(0xFF7C4DFF),
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to set reminder: $e")),
          );
        }
      }
    });
  }

  void _showSettingsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Consumer(
        builder: (context, ref, _) {
          final sacredSoundsAsync = ref.watch(sacredSoundsProvider);
          final theme = Theme.of(context);
          
          return StatefulBuilder(
            builder: (context, setModalState) {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.dividerColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Ritual Settings",
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Cinzel'),
                ),
                const SizedBox(height: 8),
                Text(
                  "Customize your sacred alerts and notifications",
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6)),
                ),
                const SizedBox(height: 32),
                SwitchListTile(
                  title: const Text("Enable Notifications"),
                  subtitle: const Text("Receive alerts for upcoming rituals"),
                  value: _notificationsEnabled,
                  activeColor: const Color(0xFF7C4DFF),
                  onChanged: (val) {
                    setState(() => _notificationsEnabled = val);
                    setModalState(() {});
                  },
                ),
                const Divider(height: 32),
                Text(
                  "Notification Sound",
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Wrap sound list in scrollable container
                Flexible(
                  child: sacredSoundsAsync.when(
                    data: (sounds) {
                      if (sounds.isEmpty) {
                        return const Center(child: Text("No sacred sounds found in the temple."));
                      }
                      
                      // Update selected sound if empty or invalid
                      if (_selectedSound == 'Ancient Chant' || !sounds.any((s) => s.title == _selectedSound)) {
                        Future.microtask(() {
                          if (mounted) setState(() => _selectedSound = sounds.first.title);
                        });
                      }

                      return SingleChildScrollView(
                        child: Column(
                          children: sounds.map((sound) {
                            final isSelected = _selectedSound == sound.title;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: InkWell(
                                onTap: () {
                                  setState(() => _selectedSound = sound.title);
                                  setModalState(() {});
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? theme.colorScheme.primary.withOpacity(0.1) : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected ? theme.colorScheme.primary : theme.dividerColor.withOpacity(0.1),
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                                        color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodySmall?.color?.withOpacity(0.4),
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(child: Text(sound.title)),
                                      IconButton(
                                        icon: Icon(
                                          _currentlyPlayingUrl == sound.filePath
                                              ? Icons.pause_circle_outline
                                              : Icons.play_circle_outline,
                                          size: 24,
                                        ),
                                        onPressed: () => _previewSound(sound.filePath),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (e, ss) => Center(child: Text("Failed to load sounds: $e")),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
          );
        }
      ),
    );
  }

  void _previewSound(String url) async {
    try {
      final audioService = ref.read(audioServiceProvider);
      
      // If clicking the currently playing sound, pause it
      if (_currentlyPlayingUrl == url && audioService.player.playing) {
        await audioService.pause();
        setState(() {
          _currentlyPlayingUrl = null;
        });
        return;
      }

      // Ensure the player is initialized before using AudioService
      if (!audioService.isReady) {
        await ref.read(audioPlayerProvider.future);
      }

      await audioService.stop();
      await audioService.player.setAudioSource(
        AudioSource.uri(
          Uri.parse(url),
          tag: MediaItem(
            id: url,
            album: "Ritual Preview",
            title: "Preview Sound",
            artUri: Uri.parse("https://mywatered.com/storage/images/logo_light.png"),
          ),
        ),
      );
      
      setState(() {
        _currentlyPlayingUrl = url;
      });
      
      await audioService.play();
    } catch (e) {
      print("Error playing preview: $e");
      setState(() {
        _currentlyPlayingUrl = null;
      });
    }
  }

  void _checkAndPlayRitualSound(DateTime now) {
    final ritualsAsync = ref.read(ritualsListProvider(null));
    ritualsAsync.whenData((rituals) {
      final currentTimeStr = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
      final currentMinuteKey = "${now.year}-${now.month}-${now.day}-$currentTimeStr";

      if (_lastTriggeredMinute == currentMinuteKey) return;

      for (final ritual in rituals) {
        if (ritual.timeOfDay == currentTimeStr) {
          _lastTriggeredMinute = currentMinuteKey;
          _playRitualAlert(ritual);
          break;
        }
      }
    });
  }

  void _playRitualAlert(Ritual ritual) async {
    final sacredSoundsAsync = ref.read(sacredSoundsProvider);
    sacredSoundsAsync.whenData((sounds) async {
      if (sounds.isEmpty) return;
      
      // Use the selected sound from settings, or fallback to the first one
      final sound = sounds.firstWhere(
        (s) => s.title == _selectedSound,
        orElse: () => sounds.first,
      );
      
      try {
        final audioService = ref.read(audioServiceProvider);
        if (!audioService.isReady) await ref.read(audioPlayerProvider.future);
        
        await audioService.stop();
        await audioService.player.setAudioSource(
          AudioSource.uri(
            Uri.parse(sound.filePath),
            tag: MediaItem(
              id: sound.filePath,
              album: "Sacred Ritual",
              title: ritual.title,
              artUri: Uri.parse("https://mywatered.com/storage/images/logo_light.png"),
            ),
          ),
        );
        await audioService.play();
      } catch (e) {
        print("Error playing ritual alert: $e");
      }
    });
  }

  Widget _buildNextRitualCard(BuildContext context, Ritual ritual, {bool isTomorrow = false}) {
    final theme = Theme.of(context);
    final scheduled = ritual.scheduledTime;
    Duration? diff;
    if (scheduled != null) {
      var targetTime = scheduled;
      if (isTomorrow) {
        targetTime = scheduled.add(const Duration(days: 1));
      }
      diff = targetTime.difference(_now);
    }

    final hours = diff?.inHours ?? 0;
    final mins = (diff?.inMinutes ?? 0) % 60;
    final secs = (diff?.inSeconds ?? 0) % 60;

    // Determine time of day based on ritual time
    final ritualHour = scheduled?.hour ?? 12;
    
    // Define colors and icons based on time of day
    List<Color> gradientColors;
    IconData backgroundIcon;
    String timeLabel;
    
    if (ritualHour >= 5 && ritualHour < 12) {
      // Morning (5 AM - 12 PM): Sunrise colors
      gradientColors = [
        const Color(0xFFFF6B6B), // Coral red
        const Color(0xFFFFB347), // Orange
      ];
      backgroundIcon = Icons.wb_sunny_rounded;
      timeLabel = "Morning Ritual";
    } else if (ritualHour >= 12 && ritualHour < 18) {
      // Afternoon (12 PM - 6 PM): Bright day colors
      gradientColors = [
        const Color(0xFF4FC3F7), // Sky blue
        const Color(0xFF0077BE), // Water blue
      ];
      backgroundIcon = Icons.wb_sunny_outlined;
      timeLabel = "Afternoon Ritual";
    } else {
      // Night (6 PM - 5 AM): Deep night colors
      gradientColors = [
        const Color(0xFF5E35B1), // Deep purple
        const Color(0xFF311B92), // Darker purple
      ];
      backgroundIcon = Icons.nightlight_round;
      timeLabel = "Evening Ritual";
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: gradientColors[0].withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background icon
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              backgroundIcon,
              size: 120,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(backgroundIcon, color: Colors.white.withOpacity(0.9), size: 18),
                  const SizedBox(width: 8),
                  Text(
                    isTomorrow ? "Next Ritual (Tomorrow)" : timeLabel,
                    style: TextStyle(color: Colors.white.withOpacity(0.9), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                ritual.title,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Cinzel'),
              ),
              const SizedBox(height: 4),
              Text(
                ritual.description ?? "",
                style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
              ),
              const SizedBox(height: 24),
              // Use LayoutBuilder to determine if we should hide seconds
              LayoutBuilder(
                builder: (context, constraints) {
                  final showSeconds = constraints.maxWidth > 300;
                  
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTimeUnit("${hours < 0 ? 0 : hours}", "hrs"),
                      const SizedBox(width: 8),
                      _buildTimeUnit("${mins < 0 ? 0 : mins}", "min"),
                      if (showSeconds) ...[
                        const SizedBox(width: 8),
                        _buildTimeUnit("${secs < 0 ? 0 : secs}", "sec"),
                      ],
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          isTomorrow ? "until tomorrow at ${_formatTime(ritual.timeOfDay)}" : "until ${_formatTime(ritual.timeOfDay)}",
                          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(String value, String unit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          Text(
            unit,
            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildRitualListItem(BuildContext context, Ritual ritual) {
    final theme = Theme.of(context);
    final isPast = ritual.isPast;
    final isNext = !isPast; // Simplified for this list

    return Opacity(
      opacity: 1.0, // Permanent on home, no fading
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isNext ? theme.cardTheme.color?.withOpacity(0.5) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isPast 
                    ? [Colors.grey.shade400, Colors.grey.shade500]
                    : (ritual.timeOfDay!.compareTo("12:00") < 0 
                        ? [Colors.orange.shade300, Colors.orange.shade500] 
                        : [const Color(0xFF7C4DFF), const Color(0xFF651FFF)]),
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                ritual.timeOfDay!.compareTo("12:00") < 0 ? Icons.wb_sunny_outlined : Icons.dark_mode_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ritual.title,
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ritual.description ?? "",
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.textTheme.bodySmall?.color?.withOpacity(0.6)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(
              _formatTime(ritual.timeOfDay),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyLarge?.color?.withOpacity(isPast ? 0.4 : 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return "";
    try {
      final parts = timeStr.split(':');
      final time = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
      final dt = DateTime(0, 0, 0, time.hour, time.minute);
      return DateFormat('h:mm a').format(dt);
    } catch (e) {
      return timeStr;
    }
  }
}
