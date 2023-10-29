import 'package:dtrade/addItem/data/ChipItem.dart';
import 'package:dtrade/filter/FilterItemsViewModel.dart';
import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/drawer/DrawerLayoutViewModel.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:dtrade/listitems/ListLeilaoViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterItems extends ConsumerStatefulWidget {
  int screenFilter;

  FilterItems({Key? key, required this.screenFilter}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FilterItemsState();
}

class FilterItemsState extends ConsumerState<FilterItems> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameItem;
  late TextEditingController minPower;
  late TextEditingController maxPower;
  late TextEditingController lvlRankItem;
  late TextEditingController valueImplicit;
  late TextEditingController valueAffix;
  late TextEditingController armor;
  late TextEditingController damagePerSecond;
  late TextEditingController attackPerSecond;
  late TextEditingController damagePerHitMin;
  late TextEditingController damagePerHitMax;

  int dropValue = -1;
  int dropValueSacred = -1;
  int dropValueImplicit = -1;
  int dropValueAffix = -1;
  int dropValueSocket = -1;

  late List<ChipItem> listImplict;
  late List<ChipItem> listAffix;

  @override
  void initState() {
    final model = ref.read(filterItemsViewModel);
    final drawerModel = ref.read(drawerLayoutViewModel);
    model.getListItemType(drawerModel.returnIntItemChoose());

    nameItem = TextEditingController(text: '');
    minPower = TextEditingController(text: '0');
    maxPower = TextEditingController(text: '');
    lvlRankItem = TextEditingController(text: '');
    valueImplicit = TextEditingController(text: "0.0");
    valueAffix = TextEditingController(text: "0.0");
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

    super.initState();
  }

  @override
  void dispose() {
    nameItem.dispose();
    minPower.dispose();
    maxPower.dispose();
    lvlRankItem.dispose();
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
    final model = ref.watch(filterItemsViewModel);
    final listModel = ref.watch(listLeilaoViewModel);
    final drawerModel = ref.watch(drawerLayoutViewModel);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(height: 24),
                Text(
                  "Filtrar Item",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(fontSize: 24)),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: nameItem,
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
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                    child: TextFormField(
                      controller: minPower,
                      decoration: const InputDecoration(
                        labelText: 'Min Power',
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
                      controller: maxPower,
                      decoration: const InputDecoration(
                          labelText: 'Max Power',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.bolt,
                          ),
                          errorStyle: TextStyle()),
                      keyboardType: TextInputType.number,
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
                        decoration: const InputDecoration(
                            labelText: 'Item Level',
                            labelStyle: TextStyle(fontFamily: 'Diablo'),
                            border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                FkFProgressButton(
                  title: 'FILTER',
                  bgColorButton: ColorTheme.colorFirst,
                  textColorButton: Colors.white,
                  colorProgress: Colors.white,
                  onPressedCallback: () async {
                    if (formKey.currentState!.validate()) {
                      final affix =
                          listAffix.map((chipItem) => chipItem.item).toList();

                      final implicit =
                          listImplict.map((chipItem) => chipItem.item).toList();

                      listModel.resetList();

                      listModel.setValues(
                          nameItem.text.isEmpty ? null : nameItem.text,
                          dropValue == -1 ? null : dropValue,
                          minPower.text.isEmpty ? '0' : minPower.text,
                          maxPower.text.isEmpty ? '2000' : maxPower.text,
                          2,
                          3,
                          lvlRankItem.text.isEmpty
                              ? null
                              : int.parse(lvlRankItem.text),
                          armor.text.isEmpty ? null : int.parse(armor.text),
                          damagePerSecond.text.isEmpty
                              ? null
                              : int.parse(damagePerSecond.text),
                          damagePerHitMin.text.isEmpty
                              ? null
                              : int.parse(damagePerHitMin.text),
                          damagePerHitMax.text.isEmpty
                              ? null
                              : int.parse(damagePerHitMax.text),
                          affix.isEmpty ? null : affix,
                          implicit.isEmpty ? null : implicit,
                          dropValueSocket == -1 ? null : dropValueSocket);
                      listModel.getList(drawerModel.returnIntItemChoose());
                      Navigator.of(context).pop();
                    }
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
            ),
          )),
    );
  }

  Widget dropDownTypeItem() {
    final model = ref.watch(filterItemsViewModel);

    return DropdownButtonFormField<int>(
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
              child: Text(val.nameCategory, style: GoogleFonts.roboto())))
          .toList(),
    );
  }

  Widget dropDownImplicit() {
    final model = ref.watch(filterItemsViewModel);

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
    final model = ref.watch(filterItemsViewModel);

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
      ],
    );
  }

  Widget dropDownSacredItem() {
    final model = ref.watch(filterItemsViewModel);

    return DropdownButtonFormField<int>(
        isExpanded: true,
        value: dropValueSacred,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.line_axis_outlined)),
        onChanged: (int? newValue) {
          setState(() {
            dropValueSacred = newValue ?? -1;
          });
        },
        items: model.dropDownSacred
            .map((val) => DropdownMenuItem<int>(
                value: val.value,
                child: Text(val.nameCategory,
                    style: const TextStyle(fontFamily: 'Diablo'))))
            .toList());
  }

  Widget dropDownSocket() {
    final model = ref.watch(filterItemsViewModel);

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
    );
  }

  Widget fieldArmor() {
    return TextFormField(
        controller: armor,
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
    return Column(
      children: [
        TextFormField(
            controller: damagePerSecond,
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
          children: [
            Expanded(
                child: TextFormField(
                    controller: damagePerHitMin,
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
