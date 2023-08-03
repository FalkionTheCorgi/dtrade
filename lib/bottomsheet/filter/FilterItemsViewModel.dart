import 'package:dtrade/api/data/Items.dart';
import 'package:dtrade/api/https.dart';
import 'package:dtrade/data/DataDropDownCategory.dart';
import 'package:dtrade/extension/Regex.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterItemsViewModel =
    ChangeNotifierProvider((ref) => FilterItemsViewModel());

class FilterItemsViewModel extends ChangeNotifier {

  final List<DataDropDownCategory> dropDownItemsCategory = [
    const DataDropDownCategory(value: -1, nameCategory: 'Carregando...')
  ];

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

  Future<dynamic> getListItemType() async {
    final response = await Api.instance.getItems();
    if (response is Items) {
      dropDownItemsCategory.clear();
      dropDownItemsCategory.add(
          const DataDropDownCategory(value: -1, nameCategory: 'Selecione'));
      for (var item in response.item) {
        dropDownItemsCategory
            .add(DataDropDownCategory(value: item.id, nameCategory: item.item));
      }
      notifyListeners();
    }
  }

}
