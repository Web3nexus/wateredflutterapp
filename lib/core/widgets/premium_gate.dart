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
    final theme = Theme.of(context);
    
    return Stack(
      children: [
        // Blurred/Dimmed child
        AbsorbPointer(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
            child: child,
          ),
        ),
        // Premium Message overlay
        Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B).withOpacity(0.95),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD4AF37).withOpacity(0.1),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.lock_person_rounded,
                  color: Color(0xFFD4AF37),
                  size: 48,
                ),
                const SizedBox(height: 16),
                const Text(
                  'PREMIUM CONTENT',
                  style: TextStyle(
                    fontFamily: 'Cinzel',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Color(0xFFD4AF37),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SubscriptionScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4AF37),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: const Text(
                    'GET PLUS+',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
