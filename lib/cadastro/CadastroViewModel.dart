import 'package:dtrade/cadastro/CadastroState.dart';
import 'package:dtrade/extension/Regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cadastroViewModel = ChangeNotifierProvider((ref) => CadastroViewModel());

class CadastroViewModel extends ChangeNotifier {
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
}
