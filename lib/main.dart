import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/config/providers/app_boot_provider.dart';
import 'package:Watered/features/config/providers/global_settings_provider.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/home/screens/dashboard_screen.dart';
import 'package:Watered/features/traditions/screens/library_screen.dart';
import 'package:Watered/features/videos/screens/feed_screen.dart';
import 'package:Watered/features/audio/screens/audio_feed_screen.dart';
import 'package:Watered/features/audio/widgets/mini_player.dart';
import 'package:Watered/features/profile/screens/profile_screen.dart';
import 'package:Watered/features/community/screens/community_feed_screen.dart';
import 'package:Watered/features/auth/screens/login_screen.dart';
import 'package:Watered/features/sacred_book/screens/sacred_book_screen.dart';
import 'package:Watered/features/commerce/screens/shop_screen.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:Watered/core/theme/theme_provider.dart';
import 'package:Watered/core/widgets/premium_gate.dart';
import 'package:Watered/features/subscription/screens/subscription_screen.dart';
import 'package:Watered/core/services/ad_service.dart';
import 'package:Watered/core/services/notification_service.dart';
import 'package:Watered/features/home/providers/tab_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:Watered/core/services/navigation_service.dart';
import 'package:Watered/features/auth/screens/verification_pending_screen.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  // 1. Initialize Firebase first
  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  // 2. Initialize other services
  final container = ProviderContainer();
  try {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.example.wateredflutterapp.channel.audio',
      androidNotificationChannelName: 'Watered Audio',
      androidNotificationOngoing: true,
    );
    
    // Initialize Ads
    await container.read(adServiceProvider).initialize();
    // Initialize Notifications
    await container.read(notificationServiceProvider).initialize();
  } catch (e, stack) {
    print('Error during service initialization: $e');
    print(stack);
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootState = ref.watch(appBootProvider);
    final settings = ref.watch(globalSettingsNotifierProvider).asData?.value;
    final themeMode = ref.watch(themeProvider);

    // Build theme from dynamic settings
    final primaryColor = _parseColor(settings?.primaryColor, const Color(0xFFF4B846));
    final secondaryColor = _parseColor(settings?.secondaryColor, const Color(0xFF6C63FF));

    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0077BE), // Water Blue
        primary: const Color(0xFF0077BE),
        secondary: const Color(0xFF005E99),
        surface: Colors.white,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF8F5F2), // Off-white
      fontFamily: 'Outfit',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: 'Cinzel',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Cinzel',
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFF1A1A1A),
          height: 1.5,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
      ),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0077BE),
        primary: const Color(0xFF0077BE),
        secondary: const Color(0xFF00A3FF),
        surface: const Color(0xFF1A1A1A), 
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212),
      fontFamily: 'Outfit',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: 'Cinzel',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Cinzel',
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFFF8F5F2),
          height: 1.5,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: const Color(0xFF1E1E1E),
      ),
    );

    return MaterialApp(
      navigatorKey: ref.read(navigationServiceProvider).navigatorKey,
      title: settings?.siteName ?? 'Watered',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const RootGate(),
    );
  }

  Color _parseColor(String? hexColor, Color fallback) {
    if (hexColor == null || hexColor.isEmpty) return fallback;
    try {
      final hex = hexColor.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return fallback;
    }
  }
}

class RootGate extends ConsumerStatefulWidget {
  const RootGate({super.key});

  @override
  ConsumerState<RootGate> createState() => _RootGateState();
}

class _RootGateState extends ConsumerState<RootGate> {
  @override
  void initState() {
    super.initState();
    // Initialize auth status once on boot
    print('🚀 Initializing Auth Status...');
    Future.microtask(() => ref.read(authProvider.notifier).checkAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    final bootState = ref.watch(appBootProvider);
    final authState = ref.watch(authProvider);

    // 1. Show nothing while booting or checking auth (Native splash stays visible)
    if (bootState.isLoading || authState.isLoading) {
      return const SizedBox.shrink();
    }

    // When we have data or error, remove the native splash
    FlutterNativeSplash.remove();

    // 2. Show Error Screen if boot failed
    return bootState.when(
      data: (status) {
        if (status == BootStatus.maintenance) {
          return const Scaffold(body: Center(child: Text('Under Maintenance')));
        }

        // Check for Email Verification
        if (authState.isAuthenticated) {
          final user = authState.user;
          if (user != null && user.emailVerifiedAt == null) {
            return VerificationPendingScreen(email: user.email);
          }
        }
        
        return const MainTabsScreen();
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stack) => ErrorScreen(error: error.toString()),
    );
  }
}



class MainTabsScreen extends ConsumerStatefulWidget {
  const MainTabsScreen({super.key});

  @override
  ConsumerState<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends ConsumerState<MainTabsScreen> {
  final List<Widget> _screens = [
    const DashboardScreen(),
    const LibraryScreen(),
    const SacredBookScreen(),
    const ShopScreen(),
    const ProfileGate(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentIndex = ref.watch(tabIndexProvider);

    return Scaffold(
      body: Stack(
        children: [
          _screens[currentIndex],
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: MiniPlayer(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: theme.dividerColor.withOpacity(0.1), width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => ref.read(tabIndexProvider.notifier).state = index,
          backgroundColor: theme.scaffoldBackgroundColor,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: isDark ? Colors.white54 : Colors.black38,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_rounded),
              label: 'Media',
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: currentIndex == 2 ? const Color(0xFFF4B846) : theme.colorScheme.primary.withOpacity(0.15),
                  shape: BoxShape.circle,
                  boxShadow: currentIndex == 2 ? [
                    BoxShadow(
                      color: const Color(0xFFF4B846).withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ] : null,
                  border: Border.all(
                    color: currentIndex == 2 ? Colors.white : theme.colorScheme.primary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Image.asset(
                  'assets/icon/sacred_book_nav_icon.png',
                  width: 32,
                  height: 32,
                  // We might not want to tint the custom colorful icon too much, but let's see. 
                  // If it's a colorful PNG, maybe don't use color: ...
                ),
              ),
              label: 'Sacred Book',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded),
              label: 'Shop',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({super.key, required this.error});

  String _getUserFriendlyMessage(String error) {
    final lowerError = error.toLowerCase();
    if (lowerError.contains('socket') || lowerError.contains('network')) {
      return 'No internet connection. Please check your network and try again.';
    } else if (lowerError.contains('timeout')) {
      return 'Connection timeout. Please try again.';
    } else if (lowerError.contains('refused') || lowerError.contains('failed host lookup')) {
      return 'Cannot connect to server. Please try again later.';
    } else {
      return 'Something went wrong. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_off_rounded, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                'Connection Error',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                _getUserFriendlyMessage(error),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MyApp()),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ProfileGate extends ConsumerWidget {
  const ProfileGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(authProvider).isAuthenticated;
    if (isAuthenticated) {
      return ProfileScreen();
    }
    return LoginScreen();
  }
}
