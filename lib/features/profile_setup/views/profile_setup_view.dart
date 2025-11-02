import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/profile_setup_controller.dart';
import '../widgets/welcome_page.dart';
import '../widgets/gender_selection_page.dart';
import '../widgets/date_of_birth_page.dart';
import '../widgets/height_weight_page.dart';
import '../widgets/list_input_page.dart';
import '../../auth/screens/auth_gate.dart';

class ProfileSetupView extends ConsumerStatefulWidget {
  const ProfileSetupView({super.key});

  @override
  ConsumerState<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends ConsumerState<ProfileSetupView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 6) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeSetup() async {
    try {
      await ref.read(profileSetupProvider.notifier).completeSetup(ref);

      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthGate()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setup'),
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousPage,
              )
            : null,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentPage + 1) / 7,
            backgroundColor: Colors.grey[200],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                WelcomePage(onNext: _nextPage),
                GenderSelectionPage(onNext: _nextPage),
                DateOfBirthPage(onNext: _nextPage),
                HeightWeightPage(onNext: _nextPage),
                ListInputPage(
                  type: ListInputType.allergies,
                  onNext: _nextPage,
                ),
                ListInputPage(
                  type: ListInputType.healthConditions,
                  onNext: _nextPage,
                ),
                ListInputPage(
                  type: ListInputType.dietaryPreferences,
                  onNext: _completeSetup,
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
