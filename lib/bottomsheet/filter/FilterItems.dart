import 'package:dtrade/bottomsheet/filter/FilterItemsViewModel.dart';
import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/drawer/DrawerLayoutViewModel.dart';
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
  late TextEditingController minPower;
  late TextEditingController maxPower;
  late TextEditingController lvlRankItem;
  late TextEditingController description;

  int dropValue = -1;

  @override
  void initState() {
    final model = ref.read(filterItemsViewModel);
    final drawerModel = ref.read(drawerLayoutViewModel);
    model.getListItemType(drawerModel.returnIntItemChoose());

    nameItem = TextEditingController(text: '');
    minPower = TextEditingController(text: '0');
    maxPower = TextEditingController(text: '');
    lvlRankItem = TextEditingController(text: '');
    description = TextEditingController(text: '');

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
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(filterItemsViewModel);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
          key: formKey,
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
              Row(children: [
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
                  width: 8,
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
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ]),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: description,
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
        });
      },
      items: model.dropDownItemsCategory
          .map((val) => DropdownMenuItem<int>(
              value: val.value,
              child: Text(val.nameCategory, style: GoogleFonts.roboto())))
          .toList(),
    );
  }
}
