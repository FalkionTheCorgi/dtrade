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
