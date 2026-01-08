class VideoService {
  /// Extract YouTube Video ID from various URL formats
  static String? getYouTubeId(String url) {
    final RegExp regExp = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
      multiLine: false,
    );

    final Match? match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    }
    return null;
  }

  /// Get High Quality thumbnail URL from YouTube ID
  static String getThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
  }

  /// Get Embed URL for YouTube player
  static String getEmbedUrl(String videoId) {
    return 'https://www.youtube.com/embed/$videoId';
  }
}
