import 'package:dtrade/extension/Color.dart';
import 'package:dtrade/leilao/andamento/LeilaoAndamentoViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogDelete extends ConsumerStatefulWidget {
  String idPub;

  DialogDelete({Key? key, required this.idPub}) : super(key: key);

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(listLeilaoAndamento);

    return Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Notice",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 18))),
                const SizedBox(height: 16),
                Text("This action is irreversible, are you sure?",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 16))),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('NO',
                      style: GoogleFonts.roboto(color: ColorTheme.colorFirst)),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    model.deleteItem(widget.idPub).then((value) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(value.message)));
                      Navigator.pop(context);
                    });
                  },
                  child:
                      Text('YES', style: GoogleFonts.roboto(color: Colors.red)),
                )
              ],
            )
          ],
        ));
  }
}
