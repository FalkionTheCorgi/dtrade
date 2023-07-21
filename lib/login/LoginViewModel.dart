import 'package:dtrade/extension/Regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'LoginState.dart';

final loginViewModel = ChangeNotifierProvider((ref) => LoginViewModel());

class LoginViewModel extends ChangeNotifier {
  LoginState state = LoginState();

  String? validateEmail(String str) {
    if (str.isEmpty) {
      return 'E-mail não pode estar vazio.';
    } else if (RegExp(RegexData.email).hasMatch(str)) {
      return null;
    } else {
      return 'Formato de e-mail inválido';
    }
  }
}
