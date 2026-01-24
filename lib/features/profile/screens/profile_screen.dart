import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/auth/screens/login_screen.dart';
import 'package:Watered/features/library/screens/user_library_screen.dart';
import 'package:Watered/features/commerce/screens/shop_screen.dart';
import 'package:Watered/features/temples/screens/temple_screen.dart';
import 'package:Watered/features/consultation/screens/consultation_screen.dart';
import 'package:Watered/features/search/screens/search_screen.dart';
import 'package:Watered/features/search/screens/search_screen.dart';
import 'package:Watered/features/events/screens/events_screen.dart'; 
import 'package:Watered/features/rituals/screens/rituals_screen.dart'; // Added import
import 'package:Watered/features/incantations/screens/incantations_screen.dart'; // Added import
import 'package:Watered/features/subscription/screens/subscription_screen.dart'; // Added import
import 'package:Watered/features/reminders/screens/reminders_screen.dart'; // Added import
import 'package:cached_network_image/cached_network_image.dart';

import 'package:Watered/core/theme/theme_provider.dart';

// ... imports ...

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final themeMode = ref.watch(themeProvider);

    if (!authState.isAuthenticated) {
      return const LoginScreen();
    }

    final user = authState.user!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView( // Added scroll view for safety
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 48),
                // Profile Image
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: theme.colorScheme.primary, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: theme.cardTheme.color,
                    backgroundImage: user.profilePhotoUrl != null
                        ? CachedNetworkImageProvider(user.profilePhotoUrl!)
                        : null,
                    child: user.profilePhotoUrl == null
                        ? Text(
                            user.name.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              fontSize: 48,
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cinzel',
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 24),
                // Name
                Text(
                  user.name,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 8),
                // Email
                Text(
                  user.email,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                    fontFamily: 'Outfit',
                  ),
                ),
                const SizedBox(height: 48),
                
                // Theme Toggle
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                          color: theme.colorScheme.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                          color: theme.textTheme.bodyMedium?.color,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: isDark,
                        activeColor: theme.colorScheme.primary,
                        onChanged: (value) {
                          ref.read(themeProvider.notifier).toggleTheme();
                        },
                      ),
                    ],
                  ),
                ),

                // Menu Items
                _buildMenuItem(
                  context,
                  icon: Icons.bookmark_border_rounded,
                  title: 'My Collection',
                  onTap: () {
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const UserLibraryScreen()),
                     );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.diamond_outlined,
                  title: 'Sacred Shop',
                  onTap: () {
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ShopScreen()),
                     );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.map_outlined,
                  title: 'Temple Discovery',
                  onTap: () {
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const TempleScreen()),
                     );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.event_available_rounded,
                  title: 'Upcoming Events',
                  onTap: () {
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const EventsScreen()),
                     );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.spa_outlined,
                  title: 'Rituals',
                  onTap: () {
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const RitualsScreen()),
                     );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.record_voice_over_outlined,
                  title: 'Incantations',
                  onTap: () {
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const IncantationsScreen()),
                     );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.calendar_month_outlined,
                  title: 'Book Consultation',
                  onTap: () {
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ConsultationScreen()),
                     );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.search,
                  title: 'Search',
                  onTap: () {
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SearchScreen()),
                     );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.person_outline_rounded,
                  title: 'Edit Profile',
                  onTap: () {
                    // TODO: Implement Edit Profile
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    // TODO: Implement Settings
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.star_border_rounded,
                  title: 'Premium Access',
                  onTap: () {
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SubscriptionScreen()),
                     );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.alarm_rounded,
                  title: 'Reminders',
                  onTap: () {
                     Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const RemindersScreen()),
                     );
                  },
                ),
                const SizedBox(height: 16),
                _buildMenuItem(
                  context,
                  icon: Icons.help_outline_rounded,
                  title: 'Help & Support',
                  onTap: () {},
                ),
                const SizedBox(height: 32),
                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await ref.read(authProvider.notifier).logout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.05),
                      foregroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'LOG OUT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      tileColor: theme.cardTheme.color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: theme.colorScheme.primary, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: theme.textTheme.bodyMedium?.color,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded, 
        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.2), 
        size: 16
      ),
    );
  }
}
