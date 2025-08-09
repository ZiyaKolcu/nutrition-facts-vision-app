import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../data/scan_repository.dart';
import '../services/ocr_service.dart';

class ScannedPhoto {
  final String id;
  final String imagePath;
  final String extractedText;
  final bool isProcessing;

  const ScannedPhoto({
    required this.id,
    required this.imagePath,
    this.extractedText = '',
    this.isProcessing = false,
  });

  ScannedPhoto copyWith({
    String? id,
    String? imagePath,
    String? extractedText,
    bool? isProcessing,
  }) {
    return ScannedPhoto(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      extractedText: extractedText ?? this.extractedText,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

class ScanState {
  final List<ScannedPhoto> photos;
  final bool isProcessing;
  final String? errorMessage;
  final String title;

  const ScanState({
    this.photos = const [],
    this.isProcessing = false,
    this.errorMessage,
    this.title = '',
  });

  ScanState copyWith({
    List<ScannedPhoto>? photos,
    bool? isProcessing,
    String? errorMessage,
    String? title,
  }) {
    return ScanState(
      photos: photos ?? this.photos,
      isProcessing: isProcessing ?? this.isProcessing,
      errorMessage: errorMessage,
      title: title ?? this.title,
    );
  }
}

class ScanController extends StateNotifier<ScanState> {
  final Ref ref;
  final ImagePicker _picker = ImagePicker();
  int _idCounter = 0;

  ScanController(this.ref) : super(const ScanState());

  Future<void> pickImageFromCamera() async {
    try {
      state = state.copyWith(isProcessing: true, errorMessage: null);
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) {
        state = state.copyWith(isProcessing: false);
        return;
      }
      await _addPhotoAndRunOcr(image.path);
      state = state.copyWith(isProcessing: false);
    } catch (e) {
      state = state.copyWith(isProcessing: false, errorMessage: e.toString());
    }
  }

  Future<void> pickImagesFromGallery() async {
    try {
      state = state.copyWith(isProcessing: true, errorMessage: null);
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isEmpty) {
        state = state.copyWith(isProcessing: false);
        return;
      }
      for (final XFile img in images) {
        await _addPhotoAndRunOcr(img.path);
      }
      state = state.copyWith(isProcessing: false);
    } catch (e) {
      state = state.copyWith(isProcessing: false, errorMessage: e.toString());
    }
  }

  Future<void> _addPhotoAndRunOcr(String imagePath) async {
    final String id = (++_idCounter).toString();
    final ScannedPhoto pending = ScannedPhoto(
      id: id,
      imagePath: imagePath,
      isProcessing: true,
    );
    state = state.copyWith(photos: [...state.photos, pending]);

    final ocr = ref.read(ocrServiceProvider);
    try {
      final String text = await ocr.recognizeTextFromImagePath(imagePath);
      _updatePhoto(
        id,
        (p) => p.copyWith(extractedText: text, isProcessing: false),
      );
    } catch (e) {
      _updatePhoto(id, (p) => p.copyWith(isProcessing: false));
      state = state.copyWith(errorMessage: 'OCR failed: $e');
    }
  }

  void _updatePhoto(String id, ScannedPhoto Function(ScannedPhoto) transform) {
    final List<ScannedPhoto> updated = state.photos
        .map((p) => p.id == id ? transform(p) : p)
        .toList(growable: false);
    state = state.copyWith(photos: updated);
  }

  void removePhoto(String id) {
    final List<ScannedPhoto> updated = state.photos
        .where((p) => p.id != id)
        .toList(growable: false);
    state = state.copyWith(photos: updated);
  }

  void updateTitle(String value) {
    state = state.copyWith(title: value);
  }

  Future<void> analyze() async {
    final repo = ref.read(scanRepositoryProvider);
    final items = state.photos
        .map(
          (photo) => ScanGroupItem(
            imagePath: photo.imagePath,
            text: photo.extractedText,
          ),
        )
        .toList(growable: false);

    await repo.analyze(items: items, title: state.title);
  }
}

final ocrServiceProvider = Provider<OcrService>((ref) => OcrService());
final scanControllerProvider = StateNotifierProvider<ScanController, ScanState>(
  (ref) {
    return ScanController(ref);
  },
);
