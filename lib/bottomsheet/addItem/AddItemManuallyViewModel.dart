import 'package:dtrade/extension/Regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addItemManuallyViewModel =
    ChangeNotifierProvider((ref) => AddItemManuallyViewModel());

class AddItemManuallyViewModel extends ChangeNotifier {
  String? validateNameItem(String str) {
    if (str.isEmpty) {
      return 'Campo vazio.';
    } else if (RegExp(RegexData.nameItem).hasMatch(str)) {
      return null;
    } else {
      return 'Formato Inválido.';
    }
  }

  String? validateLvlItem(String str) {
    if (str.isEmpty) {
      return 'Campo vazio.';
    } else {
      return null;
    }
  }

  String? validateItemPower(String str) {
    if (str.isEmpty) {
      return 'Campo vazio.';
    } else {
      return null;
    }
  }

  String? validateDescriptionItem(String str) {
    if (str.isEmpty) {
      return 'Campo vazio.';
    } else {
      return null;
    }
  }
}
