import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/subscription/screens/subscription_screen.dart';

class PremiumGate extends ConsumerWidget {
  final Widget child;
  final String? message;

  const PremiumGate({
    super.key,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final bool isPremium = user?.isPremium ?? false;

    if (isPremium) {
      return child;
    }

    return _LockedOverlay(
      message: message ?? 'Unlock this feature with Watered Plus+',
      child: child,
    );
  }
}

class _LockedOverlay extends StatelessWidget {
  final String message;
  final Widget child;

  const _LockedOverlay({required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    final premiumBlue = const Color(0xFF0077BE);
    
    return Stack(
      children: [
        // Blurred/Dimmed child
        AbsorbPointer(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7), // Increased opacity for better focus
              BlendMode.darken,
            ),
            child: child,
          ),
        ),
        // Premium Message overlay
        Center(
          child: Container(
            padding: const EdgeInsets.all(32),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A).withValues(alpha: 0.98), // Deeper, more solid background
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: premiumBlue.withValues(alpha: 0.3), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: premiumBlue.withValues(alpha: 0.1),
                  blurRadius: 30,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: premiumBlue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome_rounded, // More "plus" / premium feel
                    color: premiumBlue,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'WATERED PLUS+',
                  style: TextStyle(
                    fontFamily: 'Cinzel',
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                    fontSize: 18,
                    color: premiumBlue,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white, // Pure white for better readability
                    fontSize: 15,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SubscriptionScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: premiumBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'UPGRADE NOW',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'MAYBE LATER',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
