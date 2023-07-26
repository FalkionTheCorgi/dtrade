import 'package:dtrade/api/data/Message.dart';
import 'package:dtrade/api/https.dart';
import 'package:dtrade/cadastro/CadastroState.dart';
import 'package:dtrade/extension/Regex.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cadastroViewModel = ChangeNotifierProvider((ref) => CadastroViewModel());

class CadastroViewModel extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  CadastroState state = CadastroState();

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
    } else if (RegExp(RegexData.password).hasMatch(pass)) {
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
    } else if (RegExp(RegexData.password).hasMatch(pass)) {
      return null;
    } else {
      return 'Formato da senha inválido';
    }
  }

  String? validateBattleTag(String str) {
    if (str.isEmpty) {
      return 'Campo battlenet não pode estar vazio.';
    } else if (RegExp(RegexData.battletag).hasMatch(str)) {
      return null;
    } else {
      return 'Formato da Battletag inválida.';
    }
  }

  Future<void> registerUser(String email, String password, String battletag,
      BuildContext context) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(user.user?.uid);
      await Api.instance
          .postRegisterUser(email, battletag, user.user?.uid ?? "")
          .then((value) {
        if (value.status == 'REQUIRED_FIELDS') {
          final snackBar = SnackBar(content: Text(value.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(content: Text(value.message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pop();
        }
      });
    } on FirebaseAuthException catch (_) {
      const exception =
          'Erro ao criar um cadastro, por favor entre em contato com o suporte.';
      final snackBar = SnackBar(content: Text(exception));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
