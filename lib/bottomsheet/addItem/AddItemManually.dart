import 'package:dtrade/api/data/Items.dart';
import 'package:dtrade/bottomsheet/addItem/AddItemManuallyViewModel.dart';
import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/data/DataDropDownCategory.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:dtrade/extension/Mocked.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AddItemManually extends ConsumerStatefulWidget {
  final String nameItem;
  final String categoryName;
  final String rarity;
  final String sacredItem;
  final String itemPower;
  final String lvlRankItem;
  final List<String> description;

  const AddItemManually(
      {Key? key,
      required this.nameItem,
      required this.categoryName,
      required this.rarity,
      required this.sacredItem,
      required this.itemPower,
      required this.lvlRankItem,
      required this.description})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AddItemManuallyState();
}

class AddItemManuallyState extends ConsumerState<AddItemManually> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameItem;
  late TextEditingController itemPower;
  late TextEditingController lvlRankItem;
  late TextEditingController description;

  int dropValue = -1;
  int dropValueRarity = -1;
  int dropValueSacred = -1;

  final List<DataDropDownCategory> dropDownRarity = [
    const DataDropDownCategory(value: -1, nameCategory: 'Select'),
    const DataDropDownCategory(value: 0, nameCategory: 'Common'),
    const DataDropDownCategory(value: 1, nameCategory: 'Magic'),
    const DataDropDownCategory(value: 2, nameCategory: 'Rare'),
  ];

  final List<DataDropDownCategory> dropDownSacred = [
    const DataDropDownCategory(value: -1, nameCategory: 'Select'),
    const DataDropDownCategory(value: 0, nameCategory: 'Normal'),
    const DataDropDownCategory(value: 1, nameCategory: 'Sacred'),
    const DataDropDownCategory(value: 2, nameCategory: 'Ancestral'),
  ];

  final List<DataDropDownCategory> dropDownItemsCategory = [
    const DataDropDownCategory(value: -1, nameCategory: 'Carregando...')
  ];

  late List<DropdownMenuItem<int>> itemListRarity;
  late List<DropdownMenuItem<int>> itemListSacred;

  @override
  void initState() {
    var desc = '';
    nameItem = TextEditingController(text: widget.nameItem);
    itemPower = TextEditingController(text: widget.itemPower);
    lvlRankItem = TextEditingController(text: widget.lvlRankItem);

    for (var element in widget.description) {
      desc += "$element\n";
    }

    description = TextEditingController(text: desc);
    dropDownItemsCategory
        .map((val) => DropdownMenuItem<int>(
            value: val.value,
            child: Text(val.nameCategory, style: GoogleFonts.roboto())))
        .toList();

    super.initState();
  }

  @override
  void dispose() {
    nameItem.dispose();
    itemPower.dispose();
    lvlRankItem.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(addItemManuallyViewModel);

    return SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const SizedBox(height: 24),
                    Text(
                      "Adicionar Item",
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: nameItem,
                      validator: (value) {
                        return model.validateNameItem(value!);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.document_scanner,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    dropDownTypeItem(),
                    const SizedBox(height: 16),
                    Row(children: [
                      Expanded(
                        child: TextFormField(
                          controller: itemPower,
                          validator: (value) {
                            return model.validateItemPower(value!);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Item Power',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(
                              Icons.bolt,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 4),
                    Row(children: [
                      const Icon(Icons.camera_alt_outlined),
                      TextButton(
                          onPressed: () {},
                          child: const Text('Adicionar imagem do item'))
                    ]),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: description,
                      validator: (value) {
                        return model.validateDescriptionItem(value!);
                      },
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Descrição Item',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    FkFProgressButton(
                      title: 'ABRIR LEILÃO',
                      bgColorButton: ColorTheme.colorFirst,
                      textColorButton: Colors.white,
                      colorProgress: Colors.white,
                      onPressedCallback: () async {
                        if (formKey.currentState!.validate()) {}
                      },
                    ),
                    const SizedBox(height: 8),
                    FkFProgressButton(
                        onPressedCallback: () async {
                          Navigator.pop(context);
                        },
                        title: 'FECHAR',
                        bgColorButton: Colors.black,
                        textColorButton: Colors.white,
                        colorProgress: Colors.white)
                  ]),
                ))));
  }

  Widget dropDownTypeItem() {
    final model = ref.watch(addItemManuallyViewModel);

    return FutureBuilder(
        future: model.getListItemType(widget.categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
          } else if (snapshot.hasError) {
            dropDownItemsCategory.clear();
            dropDownItemsCategory.add(const DataDropDownCategory(
                value: -1, nameCategory: 'Selecione'));
            for (var item in Mocked.listItemsCategory) {
              dropDownItemsCategory.add(item);
            }
          } else {
            Items items = snapshot.data as Items;
            dropDownItemsCategory.clear();
            dropDownItemsCategory.add(const DataDropDownCategory(
                value: -1, nameCategory: 'Selecione'));
            for (var item in items.item) {
              dropDownItemsCategory.add(DataDropDownCategory(
                  value: item.id, nameCategory: item.item));
            }
          }
          DataDropDownCategory itemCategory = dropDownItemsCategory.firstWhere(
            (category) => category.nameCategory == widget.categoryName,
            orElse: () => const DataDropDownCategory(
                value: -1, nameCategory: 'Not Found'),
          );
          if (itemCategory.nameCategory == widget.categoryName) {
            dropValue = itemCategory.value;
          }
          return DropdownButtonFormField<int>(
              value: dropValue,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.line_axis_outlined)),
              onChanged: (int? newValue) {
                setState(() {
                  dropValue = newValue ?? 0;
                });
              },
              items: dropDownItemsCategory
                  .map((val) => DropdownMenuItem<int>(
                      value: val.value,
                      child:
                          Text(val.nameCategory, style: GoogleFonts.roboto())))
                  .toList(),
              validator: (value) {
                return model.validateDropDown(value!);
              });
        });
  }
}
