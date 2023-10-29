import 'dart:io';

import 'package:dtrade/data/DataItemRegister.dart';
import 'package:dtrade/extension/Regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

final addItemViewModel = ChangeNotifierProvider((ref) => AddItemViewModel());

class AddItemViewModel extends ChangeNotifier {
  File? file;

  DataItemRegister dataItem = DataItemRegister();

  bool bottomsheetType = false;

  bool loadingFile = false;

  void changeLoading() {
    loadingFile = !loadingFile;
    notifyListeners();
  }

  Future<void> setFile(File newFile) async {
    dataItem.file = newFile;
    changeLoading();
    notifyListeners();
    await analyzeImage(newFile.path);
    changeLoading();
  }

  void setFileWithoutAnalyze(File newFile) {
    file = newFile;
    notifyListeners();
  }

  Future<void> analyzeImage(String path) async {
    final InputImage inputImage = InputImage.fromFilePath(path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    //String text = recognizedText.text;
    for (TextBlock block in recognizedText.blocks) {
      //final Rect rect = block.boundingBox;
      //final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      //final List<String> languages = block.recognizedLanguages;
      fillIdentifyItem(text);

      /*for (TextLine line in block.lines) {
        //print("elements: ${line.text}");
      }*/
    }
    textRecognizer.close();

    /*if (dataItem.rarity == 'Legendary') {
      const SnackBar(
        content: Text('Não é possível trocar itens de raridade Lendários.'),
      );
      loadingFile = false;
      notifyListeners();
    } else {
      loadingFile = false;
      changeBottomSheet();
    }*/
  }

  void fillIdentifyItem(String str) {
    if (RegExp(RegexData.onlyUperLetter).hasMatch(str) &&
        dataItem.nameItem.isEmpty) {
      dataItem.nameItem += "${extractName(str)!} ";
      if (RegExp(RegexData.identifyTypeItem).hasMatch(str)) {
        final typeItem = extractRarityAndType(str);
        if (typeItem.length == 3) {
          dataItem.categoryName = typeItem[2];
          dataItem.rarity = typeItem[1];
          dataItem.sacredItem = typeItem[0];
        } else {
          dataItem.categoryName = typeItem[1];
          dataItem.rarity = typeItem[0];
        }
      }
    } else if (RegExp(RegexData.identifyTypeItem).hasMatch(str) &&
        dataItem.categoryName.isEmpty) {
      final typeItem = extractRarityAndType(str);
      if (typeItem.length == 3) {
        dataItem.categoryName = typeItem[2];
        dataItem.rarity = typeItem[1];
        dataItem.sacredItem = typeItem[0];
      } else {
        dataItem.categoryName = typeItem[1];
        dataItem.rarity = typeItem[0];
      }
    } else if (RegExp(RegexData.identifyItemPower).hasMatch(str) &&
        dataItem.itemPower.isEmpty) {
      dataItem.itemPower = extractItemPower(str);
    } else if (RegExp(RegexData.identifyLevelItem).hasMatch(str) &&
        dataItem.lvlRankItem.isEmpty) {
      dataItem.lvlRankItem = extrairNumeroRequiresLevel(str)!;
    } else if (elsePhraseAccept(str)) {
      dataItem.description.add(str);
    }
  }

  String? extractName(String frase) {
    RegExp padrao = RegExp(r'\b[A-Z\s]+\b');
    Iterable<Match> matches = padrao.allMatches(frase);

    if (matches.isNotEmpty) {
      return matches.first.group(0)!;
    } else {
      return ""; // Retorna uma string vazia se não encontrar nenhum nome completo.
    }
  }

  String extractItemPower(String frase) {
    RegExp padrao = RegExp(r"^(\d+)\s+Item\s+Power$");
    Match? match = padrao.firstMatch(frase);
    if (match != null) {
      return match.group(
          1)!; // O índice 0 representa o texto inteiro da correspondência, o índice 1 representa o grupo de captura (\d+).
    } else {
      return ""; // Retorna uma string vazia ou null se não houver correspondência.
    }
  }

  List<String> extractRarityAndType(String frase) {
    RegExp padrao = RegExp(
        r'\b(?:Ancestral|Sacred)?\s+(?:Common|Magic|Rare|Legendary|Unique)\s+(?:Axe|Bow|Dagger|Two-Handed Axe|Two-Handed Mace|Staff|Two-Handed Staff|Sword|Two-Handed Sword|Scythe|Two-Handed Scythe|Wand|Mace|Crossbow|Helm|Glove|Pants|Boots|Armor)\b');
    List<String> matches = padrao.firstMatch(frase)?.group(0)?.split(' ') ?? [];
    return matches;
  }

  String? extrairNumeroRequiresLevel(String texto) {
    RegExp padrao = RegExp(r"Requires Level (\d+)");
    Match? match = padrao.firstMatch(texto);

    if (match != null) {
      return match.group(
          1); // O índice 0 representa o texto inteiro da correspondência, o índice 1 representa o grupo de captura (\d+).
    } else {
      return ""; // Retorna null se não houver correspondência.
    }
  }

  bool elsePhraseAccept(String frase) {
    RegExp padrao = RegExp(
        r'^(?!.*(?:Sell Value:|Durability:|Binds to Account on Pickup)).*$');
    return padrao.hasMatch(frase);
  }
}
