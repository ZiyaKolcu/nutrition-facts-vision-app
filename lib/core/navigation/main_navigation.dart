import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../l10n/app_localizations.dart';
import '../../../features/scan/scan_screen.dart';
import '../../../features/home/home_screen.dart';
import '../../../features/profile/views/profile_view.dart';

final currentTabIndexProvider = StateProvider<int>((ref) => 1);

class MainNavigation extends ConsumerWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentIndex = ref.watch(currentTabIndexProvider);

    final List<Widget> screens = const [
      ScanScreen(),
      HomeScreen(),
      ProfileView(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          ref.read(currentTabIndexProvider.notifier).state = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_photo_alternate),
            label: l10n.newScanNav,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.homeNav,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: l10n.profileNav,
          ),
        ],
      ),
    );
  }
}
