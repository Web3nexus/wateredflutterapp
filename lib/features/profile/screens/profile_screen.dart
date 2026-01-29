import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/community/screens/community_feed_screen.dart'; // Added import
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

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
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
              child: Text('GET PLUS+', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 12)),
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
                        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, shape: BoxShape.circle),
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
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified_rounded, color: Theme.of(context).colorScheme.primary, size: 14),
                      SizedBox(width: 6),
                      Text(
                        'PREMIUM',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1),
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
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
                decoration: InputDecoration(
                  hintText: 'Search menu options...',
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
                  suffixIcon: _searchQuery.isNotEmpty 
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
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
              ..._getFilteredMenuItems(context).map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: item,
              )),
              
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

  List<Widget> _getFilteredMenuItems(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'icon': Icons.people_outline_rounded, 'title': 'Community', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CommunityFeedScreen()))},
      {'icon': Icons.bookmark_border_rounded, 'title': 'My Collection', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UserLibraryScreen()))},
      {'icon': Icons.diamond_outlined, 'title': 'Sacred Shop', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ShopScreen()))},
      {'icon': Icons.map_outlined, 'title': 'Temple Discovery', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TempleScreen()))},
      {'icon': Icons.event_available_rounded, 'title': 'Upcoming Events', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EventsScreen()))},
      {'icon': Icons.spa_outlined, 'title': 'Rituals', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RitualsScreen()))},
      {'icon': Icons.record_voice_over_outlined, 'title': 'Incantations', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const IncantationsScreen()))},
      {'icon': Icons.calendar_month_outlined, 'title': 'Book Consultation', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ConsultationScreen()))},
      {'icon': Icons.person_outline_rounded, 'title': 'Edit Profile', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EditProfileScreen()))},
      {'icon': Icons.settings_outlined, 'title': 'Settings', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SettingsScreen()))},
      {'icon': Icons.star_border_rounded, 'title': 'Premium Access', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SubscriptionScreen()))},
      {'icon': Icons.alarm_rounded, 'title': 'Reminders', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RemindersScreen()))},
      {'icon': Icons.help_outline_rounded, 'title': 'Help & Support', 'onTap': () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HelpSupportScreen()))},
    ];

    return items
        .where((item) => item['title'].toString().toLowerCase().contains(_searchQuery))
        .map((item) => _buildMenuItem(context, icon: item['icon'], title: item['title'], onTap: item['onTap']))
        .toList();
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
