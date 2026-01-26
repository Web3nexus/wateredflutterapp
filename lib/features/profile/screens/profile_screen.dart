import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/auth/screens/login_screen.dart';
import 'package:Watered/features/library/screens/user_library_screen.dart';
import 'package:Watered/features/commerce/screens/shop_screen.dart';
import 'package:Watered/features/temples/screens/temple_screen.dart';
import 'package:Watered/features/consultation/screens/consultation_screen.dart';
import 'package:Watered/features/search/screens/search_screen.dart';
import 'package:Watered/features/events/screens/events_screen.dart'; 
import 'package:Watered/features/rituals/screens/rituals_screen.dart';
import 'package:Watered/features/incantations/screens/incantations_screen.dart';
import 'package:Watered/features/subscription/screens/subscription_screen.dart';
import 'package:Watered/features/reminders/screens/reminders_screen.dart';
import 'package:Watered/features/profile/screens/settings_screen.dart';
import 'package:Watered/features/profile/screens/help_support_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Watered/core/theme/theme_provider.dart';
import 'package:Watered/features/profile/screens/edit_profile_screen.dart';
import 'package:Watered/features/profile/services/profile_service.dart';
import 'package:Watered/core/services/ad_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> _pickAndUploadPhoto(BuildContext context, WidgetRef ref) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery, maxWidth: 1024, maxHeight: 1024, imageQuality: 85);

    if (image != null) {
      try {
        final updatedUser = await ref.read(profileServiceProvider).uploadPhoto(File(image.path));
        ref.read(authProvider.notifier).updateUser(updatedUser);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile photo updated')));
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload: $e'), backgroundColor: Colors.red));
        }
      }
    }
  }

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
      appBar: AppBar(
        title: const Text('PROFILE'),
        actions: [
          if (!user.isPremium)
            TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SubscriptionScreen())),
              child: const Text('GET PLUS+', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AdBanner(screenKey: 'profile'),
              const SizedBox(height: 24),
              // Profile Image
              InkWell(
                onTap: () => _pickAndUploadPhoto(context, ref),
                borderRadius: BorderRadius.circular(60),
                child: Stack(
                  children: [
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
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: Color(0xFFD4AF37), shape: BoxShape.circle),
                        child: const Icon(Icons.camera_alt, color: Colors.black, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Name
              Text(
                user.name,
                style: theme.textTheme.headlineMedium?.copyWith(fontSize: 28),
              ),
              if (user.isPremium) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified_rounded, color: Color(0xFFD4AF37), size: 14),
                      SizedBox(width: 6),
                      Text(
                        'PREMIUM',
                        style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 8),
              // Email
              Text(
                user.email,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 24),
              
              // Search Bar
              TextField(
                readOnly: true,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchScreen())),
                decoration: InputDecoration(
                  hintText: 'Search wisdom, deities, rituals...',
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFD4AF37)),
                  filled: true,
                  fillColor: theme.cardTheme.color,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),

              const SizedBox(height: 32),
              
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
                    const Text('Dark Mode', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Switch(
                      value: isDark,
                      activeColor: theme.colorScheme.primary,
                      onChanged: (value) => ref.read(themeProvider.notifier).toggleTheme(),
                    ),
                  ],
                ),
              ),

              // Menu Items
              _buildMenuItem(context, icon: Icons.bookmark_border_rounded, title: 'My Collection', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UserLibraryScreen()))),
              const SizedBox(height: 16),
              _buildMenuItem(context, icon: Icons.diamond_outlined, title: 'Sacred Shop', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ShopScreen()))),
              const SizedBox(height: 16),
              _buildMenuItem(context, icon: Icons.map_outlined, title: 'Temple Discovery', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TempleScreen()))),
              const SizedBox(height: 16),
              _buildMenuItem(context, icon: Icons.event_available_rounded, title: 'Upcoming Events', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EventsScreen()))),
              const SizedBox(height: 16),
              _buildMenuItem(context, icon: Icons.spa_outlined, title: 'Rituals', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RitualsScreen()))),
              const SizedBox(height: 16),
              _buildMenuItem(context, icon: Icons.record_voice_over_outlined, title: 'Incantations', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const IncantationsScreen()))),
              const SizedBox(height: 16),
              _buildMenuItem(context, icon: Icons.calendar_month_outlined, title: 'Book Consultation', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ConsultationScreen()))),
              const SizedBox(height: 16),
              _buildMenuItem(context, icon: Icons.person_outline_rounded, title: 'Edit Profile', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EditProfileScreen()))),
              const SizedBox(height: 16),
              _buildMenuItem(context, icon: Icons.settings_outlined, title: 'Settings', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen()))),
              const SizedBox(height: 16),
              _buildMenuItem(context, icon: Icons.star_border_rounded, title: 'Premium Access', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SubscriptionScreen()))),
              const SizedBox(height: 16),
              _buildMenuItem(context, icon: Icons.alarm_rounded, title: 'Reminders', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RemindersScreen()))),
              const SizedBox(height: 16),
              _buildMenuItem(context, icon: Icons.help_outline_rounded, title: 'Help & Support', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HelpSupportScreen()))),
              
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async => await ref.read(authProvider.notifier).logout(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.05),
                    foregroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('LOG OUT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      tileColor: theme.cardTheme.color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: theme.colorScheme.primary.withOpacity(0.1), shape: BoxShape.circle),
        child: Icon(icon, color: theme.colorScheme.primary, size: 24),
      ),
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: theme.textTheme.bodyMedium?.color?.withOpacity(0.2), size: 16),
    );
  }
}
