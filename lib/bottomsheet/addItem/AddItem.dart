import 'dart:io';

import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:dtrade/routes/AppRoutes.dart';
import 'package:dtrade/tabbar/TabBarControllerViewModel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabBarModel = ref.watch(tabBarViewModel);
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          Text(
            "Adicionar Item",
            style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 32),
          Text(
            "Adicione uma foto, use sua câmera para captar os dados do item, ou escolha adicionar manualmente, vale ressaltar que o metódo de usar uma foto da galeria ou tirar uma foto não é 100% preciso, para melhor precisão escolha adicionar manualmente.",
            style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 14)),
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
                        final file =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (file != null) {
                          tabBarModel.analyzeImage(file.path);
                          tabBarModel.setFile(File(file.path));
                        }
                      }),
              ),
              Spacer(),
              RichText(
                text: TextSpan(
                    text: 'Usar câmera',
                    style: GoogleFonts.roboto(
                        textStyle:
                            const TextStyle(fontSize: 16, color: Colors.black)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamed(AppRoutes.camera);
                      }),
              )
            ],
          ),
          const SizedBox(height: 32),
          FkFProgressButton(
              onPressedCallback: () async {
                Navigator.pop(context);
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
