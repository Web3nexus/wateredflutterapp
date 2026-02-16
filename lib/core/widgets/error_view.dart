import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/library/providers/bookmark_provider.dart';
import 'package:Watered/features/traditions/providers/tradition_provider.dart';
import 'package:Watered/features/traditions/screens/tradition_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Watered/core/network/api_error_handler.dart';
import 'package:Watered/features/audio/models/audio.dart';
import 'package:Watered/features/audio/services/audio_service.dart';
import 'package:Watered/features/audio/providers/current_audio_provider.dart';
import 'package:Watered/features/audio/widgets/audio_player_bottom_sheet.dart';
import 'package:Watered/core/widgets/error_view.dart';
import 'package:Watered/core/widgets/loading_view.dart';

class ErrorView extends StatelessWidget {
  final Object error;
  final StackTrace? stackTrace;
  final VoidCallback? onRetry;
  final bool isCenter;

  const ErrorView({
    super.key,
    required this.error,
    this.stackTrace,
    this.onRetry,
    this.isCenter = true,
  });

  String _getUserFriendlyMessage(Object error) {
    // If it's already an ApiException, use its customized message
    if (error is ApiException) {
      return error.message;
    }

    final lowerError = error.toString().toLowerCase();
    
    if (lowerError.contains('socket') || 
        lowerError.contains('network') || 
        lowerError.contains('connection refused')) {
      return 'No internet connection. Please check your settings and try again.';
    }
    
    if (lowerError.contains('timeout')) {
      return 'Connection timeout. Please try again.';
    }
    
    if (lowerError.contains('not found') || lowerError.contains('404')) {
      return 'The requested content could not be found.';
    }

    if (lowerError.contains('null is not a subtype')) {
      return 'Data mismatch error. We\'re working to fix this.';
    }

    // Default friendly message
    return 'Something went wrong. Please try again later.';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: theme.colorScheme.primary.withOpacity(0.5),
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            'Peace Be Still',
            style: theme.textTheme.titleLarge?.copyWith(
              fontFamily: 'Cinzel',
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _getUserFriendlyMessage(error),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                foregroundColor: theme.colorScheme.primary,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: theme.colorScheme.primary.withOpacity(0.2)),
                ),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ],
      ),
    );

    if (isCenter) {
      return Center(child: SingleChildScrollView(child: content));
    }
    return content;
  }
}
