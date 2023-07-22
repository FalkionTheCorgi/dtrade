import 'package:dtrade/bottomsheet/filter/FilterItemsViewModel.dart';
import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/data/DataDropDownCategory.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterItems extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FilterItemsState();
}

class FilterItemsState extends ConsumerState<FilterItems> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameItem;
  late TextEditingController itemPower;
  late TextEditingController lvlRankItem;
  late TextEditingController description;

  int dropValue = -1;
  int dropValueRarity = -1;
  int dropValueSacred = -1;

  final List<DataDropDownCategory> dropDownItemsCategory = [
    const DataDropDownCategory(value: -1, nameCategory: 'Select'),
    const DataDropDownCategory(value: 0, nameCategory: 'Axe'),
    const DataDropDownCategory(value: 1, nameCategory: 'Bow'),
    const DataDropDownCategory(value: 2, nameCategory: 'Dagger'),
    const DataDropDownCategory(value: 3, nameCategory: 'Two-Handed Axe'),
    const DataDropDownCategory(value: 4, nameCategory: 'Two-Handed Mace'),
    const DataDropDownCategory(value: 5, nameCategory: 'Staff'),
    const DataDropDownCategory(value: 6, nameCategory: 'Two-Handed Staff'),
    const DataDropDownCategory(value: 7, nameCategory: 'Sword'),
    const DataDropDownCategory(value: 8, nameCategory: 'Two-Handed Sword'),
    const DataDropDownCategory(value: 9, nameCategory: 'Scythe'),
    const DataDropDownCategory(value: 10, nameCategory: 'Two-Handed Scythe'),
    const DataDropDownCategory(value: 11, nameCategory: 'Wand'),
    const DataDropDownCategory(value: 12, nameCategory: 'Mace'),
    const DataDropDownCategory(value: 13, nameCategory: 'Crossbow'),
    const DataDropDownCategory(value: 14, nameCategory: 'Helm'),
    const DataDropDownCategory(value: 15, nameCategory: 'Glove'),
    const DataDropDownCategory(value: 16, nameCategory: 'Pants'),
    const DataDropDownCategory(value: 17, nameCategory: 'Boots'),
    const DataDropDownCategory(value: 18, nameCategory: 'Armor'),
  ];

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

  late List<DropdownMenuItem<int>> itemListCategory;
  late List<DropdownMenuItem<int>> itemListRarity;
  late List<DropdownMenuItem<int>> itemListSacred;

  @override
  void initState() {
    nameItem = TextEditingController(text: "");
    itemPower = TextEditingController(text: "");
    lvlRankItem = TextEditingController(text: "");
    description = TextEditingController(text: "");

    itemListCategory = dropDownItemsCategory
        .map((val) => DropdownMenuItem<int>(
            value: val.value,
            child: Text(val.nameCategory, style: GoogleFonts.roboto())))
        .toList();

    itemListRarity = dropDownRarity
        .map((val) => DropdownMenuItem<int>(
            value: val.value,
            child: Text(val.nameCategory, style: GoogleFonts.roboto())))
        .toList();

    itemListSacred = dropDownSacred
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
    final model = ref.watch(filterItemsViewModel);

    return SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(height: 24),
                Text(
                  "Filtrar Items",
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
                DropdownButtonFormField<int>(
                    value: dropValue,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.line_axis_outlined)),
                    onChanged: (int? newValue) {
                      setState(() {
                        dropValue = newValue ?? 0;
                      });
                    },
                    items: itemListCategory,
                    validator: (value) {
                      return model.validateDropDown(value!);
                    }),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: dropValueSacred,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.priority_high)),
                        onChanged: (int? newValue) {
                          setState(() {
                            dropValueSacred = newValue ?? 0;
                          });
                        },
                        items: itemListSacred,
                        validator: (value) {
                          return model.validateDropDown(value!);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: dropValueRarity,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.diamond_outlined)),
                        onChanged: (int? newValue) {
                          setState(() {
                            dropValueRarity = newValue ?? 0;
                          });
                        },
                        items: itemListRarity,
                        validator: (value) {
                          return model.validateDropDown(value!);
                        },
                      ),
                    )
                  ],
                ),
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
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: lvlRankItem,
                      validator: (value) {
                        return model.validateLvlItem(value!);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Item Level',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.arrow_upward,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  )
                ]),
                const SizedBox(height: 16),
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
                  title: 'FILTRAR',
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
            )));
  }
}
