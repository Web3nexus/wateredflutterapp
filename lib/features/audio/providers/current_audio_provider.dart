import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/audio/models/audio.dart';

final currentAudioProvider = StateProvider<Audio?>((ref) => null);
