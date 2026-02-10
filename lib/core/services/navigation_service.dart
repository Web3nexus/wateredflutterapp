import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationServiceProvider = Provider((ref) => NavigationService());

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> showNoInternetDialog<T>() {
    final context = navigatorKey.currentContext;
    if (context == null) return Future.value(null);

    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.wifi_off_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text('No Internet'),
          ],
        ),
        content: const Text(
          'It seems you are not connected to the internet. Please check your connection and try again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
