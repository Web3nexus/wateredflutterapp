import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider to track if the Library header (AppBar + Tabs) should be visible.
/// This is used for the TikTok-style reels feed to provide an immersive experience.
final videoHeaderVisibleProvider = StateProvider<bool>((ref) => true);
