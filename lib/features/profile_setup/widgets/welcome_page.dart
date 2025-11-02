import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final VoidCallback onNext;

  const WelcomePage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_add, size: 80, color: Theme.of(context).primaryColor),
          const SizedBox(height: 24),
          Text(
            'Welcome!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s set up your profile to provide personalized nutrition recommendations.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: onNext,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}
