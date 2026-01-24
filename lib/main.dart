import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/config/providers/app_boot_provider.dart';
import 'package:Watered/features/config/providers/global_settings_provider.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/traditions/screens/library_screen.dart';
import 'package:Watered/features/videos/screens/feed_screen.dart';
import 'package:Watered/features/audio/screens/audio_feed_screen.dart';
import 'package:Watered/features/audio/widgets/mini_player.dart';
import 'package:Watered/features/profile/screens/profile_screen.dart';
import 'package:Watered/features/community/screens/community_feed_screen.dart'; // Added import
import 'package:just_audio_background/just_audio_background.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

import 'package:Watered/core/theme/theme_provider.dart';

// ... imports ...

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootState = ref.watch(appBootProvider);
    final settings = ref.watch(globalSettingsNotifierProvider).asData?.value;
    final themeMode = ref.watch(themeProvider);

    // Build theme from dynamic settings
    final primaryColor = _parseColor(settings?.primaryColor, const Color(0xFFD4AF37));
    final secondaryColor = _parseColor(settings?.secondaryColor, const Color(0xFF6C63FF));

    final lightTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: Colors.white,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Outfit',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Dark text for light mode
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: 'Cinzel',
          fontWeight: FontWeight.bold,
          color: Colors.black, // Dark text
        ),
        titleLarge: TextStyle(
          fontFamily: 'Cinzel',
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.black, 
        ),
        bodyMedium: TextStyle(
          color: Color(0xFF1E293B), // Dark blue-grey for text
          height: 1.5,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.grey.shade50,
      ),
    );

    final darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: const Color(0xFF0F172A), 
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF0F172A),
      fontFamily: 'Outfit',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Cinzel',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(0xFFD4AF37),
        ),
        iconTheme: IconThemeData(color: Color(0xFFD4AF37)),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: 'Cinzel',
          fontWeight: FontWeight.bold,
          color: Color(0xFFD4AF37),
        ),
        titleLarge: TextStyle(
          fontFamily: 'Cinzel',
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Color(0xFFD4AF37),
        ),
        bodyMedium: TextStyle(
          color: Color(0xFFE2E8F0),
          height: 1.5,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: const Color(0xFF1E293B),
      ),
    );

    return MaterialApp(
      title: settings?.siteName ?? 'Watered',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: bootState.when(
        data: (_) {
          // Initialize auth state
          Future.microtask(() => ref.read(authProvider.notifier).checkAuthStatus());
          return const MainTabsScreen();
        },
        loading: () => const SplashScreen(),
        error: (error, stack) => ErrorScreen(error: error.toString()),
      ),
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

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with Glow
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.2),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                  border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.5), width: 1.5),
                ),
                child: const Center(
                  child: Icon(Icons.water_drop_rounded, size: 70, color: Color(0xFFD4AF37)),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'WATERED',
                style: TextStyle(
                  fontFamily: 'Cinzel',
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 8,
                  color: Color(0xFFD4AF37),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'SACRED KNOWLEDGE',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 12,
                  letterSpacing: 2,
                  color: const Color(0xFFD4AF37).withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 60),
              const SizedBox(
                width: 40,
                child: LinearProgressIndicator(
                  color: Color(0xFFD4AF37),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({super.key});

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const LibraryScreen(),
    const AudioFeedScreen(),
    const FeedScreen(),
    const CommunityFeedScreen(), // Added Community Screen
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_currentIndex],
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
            top: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: const Color(0xFF0F172A),
          selectedItemColor: const Color(0xFFD4AF37),
          unselectedItemColor: Colors.blueGrey.shade500,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_stories_rounded),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mic_none_rounded),
              label: 'Audio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_filter_rounded),
              label: 'Reels',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline_rounded),
              label: 'Community',
            ),
            BottomNavigationBarItem(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                'Connection Error',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Please check your backend connection.\nError: $error',
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

