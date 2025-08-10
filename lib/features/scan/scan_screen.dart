import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controllers/scan_controller.dart';
import '../../core/theme/app_colors.dart';

class ScanScreen extends ConsumerWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScanState scanState = ref.watch(scanControllerProvider);
    final ScanController controller = ref.read(scanControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('New Scan')),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Nutrition Facts Title',
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
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.error),
                    ),
                  ],
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 48,
                    child: Builder(
                      builder: (context) {
                        final bool anyPhotoProcessing = scanState.photos.any(
                          (p) => p.isProcessing,
                        );
                        return ElevatedButton(
                          onPressed:
                              (scanState.isProcessing || anyPhotoProcessing)
                              ? null
                              : () async {
                                  await controller.analyze();
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16,
              bottom: 80, // leave room for Analyze button
              child: _AddPhotoFab(
                disabled: scanState.isProcessing,
                onCamera: controller.pickImageFromCamera,
                onGallery: controller.pickImagesFromGallery,
              ),
            ),
          ],
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

class _AddPhotoFab extends StatefulWidget {
  final bool disabled;
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  const _AddPhotoFab({
    required this.disabled,
    required this.onCamera,
    required this.onGallery,
  });

  @override
  State<_AddPhotoFab> createState() => _AddPhotoFabState();
}

class _AddPhotoFabState extends State<_AddPhotoFab>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  void _toggle() {
    if (widget.disabled) return;
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AnimatedSlide(
          duration: const Duration(milliseconds: 180),
          offset: _expanded ? Offset.zero : const Offset(0, 0.2),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: _expanded ? 1 : 0,
            child: _ActionButton(
              icon: Icons.photo_camera,
              label: 'Camera',
              onPressed: widget.disabled
                  ? null
                  : () {
                      _toggle();
                      widget.onCamera();
                    },
            ),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedSlide(
          duration: const Duration(milliseconds: 180),
          offset: _expanded ? Offset.zero : const Offset(0, 0.2),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: _expanded ? 1 : 0,
            child: _ActionButton(
              icon: Icons.collections,
              label: 'Gallery',
              onPressed: widget.disabled
                  ? null
                  : () {
                      _toggle();
                      widget.onGallery();
                    },
            ),
          ),
        ),
        const SizedBox(height: 12),
        FloatingActionButton.extended(
          heroTag: 'addPhotoFab',
          onPressed: widget.disabled ? null : _toggle,
          icon: Icon(_expanded ? Icons.close : Icons.add_photo_alternate),
          label: const Text('Add Photo'),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: const Size(140, 40),
        shape: const StadiumBorder(),
        elevation: 2,
      ),
    );
  }
}
