import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrService {
  Future<String> recognizeTextFromImagePath(String imagePath) async {
    final File imageFile = File(imagePath);
    if (!await imageFile.exists()) {
      throw ArgumentError('Image file does not exist at path: $imagePath');
    }

    final InputImage inputImage = InputImage.fromFilePath(imagePath);
    final TextRecognizer textRecognizer = TextRecognizer(
      script: TextRecognitionScript.latin,
    );
    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );
      return recognizedText.text.trim();
    } finally {
      await textRecognizer.close();
    }
  }
}
