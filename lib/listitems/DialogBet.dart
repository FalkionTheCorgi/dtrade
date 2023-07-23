import 'package:dtrade/extension/TextFormatter.dart';
import 'package:dtrade/listitems/DialogBetViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogBet extends ConsumerStatefulWidget {
  final String value;

  const DialogBet({required this.value});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DialogBetState();
}

class DialogBetState extends ConsumerState<DialogBet> {
  late TextEditingController betValue;
  final formKey = GlobalKey<FormState>();

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
    final model = ref.watch(dialogBetViewModel);

    return Padding(
        padding: const EdgeInsets.all(18),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Text("Lance",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 18))),
                const SizedBox(height: 16),
                TextFormField(
                  controller: betValue,
                  validator: (value) {
                    return model.validateValueBet(widget.value, betValue.text);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Valor',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.document_scanner,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [CustomNumberFormatter()],
                  maxLength: 15,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Fechar',
                          style: GoogleFonts.roboto(color: Colors.red)),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      },
                      child: Text('Dar Lance', style: GoogleFonts.roboto()),
                    )
                  ],
                )
              ],
            )));
  }
}
