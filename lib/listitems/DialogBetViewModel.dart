import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dialogBetViewModel =
    ChangeNotifierProvider((ref) => DialogBetViewModel());

class DialogBetViewModel extends ChangeNotifier {
  String? validateValueBet(String baseValue, String newValue) {
    double baseValueDouble = double.parse(baseValue);
    double newValueDouble = double.parse(newValue);

    print('baseValue: $baseValueDouble');
    print('newValue: $newValueDouble');

    if (newValue.isEmpty) {
      return 'Campo vazio.';
    } else if (baseValueDouble >= newValueDouble) {
      return 'Insira um valor maior que o atual';
    } else {
      return null;
    }
  }
}
