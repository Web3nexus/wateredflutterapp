import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/core/network/api_client.dart';
import 'dart:io';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref.read(apiClientProvider));
});

class NotificationService {
  final ApiClient _client;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  NotificationService(this._client);

  FirebaseMessaging? get _fcm {
    try {
      if (Platform.isMacOS) return null;
      // Ensure Firebase is actually initialized before accessing instance
      if (Firebase.apps.isEmpty) {
        print('⚠️ FCM not available: Firebase not initialized');
        return null;
      }
      return FirebaseMessaging.instance;
    } catch (e) {
      print('⚠️ FCM not available: $e');
      return null;
    }
  }

  Future<void> initialize() async {
    // Skip Firebase initialization on macOS
    if (Platform.isMacOS || _fcm == null) {
      print('ℹ️ NotificationService skipped on macOS');
      return;
    }

    // 1. Request Permissions
    NotificationSettings settings = await _fcm!.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 2. Get Token
      String? token = await _fcm!.getToken();
      if (token != null) {
        await _updateTokenOnBackend(token);
      }

      // 3. Listen for token refresh
      _fcm!.onTokenRefresh.listen(_updateTokenOnBackend);

      // 4. Handle Foreground Messages
      FirebaseMessaging.onMessage.listen(_showLocalNotification);
      
      // 5. Initialize Local Notifications
      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings();
      
      await _localNotifications.initialize(
        const InitializationSettings(android: androidSettings, iOS: iosSettings),
        onDidReceiveNotificationResponse: (details) {
          final payload = details.payload;
          if (payload != null) {
            // Simple routing logic: if it's a ritual, go to rituals screen
            // For now, mapping everything to the initial screen or rituals
            _client.get('rituals'); // Just to trigger a fetch or similar if needed
          }
        },
      );

      // 6. Create High Importance Channel for Android
      const androidChannel = AndroidNotificationChannel(
        'watered_notifications', // id
        'Watered Notifications', // title
        description: 'General notifications for rituals and holy days.', // description
        importance: Importance.max,
        playSound: true,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannel);
    }
  }

  Future<void> _updateTokenOnBackend(String token) async {
    try {
      await _client.post('notifications/token', data: {
        'token': token,
        'device_type': Platform.isIOS ? 'ios' : 'android',
      });
    } catch (e) {
      print('Failed to update FCM token on backend: $e');
    }
  }

  void _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'watered_notifications',
          'Watered Notifications',
          channelDescription: 'General notifications for rituals and holy days.',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          playSound: true,
          // sound: RawResourceAndroidNotificationSound('notification_sound'), // Optional: if we add assets
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: message.data['screen'], 
    );
  }
}
