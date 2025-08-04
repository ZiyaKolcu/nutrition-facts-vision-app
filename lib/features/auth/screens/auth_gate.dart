import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/bottom_nav/navigation_controller.dart';
import '../../../shared/bottom_nav/custom_bottom_nav.dart';
import '../../profile/profile_screen.dart';
import '../../scan/scan_screen.dart';
import '../../home/home_screen.dart';
import 'signin_screen.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          return const _MainScreen();
        }

        return const SignInScreen();
      },
    );
  }
}

class _MainScreen extends ConsumerWidget {
  const _MainScreen();

  static final _screens = [
    const ScanScreen(),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(navIndexProvider);
    return Scaffold(
      body: IndexedStack(index: index, children: _screens),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
