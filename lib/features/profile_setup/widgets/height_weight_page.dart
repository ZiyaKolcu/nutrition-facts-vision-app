import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/profile_setup_controller.dart';

class HeightWeightPage extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const HeightWeightPage({super.key, required this.onNext});

  @override
  ConsumerState<HeightWeightPage> createState() => _HeightWeightPageState();
}

class _HeightWeightPageState extends ConsumerState<HeightWeightPage> {
  late TextEditingController _heightController;
  late TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    final data = ref.read(profileSetupProvider);
    _heightController = TextEditingController(
      text: data.heightCm != null ? data.heightCm.toString() : '',
    );
    _weightController = TextEditingController(
      text: data.weightKg != null ? data.weightKg.toString() : '',
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(profileSetupProvider);
    final controller = ref.read(profileSetupProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            'Your body measurements',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Height (cm)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.height),
            ),
            onChanged: (value) {
              controller.setHeight(int.tryParse(value));
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Weight (kg)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.monitor_weight),
            ),
            onChanged: (value) {
              controller.setWeight(int.tryParse(value));
            },
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: data.isHeightWeightValid ? widget.onNext : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
