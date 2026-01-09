import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wateredflutterapp/features/auth/providers/auth_provider.dart';
import 'package:wateredflutterapp/features/auth/screens/login_screen.dart';
import 'package:wateredflutterapp/features/library/screens/user_library_screen.dart';
import 'package:wateredflutterapp/features/commerce/screens/shop_screen.dart';
import 'package:wateredflutterapp/features/temples/screens/temple_screen.dart';
import 'package:wateredflutterapp/features/consultation/screens/consultation_screen.dart';
import 'package:wateredflutterapp/features/search/screens/search_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check authentication status on load if needed, but provider usually handles it.
    // However, for the profile tab, we just react to the state.
    final authState = ref.watch(authProvider);

    if (!authState.isAuthenticated) {
      return const LoginScreen();
    }

    final user = authState.user!;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 48),
              // Profile Image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD4AF37), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color(0xFF1E293B),
                  backgroundImage: user.profilePhotoUrl != null
                      ? CachedNetworkImageProvider(user.profilePhotoUrl!)
                      : null,
                  child: user.profilePhotoUrl == null
                      ? Text(
                          user.name.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 48,
                            color: Color(0xFFD4AF37),
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
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cinzel',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              // Email
              Text(
                user.email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.5),
                  fontFamily: 'Outfit',
                ),
              ),
              const SizedBox(height: 48),
              // Menu Items
              _buildMenuItem(
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
                icon: Icons.person_outline_rounded,
                title: 'Edit Profile',
                onTap: () {
                  // TODO: Implement Edit Profile
                },
              ),
              const SizedBox(height: 16),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {
                  // TODO: Implement Settings
                },
              ),
               const SizedBox(height: 16),
              _buildMenuItem(
                icon: Icons.help_outline_rounded,
                title: 'Help & Support',
                onTap: () {},
              ),
              const Spacer(),
              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await ref.read(authProvider.notifier).logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.05),
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
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      tileColor: const Color(0xFF1E293B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFD4AF37).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFFD4AF37), size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white.withOpacity(0.2), size: 16),
    );
  }
}
