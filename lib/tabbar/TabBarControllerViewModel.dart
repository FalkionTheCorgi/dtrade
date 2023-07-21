import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

final tabBarViewModel =
    ChangeNotifierProvider((ref) => TabBarControllerViewModel());

class TabBarControllerViewModel extends ChangeNotifier {
  File? file;

  void setFile(File newFile) {
    file = newFile;
    notifyListeners();
    analyzeImage(newFile.path);
  }

  void analyzeImage(String path) async {
    final InputImage inputImage = InputImage.fromFilePath(path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;
    for (TextBlock block in recognizedText.blocks) {
      final Rect rect = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        print("elements: ${line.text}");
        for (TextElement element in line.elements) {}
      }
    }
    textRecognizer.close();
  }
}
