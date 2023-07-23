import 'package:dtrade/bottomsheet/denunciar/DenounceViewModel.dart';
import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/data/DataDropDownCategory.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DenounceView extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DenounceViewState();
}

class DenounceViewState extends ConsumerState<DenounceView> {
  int dropValue = -1;
  final formKey = GlobalKey<FormState>();

  final List<DataDropDownCategory> dropDownDenounce = [
    const DataDropDownCategory(value: -1, nameCategory: 'Select'),
    const DataDropDownCategory(value: 0, nameCategory: 'Motivo1'),
    const DataDropDownCategory(value: 1, nameCategory: 'Motivo2'),
    const DataDropDownCategory(value: 2, nameCategory: 'Motivo3'),
    const DataDropDownCategory(value: 3, nameCategory: 'Motivo4'),
    const DataDropDownCategory(value: 4, nameCategory: 'Motivo5'),
  ];

  late List<DropdownMenuItem<int>> itemListDenounce;

  @override
  void initState() {
    itemListDenounce = dropDownDenounce
        .map((val) => DropdownMenuItem<int>(
            value: val.value,
            child: Text(val.nameCategory, style: GoogleFonts.roboto())))
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(denounceViewModel);

    return Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                  value: dropValue,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.line_axis_outlined)),
                  onChanged: (int? newValue) {
                    setState(() {
                      dropValue = newValue ?? -1;
                    });
                  },
                  items: itemListDenounce,
                  validator: (value) {
                    return model.validateDropDown(value!);
                  }),
              const SizedBox(height: 16.0),
              FkFProgressButton(
                title: model.btnDenounce,
                bgColorButton: ColorTheme.colorFirst,
                textColorButton: Colors.white,
                colorProgress: Colors.white,
                onPressedCallback: () async {
                  if (formKey.currentState!.validate()) {}
                },
              ),
              const SizedBox(height: 8.0),
              FkFProgressButton(
                title: 'FECHAR',
                bgColorButton: Colors.black,
                textColorButton: Colors.white,
                colorProgress: Colors.white,
                onPressedCallback: () async {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ));
  }
}
