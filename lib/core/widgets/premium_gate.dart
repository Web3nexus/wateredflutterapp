import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Watered/features/auth/providers/auth_provider.dart';
import 'package:Watered/features/subscription/screens/subscription_screen.dart';
import 'package:Watered/features/home/providers/tab_provider.dart';

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

class _LockedOverlay extends ConsumerWidget {
  final String message;
  final Widget child;

  const _LockedOverlay({required this.message, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(32),
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A), // Fully opaque background to hide what's behind
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: premiumBlue.withValues(alpha: 0.3), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 50,
                      spreadRadius: 20,
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
                        Icons.auto_awesome_rounded,
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
                        fontFamily: 'Outfit',
                        color: Colors.white,
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
                          side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
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
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        } else {
                          ref.read(tabIndexProvider.notifier).state = 0;
                        }
                      },
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
          ),
        ),
      ],
    );
  }
}
