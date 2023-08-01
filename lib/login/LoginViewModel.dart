import 'package:dtrade/extension/Regex.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String? validatePassword(String str) {
    if (str.isEmpty) {
      return 'Senha não pode estar vazio.';
    } else {
      return null;
    }
  }

  Future<String> loginFirebase(String email, String password) async {
    try {
      final _ = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token ?? '');
      return '';
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        return 'E-mail não cadastrado';
      } else if (error.code == 'wrong-password') {
        return 'E-mail ou senha inválidos.';
      } else {
        return 'Erro desconhecido.';
      }
    }
  }
}
