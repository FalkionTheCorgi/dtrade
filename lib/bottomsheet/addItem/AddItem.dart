import 'package:dtrade/bottomsheet/addItem/AddItemImage.dart';
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
    double width = MediaQuery.of(context).size.width;
    final model = ref.watch(addItemViewModel);
    if (!model.loadingFile) {
      return const AddItemImage();
    } else {
      return SizedBox(
        width: width,
        height: 60,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [Center(child: CircularProgressIndicator())],
        ),
      );
    }
  }
}
