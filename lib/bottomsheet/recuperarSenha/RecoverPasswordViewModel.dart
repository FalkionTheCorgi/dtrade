import 'package:dtrade/extension/Regex.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recoverPassViewModel =
    ChangeNotifierProvider((ref) => RecoverPasswordViewModel());

class RecoverPasswordViewModel extends ChangeNotifier {
  String btnChangeState = 'ENVIAR';
  bool showFeedBack = false;

  void changeFeedBack() {
    showFeedBack = !showFeedBack;
    notifyListeners();
    //showFeedBack = !showFeedBack;
    //notifyListeners();
  }

  String? validateEmail(String str) {
    if (str.isEmpty) {
      return 'E-mail não pode estar vazio.';
    } else if (RegExp(RegexData.email).hasMatch(str)) {
      return null;
    } else {
      return 'Formato de e-mail inválido';
    }
  }

  String? validatePassword(String pass, String repeatPass) {
    if (pass != repeatPass) {
      return 'Campo senha e repetir senha devem ser identicos';
    } else if (pass.isEmpty) {
      return 'Campo senha não pode estar vazio.';
    } else if (pass.length == 6) {
      return null;
    } else {
      return 'Formato da senha inválido';
    }
  }

  String? validateRepeatPassword(String pass, String repeatPass) {
    if (pass != repeatPass) {
      return 'Campo senha e repetir senha devem ser identicos';
    } else if (repeatPass.isEmpty) {
      return 'Campo repetir senha não pode estar vazio.';
    } else if (repeatPass.length == 6) {
      return null;
    } else {
      return 'Formato da senha inválido';
    }
  }

  Future<String> sendCodeToEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      changeFeedBack();
      return 'Enviamos um e-mail com a redefinição de senha.';
    } on FirebaseAuthException catch (e) {
      changeFeedBack();
      return e.message ?? 'Erro desconhecido. Por favor contactar o suporte.';
    }
  }
}
