import 'package:dtrade/bottomsheet/addItem/AddItemImage.dart';
import 'package:dtrade/bottomsheet/addItem/AddItemManually.dart';
import 'package:dtrade/bottomsheet/addItem/AddItemViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddItem extends ConsumerStatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AddItemState();
}

class AddItemState extends ConsumerState<AddItem> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(addItemViewModel);
    if (model.bottomsheetType) {
      return AnimatedSize(
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 500),
          child: AddItemManually(
              nameItem: model.dataItem.nameItem.trimRight(),
              categoryName: model.dataItem.categoryName,
              rarity: model.dataItem.rarity,
              sacredItem: model.dataItem.sacredItem,
              itemPower: model.dataItem.itemPower,
              lvlRankItem: model.dataItem.lvlRankItem,
              description: model.dataItem.description));
    } else {
      if (!model.loadingFile) {
        return AnimatedSize(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 500),
            child: AddItemImage());
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }
  }
}
