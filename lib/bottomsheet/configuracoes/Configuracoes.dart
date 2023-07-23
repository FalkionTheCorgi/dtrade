import 'package:dtrade/bottomsheet/configuracoes/ConfiguracoesViewModel.dart';
import 'package:dtrade/bottomsheet/configuracoes/DarkModeProvider.dart';
import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Configuracoes extends ConsumerStatefulWidget {
  const Configuracoes({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ConfiguracoesState();
}

class ConfiguracoesState extends ConsumerState<Configuracoes> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    final darkmode = ref.watch(darkModeProvider);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Configurações",
            style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Switch(
                value: darkmode,
                onChanged: (bool value) {
                  ref.read(darkModeProvider.notifier).toggle();
                },
              ),
              const SizedBox(width: 4),
              Text('Modo Escuro', style: GoogleFonts.roboto())
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            RichText(
              text: TextSpan(
                  text: 'Deseja excluir a sua conta? Clique aqui.',
                  style: GoogleFonts.roboto(
                      textStyle:
                          const TextStyle(fontSize: 16, color: Colors.red)),
                  recognizer: TapGestureRecognizer()..onTap = () async {}),
            ),
          ]),
          const SizedBox(
            height: 16,
          ),
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
