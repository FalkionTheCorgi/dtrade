import 'package:dtrade/api/https.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dialogBetViewModel =
    ChangeNotifierProvider((ref) => DialogBetViewModel());

class DialogBetViewModel extends ChangeNotifier {
  String? validateValueBet(String baseValue, String newValue) {
    double baseValueDouble =
        num.tryParse(baseValue.replaceAll(".", ""))?.toDouble() ?? 0.0;
    double newValueDouble =
        num.tryParse(newValue.replaceAll(".", ""))?.toDouble() ?? 0.0;
        
    if (newValue.isEmpty) {
      return 'Campo vazio.';
    } else if (baseValueDouble >= newValueDouble) {
      return 'Insira um valor maior que o atual';
    } else {
      return null;
    }
  }

  Future<void>postBet(String idItem, String value) async {

    await Api.instance.postBetItem(idItem, value);

  }
}
