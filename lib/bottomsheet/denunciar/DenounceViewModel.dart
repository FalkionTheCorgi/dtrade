import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final denounceViewModel = ChangeNotifierProvider((ref) => DenounceViewModel());

class DenounceViewModel extends ChangeNotifier {
  String btnDenounce = "ENVIAR";

  String? validateDropDown(int opt) {
    if (opt < 0) {
      return 'Selecione uma opção.';
    } else {
      return null;
    }
  }
}
