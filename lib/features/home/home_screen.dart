import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/scan_history_list.dart';
import '../profile/views/profile_view.dart';
import '../scan/scan_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Facts Vision'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ProfileView()));
            },
            tooltip: 'Profile',
          ),
        ],
      ),
      body: const ScanHistoryList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const ScanScreen()))
              .then((_) => ref.invalidate(scansProvider));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
