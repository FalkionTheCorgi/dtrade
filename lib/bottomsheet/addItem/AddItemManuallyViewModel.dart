import 'dart:convert';
import 'dart:io';
import 'package:dtrade/api/data/Items.dart';
import 'package:dtrade/api/data/Message.dart';
import 'package:dtrade/api/https.dart';
import 'package:dtrade/data/DataDropDownCategory.dart';
import 'package:dtrade/extension/Regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addItemManuallyViewModel =
    ChangeNotifierProvider((ref) => AddItemManuallyViewModel());

class AddItemManuallyViewModel extends ChangeNotifier {
  late List<DataDropDownCategory> dropDownItemsCategory;
  int dropValue = -1;

  void initList() {
    dropDownItemsCategory = [
      const DataDropDownCategory(value: -1, nameCategory: 'Carregando...'),
    ];
  }

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
    } else if (RegExp(RegexData.onlyNumber).hasMatch(str)) {
      return null;
    } else {
      return 'Formato Inválido';
    }
  }

  String? validateItemPower(String str) {
    if (str.isEmpty) {
      return 'Campo vazio.';
    } else if (RegExp(RegexData.onlyNumber).hasMatch(str)) {
      return null;
    } else {
      return 'Formato Inválido';
    }
  }

  String? validateDescriptionItem(String str) {
    if (str.isEmpty) {
      return 'Campo vazio.';
    } else {
      return null;
    }
  }

  String? validateDropDown(int opt) {
    if (opt < 0) {
      return 'Selecione uma opção.';
    } else {
      return null;
    }
  }

  String? validatePriceItem(String str) {
    if (str.isEmpty) {
      return 'Campo vazio.';
    } else {
      return null;
    }
  }

  String convertImageToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String imagemBase64 = base64Encode(imageBytes);
    return imagemBase64;
  }

  Future<Items?> getListItemType(String categoryName) async {
    return await Api.instance.getItems();
  }

  Future<Message> addItem(
      String name,
      String itemPower,
      String initialPrice,
      String description,
      int itemType,
      int itemTier,
      int itemRarity,
      int itemLevel) async {
    final response = Api.instance.postItem(
        name,
        itemPower,
        initialPrice,
        description,
        itemType,
        itemTier,
        itemRarity,
        itemLevel);

    return response;
  }
}
