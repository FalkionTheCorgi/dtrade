import 'dart:io';
import 'package:dtrade/bottomsheet/addItem/AddItemViewModel.dart';
import 'package:dtrade/bottomsheet/configuracoes/DarkModeProvider.dart';
import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/data/DataItemRegister.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:dtrade/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddItemImage extends ConsumerWidget {
  const AddItemImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(addItemViewModel);
    final darkmode = ref.watch(darkModeProvider);
    double width = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.all(16),
        child: model.loadingFile == false
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Adicionar Item",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Adicione uma foto, use sua câmera para captar os dados do item, ou escolha adicionar manualmente, vale ressaltar que o metódo de usar uma foto da galeria ou tirar uma foto não é 100% preciso, para melhor precisão escolha adicionar manualmente.",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            final picker = ImagePicker();
                            final file = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (file != null) {
                              model.setFile(File(file.path)).then((value) {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.addItem,
                                    arguments: model.dataItem);
                              });
                            }
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          child: Text('Adicionar foto',
                              style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: ColorTheme.colorFirst)))),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            model.dataItem = DataItemRegister();
                            Navigator.of(context).pushNamed(AppRoutes.addItem,
                                arguments: model.dataItem);
                          },
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0)),
                          child: Text('Manualmente',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      color: darkmode
                                          ? Colors.white
                                          : Colors.black)))),
                    ],
                  ),
                  const SizedBox(height: 16),
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
              )
            : SizedBox(
                width: width,
                height: 60,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Center(child: CircularProgressIndicator())],
                )));
  }
}
