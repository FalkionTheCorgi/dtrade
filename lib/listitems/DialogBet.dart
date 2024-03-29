import 'package:dtrade/extension/Rules.dart';
import 'package:dtrade/extension/TextFormatter.dart';
import 'package:dtrade/listitems/DialogBetViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DialogBet extends ConsumerStatefulWidget {
  final String value;
  final String idPub;

  const DialogBet({required this.value, required this.idPub});

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
                titleScreen('Bet'),
                const SizedBox(height: 16),
                TextFormField(
                  controller: betValue,
                  validator: (value) {
                    return model.validateValueBet(widget.value, betValue.text);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Value',
                    labelStyle: TextStyle(fontFamily: 'Diablo'),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.monetization_on_outlined,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [CustomNumberFormatter()],
                  maxLength: 15,
                  style: const TextStyle(fontFamily: 'Diablo'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('CLOSE',
                          style: TextStyle(
                              color: Colors.red, fontFamily: 'Diablo')),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          model.postBet(widget.idPub, betValue.text);
                        }
                      },
                      child: const Text('BET',
                          style: TextStyle(fontFamily: 'Diablo')),
                    )
                  ],
                )
              ],
            )));
  }
}
