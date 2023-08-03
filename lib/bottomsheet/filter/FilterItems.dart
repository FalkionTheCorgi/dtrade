import 'package:dtrade/bottomsheet/filter/FilterItemsViewModel.dart';
import 'package:dtrade/components/ProgressButton.dart';
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

  @override
  void initState() {
    final model = ref.read(filterItemsViewModel);
    model.getListItemType();

    nameItem = TextEditingController(text: '');
    itemPower = TextEditingController(text: '');
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
    itemPower.dispose();
    lvlRankItem.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(filterItemsViewModel);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              const SizedBox(height: 24),
              Text(
                "Adicionar Item",
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(height: 32),
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
              const SizedBox(
                height: 16,
              ),
              /*Row(children: [
                        Column(
                          children: [
                            TextButton.icon(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          DialogAddImage(
                                              onPressedCallback: (arq) =>
                                                  setState(() {
                                                    file = arq;
                                                  }))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.all(0)),
                                label: file == null
                                    ? const Text(
                                        'Adicione uma imagem (Obrigatório)')
                                    : Text(file!.path.split('/').last),
                                icon: const Icon(Icons.camera_alt_outlined)),
                          ],
                        )
                      ]),
                      const SizedBox(height: 4),*/
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
              const Spacer(),
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
                  title: 'VOLTAR',
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
        validator: (value) {
          return model.validateDropDown(value!);
        });
  }
}
