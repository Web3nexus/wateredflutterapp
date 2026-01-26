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
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  NotificationService(this._client);

  Future<void> initialize() async {
    // 1. Request Permissions
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // 2. Get Token
      String? token = await _fcm.getToken();
      if (token != null) {
        await _updateTokenOnBackend(token);
      }

      // 3. Listen for token refresh
      _fcm.onTokenRefresh.listen(_updateTokenOnBackend);

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
            // TODO: Route to specific screen based on payload
            // e.g. 'ritual', 'event', 'audio', 'collection'
          }
        },
      );
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
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: message.data['screen'], // Example payload for deep linking
    );
  }
}
