import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/features/audio/models/audio.dart';

final currentAudioProvider = StateProvider<Audio?>((ref) => null);
