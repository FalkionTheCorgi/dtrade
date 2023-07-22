
import 'dart:io';

import 'package:dtrade/bottomsheet/addItem/AddItemViewModel.dart';
import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/data/DataItemRegister.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:dtrade/routes/AppRoutes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddItemImage extends ConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(addItemViewModel);
     return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24),
            Text(
              "Adicionar Item",
              style:
                  GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(height: 32),
            Text(
              "Adicione uma foto, use sua câmera para captar os dados do item, ou escolha adicionar manualmente, vale ressaltar que o metódo de usar uma foto da galeria ou tirar uma foto não é 100% preciso, para melhor precisão escolha adicionar manualmente.",
              style:
                  GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Adicionar foto',
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              fontSize: 16, color: ColorTheme.colorFirst)),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final picker = ImagePicker();
                          final file = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (file != null) {
                            model.setFile(File(file.path));
                          }
                        }),
                ),
                Spacer(),
                RichText(
                  text: TextSpan(
                      text: 'Usar câmera',
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              fontSize: 16, color: Colors.black)),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed(AppRoutes.camera);
                        }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            FkFProgressButton(
                onPressedCallback: () async {
                  model.dataItem = DataItemRegister();
                  model.changeBottomSheet();
                },
                title: 'ADICIONAR MANUALMENTE',
                bgColorButton: ColorTheme.colorFirst,
                textColorButton: Colors.white,
                colorProgress: Colors.white),
            const SizedBox(height: 8),
            FkFProgressButton(
                onPressedCallback: () async {
                  model.dataItem = DataItemRegister();
                  Navigator.of(context).pop();
                },
                title: 'FECHAR',
                bgColorButton: Colors.black,
                textColorButton: Colors.white,
                colorProgress: Colors.white)
          ],
        ),
      );
  }




}