import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controllers/scan_controller.dart';
import '../../core/navigation/main_navigation.dart';
import '../home/widgets/scan_history_list.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final TextEditingController _titleController = TextEditingController();
  bool _showPhotoOptions = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _togglePhotoOptions() {
    setState(() {
      _showPhotoOptions = !_showPhotoOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScanState scanState = ref.watch(scanControllerProvider);
    final ScanController controller = ref.read(scanControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Scan'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter a title for the nutrition facts',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: controller.updateTitle,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: scanState.photos.isEmpty
                        ? const Center(child: Text('No photos added'))
                        : ListView.separated(
                            itemCount: scanState.photos.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final photo = scanState.photos[index];
                              return _PhotoCard(
                                imagePath: photo.imagePath,
                                isProcessing: photo.isProcessing,
                                onRemove: () =>
                                    controller.removePhoto(photo.id),
                              );
                            },
                          ),
                  ),
              if (scanState.errorMessage != null) ...[
                const SizedBox(height: 8),
                Text(
                  scanState.errorMessage!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              // Photo options (Camera/Gallery)
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                child: _showPhotoOptions
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: scanState.isProcessing
                                      ? null
                                      : () {
                                          _togglePhotoOptions();
                                          controller.pickImageFromCamera();
                                        },
                                  icon: const Icon(Icons.photo_camera),
                                  label: const Text('Camera'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: scanState.isProcessing
                                      ? null
                                      : () {
                                          _togglePhotoOptions();
                                          controller.pickImagesFromGallery();
                                        },
                                  icon: const Icon(Icons.collections),
                                  label: const Text('Gallery'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
              // Action buttons row
              SizedBox(
                height: 48,
                child: Builder(
                  builder: (context) {
                    final bool anyPhotoProcessing = scanState.photos.any(
                      (p) => p.isProcessing,
                    );
                    return Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: scanState.isProcessing
                                ? null
                                : _togglePhotoOptions,
                            icon: Icon(
                              _showPhotoOptions
                                  ? Icons.close
                                  : Icons.add_photo_alternate,
                            ),
                            label: const Text('Add Photo'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed:
                                (scanState.isProcessing || anyPhotoProcessing)
                                ? null
                                : () async {
                                    await controller.analyze();
                                    if (!context.mounted) return;
                                    // Check if analysis was successful (no error)
                                    final finalState = ref.read(scanControllerProvider);
                                    if (finalState.errorMessage == null) {
                                      // Clear the scan form
                                      controller.reset();
                                      _titleController.clear();
                                      // Refresh home screen
                                      ref.invalidate(scansProvider);
                                      // Switch to home tab
                                      ref.read(currentTabIndexProvider.notifier).state = 1;
                                    }
                                  },
                            child: (scanState.isProcessing || anyPhotoProcessing)
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Analyze'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  final String imagePath;
  final bool isProcessing;
  final VoidCallback onRemove;

  const _PhotoCard({
    required this.imagePath,
    required this.isProcessing,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.file(File(imagePath), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        Positioned(
          top: 6,
          right: 6,
          child: Material(
            color: Colors.black45,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.white),
              tooltip: 'Remove',
              onPressed: onRemove,
            ),
          ),
        ),
        if (isProcessing)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

