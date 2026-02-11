import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';

final userActivityServiceProvider = Provider<UserActivityService>((ref) {
  return UserActivityService(ref.read(apiClientProvider));
});

class UserActivityService {
  final ApiClient _client;

  UserActivityService(this._client);

  /// Track time spent on a page
  Future<void> trackActivity(String page, int durationSeconds) async {
    try {
      if (durationSeconds < 1) return; // Don't track if less than 1 second

      await _client.post('activity/track', data: {
        'page': page,
        'duration_seconds': durationSeconds,
        // visited_at is optional, backend defaults to now()
      });
      // print('Tracked $page for ${durationSeconds}s'); 
    } catch (e) {
      // Silently fail for analytics to avoid disrupting user experience
      // print('Failed to track activity: $e');
    }
  }
}
