import 'dart:convert';
import 'dart:io';
import 'package:dtrade/api/data/Affixes.dart';
import 'package:dtrade/api/data/Implicit.dart';
import 'package:dtrade/api/data/Items.dart';
import 'package:dtrade/api/data/Message.dart';
import 'package:dtrade/api/data/Sock.dart';
import 'package:dtrade/api/data/Tier.dart';
import 'package:dtrade/api/https.dart';
import 'package:dtrade/bottomsheet/addItem/data/ChipItem.dart';
import 'package:dtrade/data/DataDropDownCategory.dart';
import 'package:dtrade/extension/Mocked.dart';
import 'package:dtrade/extension/Regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addItemManuallyViewModel =
    ChangeNotifierProvider((ref) => AddItemManuallyViewModel());

class AddItemManuallyViewModel extends ChangeNotifier {
  final List<DataDropDownCategory> dropDownItemsCategory = [
    const DataDropDownCategory(value: -1, nameCategory: 'Loading...')
  ];
  final List<DataDropDownCategory> dropDownImplicit = [];

  final List<DataDropDownCategory> dropDownAffix = [
    const DataDropDownCategory(value: -1, nameCategory: 'Select an Equip')
  ];

  final List<DataDropDownCategory> dropDownSocket = [
    const DataDropDownCategory(value: -1, nameCategory: 'Socket')
  ];

  final List<DataDropDownCategory> dropDownSacred = [
    const DataDropDownCategory(value: -1, nameCategory: 'Select')
  ];

  void changeImplicit() {
    dropDownImplicit.clear();
    notifyListeners();
  }

  void noImplicit() {
    dropDownImplicit.clear();
    notifyListeners();
  }

  void changeAffix() {
    dropDownAffix.clear();
    dropDownAffix
        .add(const DataDropDownCategory(value: -1, nameCategory: 'Loading...'));
    notifyListeners();
  }

  void noAffix() {
    dropDownAffix.clear();
    dropDownAffix
        .add(const DataDropDownCategory(value: -1, nameCategory: 'No Affix'));
    notifyListeners();
  }

  String? validateNameItem(String str) {
    if (str.isEmpty) {
      return 'Empty Field.';
    } else if (RegExp(RegexData.nameItem).hasMatch(str)) {
      return null;
    } else {
      return 'Invalid Format.';
    }
  }

  String? validateLvlItem(String str) {
    if (str.isEmpty) {
      return 'Empty Field.';
    } else if (RegExp(RegexData.onlyNumber).hasMatch(str)) {
      return null;
    } else {
      return 'Formato Inválido';
    }
  }

  String? validateItemPower(String str) {
    if (str.isEmpty) {
      return 'Empty Field.';
    } else if (RegExp(RegexData.onlyNumber).hasMatch(str)) {
      return null;
    } else {
      return 'Invalid Format';
    }
  }

  String? validateDescriptionItem(String str) {
    if (str.isEmpty) {
      return 'Empty Field.';
    } else {
      return null;
    }
  }

  String? validateDropDown(int opt) {
    if (opt < 0) {
      return 'Select an option.';
    } else {
      return null;
    }
  }

  String? validatePriceItem(String str) {
    if (str.isEmpty) {
      return 'Empty Field.';
    } else {
      return null;
    }
  }

  String? validateArmor(String str) {
    if (str.isEmpty) {
      return 'Empty Field.';
    } else {
      return null;
    }
  }

  String convertImageToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String imagemBase64 = base64Encode(imageBytes);
    return imagemBase64;
  }

  Future<dynamic> getListItemType(String categoryName) async {
    final response = await Api.instance.getItems();
    if (response is Items) {
      dropDownItemsCategory.clear();
      dropDownItemsCategory
          .add(const DataDropDownCategory(value: -1, nameCategory: 'Select'));
      for (var item in response.item) {
        dropDownItemsCategory
            .add(DataDropDownCategory(value: item.id, nameCategory: item.item));
      }
      notifyListeners();
    }
  }

  Future<dynamic> getAffix(int id) async {
    changeAffix();
    final response = await Api.instance.getAffixes(id);
    if (response is Affixes) {
      dropDownAffix.clear();
      dropDownAffix
          .add(const DataDropDownCategory(value: -1, nameCategory: 'Select'));
      for (var item in response.item) {
        dropDownAffix.add(
            DataDropDownCategory(value: item.id, nameCategory: item.affixe));
      }
      notifyListeners();
    } else {
      noAffix();
    }
  }

  Future<dynamic> getTier() async {
    final response = await Api.instance.getTier();
    if (response is Tier) {
      dropDownSacred.clear();
      dropDownSacred
          .add(const DataDropDownCategory(value: -1, nameCategory: 'Select'));
      for (var sock in response.tierList) {
        dropDownSacred
            .add(DataDropDownCategory(value: sock.id, nameCategory: sock.tier));
      }
      notifyListeners();
    } else {
      dropDownSacred.clear();
      dropDownSacred.addAll(Mocked.listSocket);
    }
  }

  Future<dynamic> getSocket() async {
    final response = await Api.instance.getSockets();
    if (response is Sock) {
      dropDownSocket.clear();
      dropDownSocket
          .add(const DataDropDownCategory(value: -1, nameCategory: 'Socket'));
      for (var sock in response.socket) {
        dropDownSocket.add(DataDropDownCategory(
            value: sock.id, nameCategory: sock.quantidade.toString()));
      }
      notifyListeners();
    } else {
      dropDownSocket.clear();
      dropDownSocket.addAll(Mocked.listSocket);
    }
  }

  Future<dynamic> getImplicit(int id) async {
    changeImplicit();
    final response = await Api.instance.getImplicit(id);
    if (response is Implicit) {
      dropDownImplicit.clear();
      if (response.item.isNotEmpty) {
        dropDownImplicit
            .add(const DataDropDownCategory(value: -1, nameCategory: 'Select'));
        for (var item in response.item) {
          dropDownImplicit.add(DataDropDownCategory(
              value: item.id, nameCategory: item.implicit));
        }
      } else {
        noImplicit();
      }
      notifyListeners();
    } else {
      noImplicit();
    }
  }

  Future<Message> addItem(
      String name,
      String itemPower,
      String initialPrice,
      String description,
      int itemType,
      int itemTier,
      int itemRarity,
      int itemLevel,
      List<ChipItem> listImplict,
      List<ChipItem> listAffix,
      int armor,
      int damagePerSecond,
      int attackPerSecond,
      int damagePerHitMin,
      int damagePerHitMax,
      int socket) async {
    final response = await Api.instance.postItem(
        name,
        itemPower,
        initialPrice,
        description,
        itemType,
        itemTier,
        itemRarity,
        itemLevel,
        listImplict,
        listAffix,
        armor,
        damagePerSecond,
        attackPerSecond,
        damagePerHitMin,
        damagePerHitMax,
        socket);

    return response;
  }

  bool showDamageField(int show) {
    if (show == 1 ||
        show == 2 ||
        show == 3 ||
        show == 4 ||
        show == 5 ||
        show == 6 ||
        show == 7 ||
        show == 8 ||
        show == 9 ||
        show == 10 ||
        show == 11 ||
        show == 12 ||
        show == 13 ||
        show == 14 ||
        show == 24) {
      return true;
    } else {
      return false;
    }
  }

  bool showFieldArmor(int show) {
    if (show == 18 || show == 19 || show == 15 || show == 17 || show == 16) {
      return true;
    } else {
      return false;
    }
  }
}
