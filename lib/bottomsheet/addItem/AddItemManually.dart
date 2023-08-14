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

  const AddItemManually({
    Key? key,
    required this.nameItem,
    required this.categoryName,
    required this.rarity,
    required this.sacredItem,
    required this.itemPower,
    required this.lvlRankItem,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AddItemManuallyState();
}

class AddItemManuallyState extends ConsumerState<AddItemManually> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameItem;
  late TextEditingController itemPower;
  late TextEditingController lvlRankItem;
  late TextEditingController priceItem;
  late TextEditingController valueImplicit;
  late TextEditingController valueAffix;
  late TextEditingController armor;
  late TextEditingController damagePerSecond;
  late TextEditingController attackPerSecond;
  late TextEditingController damagePerHitMin;
  late TextEditingController damagePerHitMax;

  int dropValue = -1;
  int dropValueRarity = -1;
  int dropValueSacred = -1;
  int dropValueImplicit = -1;
  int dropValueAffix = -1;
  int dropValueSocket = -1;

  late List<ChipItem> listImplict;
  late List<ChipItem> listAffix;

  final List<DataDropDownCategory> dropDownRarity = Mocked.listItemsRarity;
  late List<DropdownMenuItem<int>> itemListRarity;
  late List<DropdownMenuItem<int>> itemListSacred;

  @override
  void initState() {
    final model = ref.read(addItemManuallyViewModel);
    model.getListItemType(widget.categoryName);
    model.getSocket();
    model.getTier();

    nameItem =
        TextEditingController(text: widget.nameItem.replaceAll("\n", " "));
    itemPower = TextEditingController(text: widget.itemPower);
    lvlRankItem = TextEditingController(text: widget.lvlRankItem);
    priceItem = TextEditingController(text: "");
    valueImplicit = TextEditingController(text: "");
    valueAffix = TextEditingController(text: "");
    armor = TextEditingController(text: '');
    damagePerSecond = TextEditingController(text: '');
    attackPerSecond = TextEditingController(text: '');
    damagePerHitMin = TextEditingController(text: '');
    damagePerHitMax = TextEditingController(text: '');

    listImplict = [];
    listAffix = [];

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

    DataDropDownCategory itemTier = model.dropDownSacred.firstWhere(
      (category) => category.nameCategory == widget.sacredItem,
      orElse: () =>
          const DataDropDownCategory(value: -1, nameCategory: 'Select'),
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
    priceItem.dispose();
    valueImplicit.dispose();
    valueAffix.dispose();
    armor.dispose();
    damagePerSecond.dispose();
    attackPerSecond.dispose();
    damagePerHitMin.dispose();
    damagePerHitMax.dispose();
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
              titleScreen('Add Item'),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: TextFormField(
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
                  )),
                  const SizedBox(
                    width: 4,
                  ),
                  Flexible(child: dropDownSacredItem())
                ],
              ),
              const SizedBox(height: 16),
              dropDownTypeItem(),
              const SizedBox(height: 16),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  width: 4,
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
              if (model.showFieldArmor(dropValue)) fieldArmor(),
              if (model.showDamageField(dropValue)) fieldDamage(),
              const SizedBox(
                height: 16,
              ),
              if (model.dropDownImplicit.isNotEmpty) dropDownImplicit(),
              dropDownAffixes(),
              const SizedBox(
                height: 64,
              ),
              FkFProgressButton(
                title: 'ADD AUCTION',
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
                            dropValue,
                            dropValueSacred,
                            dropValueRarity,
                            int.parse(lvlRankItem.text),
                            listImplict,
                            listAffix,
                            int.parse(armor.text.isEmpty ? '0' : armor.text),
                            int.parse(damagePerSecond.text.isEmpty
                                ? '0'
                                : damagePerSecond.text),
                            int.parse(attackPerSecond.text.isEmpty
                                ? '0'
                                : attackPerSecond.text),
                            int.parse(damagePerHitMin.text.isEmpty
                                ? '0'
                                : damagePerHitMin.text),
                            int.parse(damagePerHitMax.text.isEmpty
                                ? '0'
                                : damagePerHitMax.text),
                            dropValueSocket)
                        .then((value) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(value.message)));
                      if (value.status == 'OK') {
                        Future.delayed(const Duration(seconds: 1))
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
                  title: 'GO BACK',
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
              onChanged:
                  model.dropDownImplicit.first.nameCategory != 'Loading...'
                      ? (int? newValue) {
                          setState(() {
                            dropValueImplicit = newValue ?? -1;
                          });
                        }
                      : null,
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
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  'Please, fill this fields correctly',
                  style: TextStyle(fontFamily: 'Diablo'),
                )));
              }
            },
            title: 'ADD IMPLICIT',
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
                  element.item.replaceAll('#', element.value),
                  style: const TextStyle(fontFamily: 'Diablo'),
                ),
                onPressed: () {
                  setState(() {
                    listImplict.removeWhere((obj) => obj.item == element.item);
                  });
                },
              )
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
              onChanged: model.dropDownAffix.first.nameCategory != 'Loading...'
                  ? (int? newValue) {
                      setState(() {
                        dropValueAffix = newValue ?? 0;
                      });
                    }
                  : null,
              disabledHint: const Text(
                'Loading...',
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
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  'Please, fill this fields correctly',
                  style: TextStyle(fontFamily: 'Diablo'),
                )));
              }
            },
            title: 'ADD AFFIX',
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
                    element.item.replaceAll('#', element.value),
                    style: const TextStyle(fontFamily: 'Diablo'),
                  ),
                  onPressed: () {
                    setState(() {
                      listAffix.removeWhere((obj) => obj.item == element.item);
                    });
                  })
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: dropDownSocket()),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: TextFormField(
                controller: lvlRankItem,
                validator: (value) {
                  return model.validatePriceItem(value!);
                },
                decoration: const InputDecoration(
                    labelText: 'Item Level',
                    labelStyle: TextStyle(fontFamily: 'Diablo'),
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
            )
          ],
        ),
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

  Widget dropDownSacredItem() {
    final model = ref.watch(addItemManuallyViewModel);

    return DropdownButtonFormField<int>(
        isExpanded: true,
        value: dropValueSacred,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.line_axis_outlined)),
        onChanged: widget.sacredItem.isNotEmpty && dropValueSacred != -1
            ? null
            : (int? newValue) {
                setState(() {
                  dropValueSacred = newValue ?? -1;
                });
              },
        disabledHint: Text(
          widget.sacredItem,
          style: const TextStyle(fontFamily: 'Diablo'),
        ),
        items: model.dropDownSacred
            .map((val) => DropdownMenuItem<int>(
                value: val.value,
                child: Text(val.nameCategory,
                    style: const TextStyle(fontFamily: 'Diablo'))))
            .toList(),
        validator: (value) {
          return model.validateDropDown(value!);
        });
  }

  Widget dropDownSocket() {
    final model = ref.watch(addItemManuallyViewModel);

    return DropdownButtonFormField<int>(
        isExpanded: true,
        value: dropValueSocket,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.line_axis_outlined)),
        onChanged: (int? newValue) {
          setState(() {
            dropValueSocket = newValue ?? -1;
          });
        },
        items: model.dropDownSocket
            .map((val) => DropdownMenuItem<int>(
                value: val.value,
                child: Text(val.nameCategory,
                    style: const TextStyle(fontFamily: 'Diablo'))))
            .toList(),
        validator: (value) {
          return model.validateDropDown(value!);
        });
  }

  Widget fieldArmor() {
    final model = ref.watch(addItemManuallyViewModel);
    return TextFormField(
        controller: armor,
        validator: (value) {
          return model.validateArmor(value!);
        },
        decoration: const InputDecoration(
          labelText: 'Armor',
          labelStyle: TextStyle(fontFamily: 'Diablo'),
          border: OutlineInputBorder(),
          prefixIcon: Icon(
            Icons.shield_outlined,
          ),
        ),
        keyboardType: TextInputType.number);
  }

  Widget fieldDamage() {
    final model = ref.watch(addItemManuallyViewModel);

    return Column(
      children: [
        TextFormField(
            controller: damagePerSecond,
            validator: (value) {
              return model.validateArmor(value!);
            },
            decoration: const InputDecoration(
                labelText: 'Damage per Second',
                labelStyle: TextStyle(fontFamily: 'Diablo'),
                border: OutlineInputBorder()),
            keyboardType: TextInputType.number),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
            controller: armor,
            validator: (value) {
              return model.validateArmor(value!);
            },
            decoration: const InputDecoration(
                labelText: 'Attack per Second',
                labelStyle: TextStyle(fontFamily: 'Diablo'),
                border: OutlineInputBorder()),
            keyboardType: TextInputType.number),
        const SizedBox(
          height: 16,
        ),
        const Row(children: [
          Expanded(
              child: Text(
            'Damage Per Hit',
            style: TextStyle(fontFamily: 'Diablo', fontSize: 18),
          )),
        ]),
        const SizedBox(
          height: 8,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: TextFormField(
                    controller: damagePerHitMin,
                    validator: (value) {
                      return model.validateArmor(value!);
                    },
                    decoration: const InputDecoration(
                        labelText: 'Min',
                        labelStyle: TextStyle(fontFamily: 'Diablo'),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.number)),
            const SizedBox(
              width: 4,
            ),
            Expanded(
                child: TextFormField(
                    controller: damagePerHitMax,
                    validator: (value) {
                      return model.validateArmor(value!);
                    },
                    decoration: const InputDecoration(
                        labelText: 'Max',
                        labelStyle: TextStyle(fontFamily: 'Diablo'),
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.number))
          ],
        )
      ],
    );
  }
}
