import 'package:dtrade/bottomsheet/addItem/AddItemManuallyViewModel.dart';
import 'package:dtrade/bottomsheet/addItem/data/ChipItem.dart';
import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/data/DataDropDownCategory.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:dtrade/extension/Mocked.dart';
import 'package:dtrade/extension/Rules.dart';
import 'package:dtrade/extension/TextFormatter.dart';
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
  late TextEditingController priceItem;
  late TextEditingController valueImplicit;
  late TextEditingController valueAffix;

  int dropValue = -1;
  int dropValueRarity = -1;
  int dropValueSacred = -1;
  int dropValueImplicit = -1;
  int dropValueAffix = -1;

  late List<ChipItem> listImplict;
  late List<ChipItem> listAffix;

  final List<DataDropDownCategory> dropDownRarity = Mocked.listItemsRarity;
  final List<DataDropDownCategory> dropDownSacred = Mocked.listItemsTier;

  late List<DropdownMenuItem<int>> itemListRarity;
  late List<DropdownMenuItem<int>> itemListSacred;

  @override
  void initState() {
    final model = ref.read(addItemManuallyViewModel);
    model.getListItemType(widget.categoryName);

    var desc = '';
    nameItem =
        TextEditingController(text: widget.nameItem.replaceAll("\n", " "));
    itemPower = TextEditingController(text: widget.itemPower);
    lvlRankItem = TextEditingController(text: widget.lvlRankItem);
    priceItem = TextEditingController(text: "");
    valueImplicit = TextEditingController(text: "0.0");
    valueAffix = TextEditingController(text: "0.0");
    listImplict = [];
    listAffix = [];

    for (var element in widget.description) {
      desc += "$element\n";
    }

    description = TextEditingController(text: desc);

    model.dropDownItemsCategory
        .map((val) => DropdownMenuItem<int>(
            value: val.value,
            child: Text(val.nameCategory, style: GoogleFonts.roboto())))
        .toList();

    DataDropDownCategory itemCategory = model.dropDownItemsCategory.firstWhere(
      (category) => category.nameCategory == widget.categoryName,
      orElse: () => const DataDropDownCategory(
          value: -1, nameCategory: 'Select an Equipament'),
    );

    if (itemCategory.nameCategory == widget.categoryName) {
      dropValue = itemCategory.value;
    }

    DataDropDownCategory itemRarity = dropDownRarity.firstWhere(
      (category) => category.nameCategory == widget.rarity,
      orElse: () => const DataDropDownCategory(value: 3, nameCategory: 'Rare'),
    );
    if (itemRarity.nameCategory == widget.rarity) {
      dropValueRarity = itemRarity.value;
    }

    DataDropDownCategory itemTier = dropDownSacred.firstWhere(
      (category) => category.nameCategory == widget.sacredItem,
      orElse: () =>
          const DataDropDownCategory(value: 3, nameCategory: 'Ancestral'),
    );
    if (itemTier.nameCategory == widget.sacredItem) {
      dropValueSacred = itemTier.value;
    }

    super.initState();
  }

  @override
  void dispose() {
    nameItem.dispose();
    itemPower.dispose();
    lvlRankItem.dispose();
    description.dispose();
    priceItem.dispose();
    valueImplicit.dispose();
    valueAffix.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(addItemManuallyViewModel);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              const SizedBox(height: 24),
              titleScreen('Adicionar Item'),
              const SizedBox(height: 32),
              TextFormField(
                controller: nameItem,
                validator: (value) {
                  return model.validateNameItem(value!);
                },
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(fontFamily: 'Diablo'),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.document_scanner,
                  ),
                ),
                style: const TextStyle(fontFamily: 'Diablo'),
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
                      labelStyle: TextStyle(fontFamily: 'Diablo'),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.bolt,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextFormField(
                    controller: priceItem,
                    validator: (value) {
                      return model.validatePriceItem(value!);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Price',
                      labelStyle: TextStyle(fontFamily: 'Diablo'),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.money_off_outlined,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [CustomNumberFormatter()],
                  ),
                ),
              ]),
              const SizedBox(
                height: 16,
              ),
              if (model.dropDownImplicit.isNotEmpty) dropDownImplicit(),
              dropDownAffixes(),
              const SizedBox(
                height: 64,
              ),
              FkFProgressButton(
                title: 'ABRIR LEILÃO',
                bgColorButton: ColorTheme.colorFirst,
                textColorButton: Colors.white,
                colorProgress: Colors.white,
                onPressedCallback: () async {
                  if (formKey.currentState!.validate()) {
                    model
                        .addItem(
                            nameItem.text,
                            itemPower.text,
                            priceItem.text,
                            description.text,
                            dropValue,
                            dropValueSacred,
                            dropValueRarity,
                            widget.lvlRankItem.isEmpty
                                ? 3
                                : int.parse(widget.lvlRankItem))
                        .then((value) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(value.message)));
                      if (value.status == 'OK') {
                        Future.delayed(const Duration(seconds: 2))
                            .then((value) => Navigator.of(context).pop());
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 8),
              FkFProgressButton(
                  onPressedCallback: () async {
                    Navigator.pop(context);
                  },
                  title: 'VOLTAR',
                  bgColorButton: Colors.black,
                  textColorButton: Colors.white,
                  colorProgress: Colors.white)
            ]),
          ))),
    );
  }

  Widget dropDownImplicit() {
    final model = ref.watch(addItemManuallyViewModel);

    bool _ = false;

    return Column(
      children: [
        const Row(
          children: [
            Text(
              'Implicits',
              style: TextStyle(fontFamily: 'Diablo', fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: DropdownButtonFormField<int>(
              isExpanded: true,
              value: dropValueImplicit,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.line_axis_outlined)),
              onChanged: (int? newValue) {
                model.dropDownImplicit.first.nameCategory != 'Loading...'
                    ? setState(() {
                        dropValueImplicit = newValue ?? -1;
                      })
                    : null;
              },
              disabledHint: const Text(
                "Loading...",
                style: TextStyle(fontFamily: 'Diablo'),
              ),
              items: model.dropDownImplicit
                  .map((val) => DropdownMenuItem<int>(
                      value: val.value,
                      child: Text(val.nameCategory,
                          style: const TextStyle(fontFamily: 'Diablo'))))
                  .toList(),
            )),
            const SizedBox(
              width: 4,
            ),
            SizedBox(
                width: 80,
                child: TextFormField(
                  controller: valueImplicit,
                  decoration: const InputDecoration(
                      labelText: 'Value',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontFamily: 'Diablo')),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontFamily: 'Diablo'),
                )),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        FkFProgressButton(
            onPressedCallback: () async {
              if (dropValueImplicit != -1 &&
                  double.parse(valueImplicit.text) != 0) {
                setState(() {
                  listImplict.add(ChipItem(
                      id: dropValueImplicit,
                      value: valueImplicit.text,
                      item: model.dropDownImplicit
                          .firstWhere(
                              (element) => element.value == dropValueImplicit)
                          .nameCategory));
                });
              }
            },
            title: 'ADICIONAR IMPLICÍTO',
            bgColorButton: Colors.black,
            textColorButton: Colors.white,
            colorProgress: Colors.white),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          spacing: 3.0,
          runSpacing: 6.0,
          children: [
            for (var element in listImplict)
              ActionChip(
                  elevation: 8.0,
                  padding: const EdgeInsets.all(2.0),
                  avatar: const Icon(Icons.delete),
                  backgroundColor: Colors.grey[200],
                  shape: const StadiumBorder(
                      side: BorderSide(
                    width: 1,
                    color: Colors.redAccent,
                  )),
                  label: Text(
                    '${element.value}% ${element.item}',
                    style: const TextStyle(fontFamily: 'Diablo'),
                  ))
          ],
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }

  Widget dropDownAffixes() {
    final model = ref.watch(addItemManuallyViewModel);

    return Column(
      children: [
        const Row(
          children: [
            Text(
              'AFFIX',
              style: TextStyle(fontFamily: 'Diablo', fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: DropdownButtonFormField<int>(
              isExpanded: true,
              value: dropValueAffix,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.line_axis_outlined)),
              onChanged: (int? newValue) {
                model.dropDownAffix.first.nameCategory != 'Carregando...'
                    ? setState(() {
                        dropValueAffix = newValue ?? 0;
                      })
                    : null;
              },
              disabledHint: const Text(
                'Carregando...',
                style: TextStyle(fontFamily: 'Diablo'),
              ),
              items: model.dropDownAffix
                  .map((val) => DropdownMenuItem<int>(
                      value: val.value,
                      child: Text(val.nameCategory,
                          style: const TextStyle(fontFamily: 'Diablo'))))
                  .toList(),
            )),
            const SizedBox(
              width: 4,
            ),
            SizedBox(
                width: 80,
                child: TextFormField(
                  controller: valueAffix,
                  decoration: const InputDecoration(
                      labelText: 'Value',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(fontFamily: 'Diablo')),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontFamily: 'Diablo'),
                )),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        FkFProgressButton(
            onPressedCallback: () async {
              if (dropValueAffix != -1 && double.parse(valueAffix.text) != 0) {
                setState(() {
                  listAffix.add(ChipItem(
                      id: dropValueAffix,
                      value: valueAffix.text,
                      item: model.dropDownAffix
                          .firstWhere(
                              (element) => element.value == dropValueAffix)
                          .nameCategory));
                });
              }
            },
            title: 'ADICIONAR AFIXO',
            bgColorButton: Colors.black,
            textColorButton: Colors.white,
            colorProgress: Colors.white),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          spacing: 3.0,
          runSpacing: 6.0,
          children: [
            for (var element in listAffix)
              ActionChip(
                  elevation: 8.0,
                  padding: const EdgeInsets.all(2.0),
                  avatar: const Icon(Icons.delete),
                  backgroundColor: Colors.grey[200],
                  shape: const StadiumBorder(
                      side: BorderSide(
                    width: 1,
                    color: Colors.redAccent,
                  )),
                  label: Text(
                    '${element.value}% ${element.item}',
                    style: const TextStyle(fontFamily: 'Diablo'),
                  ))
          ],
        )
      ],
    );
  }

  Widget dropDownTypeItem() {
    final model = ref.watch(addItemManuallyViewModel);

    return DropdownButtonFormField<int>(
        isExpanded: true,
        value: dropValue,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.line_axis_outlined)),
        onChanged: (int? newValue) {
          setState(() {
            dropValue = newValue ?? 0;
            dropValueAffix = -1;
            dropValueImplicit = -1;
            listAffix.clear();
            listImplict.clear();
          });
          model.getAffix(dropValue);
          model.getImplicit(dropValue);
        },
        items: model.dropDownItemsCategory
            .map((val) => DropdownMenuItem<int>(
                value: val.value,
                child: Text(val.nameCategory,
                    style: const TextStyle(fontFamily: 'Diablo'))))
            .toList(),
        validator: (value) {
          return model.validateDropDown(value!);
        });
  }
}
