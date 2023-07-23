import 'package:dtrade/extension/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogDelete extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DialogDeleteState();
}

class DialogDeleteState extends ConsumerState<DialogDelete> {
  late TextEditingController betValue;

  @override
  void initState() {
    betValue = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    betValue.dispose();
    ;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Text("Aviso",
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(fontSize: 18))),
            const SizedBox(height: 16),
            Text("Essa ação é irreversível, você tem certeza?",
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(fontSize: 16))),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('NÃO',
                      style: GoogleFonts.roboto(color: ColorTheme.colorFirst)),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:
                      Text('SIM', style: GoogleFonts.roboto(color: Colors.red)),
                )
              ],
            )
          ],
        ));
  }
}
