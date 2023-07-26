import 'package:dtrade/bottomsheet/recuperarSenha/RecoverPasswordViewModel.dart';
import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class RecoverPassword extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => RecoverPasswordState();
}

class RecoverPasswordState extends ConsumerState<RecoverPassword> {
  bool hidePassword = true;
  bool hideRepeatPass = true;
  final formKey = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController repeatPass;
  late TextEditingController code;

  void toggleEyePass() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void toggleEyeRepeatPass() {
    setState(() {
      hideRepeatPass = !hideRepeatPass;
    });
  }

  @override
  void initState() {
    email = TextEditingController(text: '');
    password = TextEditingController(text: '');
    repeatPass = TextEditingController(text: '');
    code = TextEditingController(text: '');
    //senha = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    //senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(recoverPassViewModel);
    return AnimatedSize(
        duration: const Duration(milliseconds: 500),
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Recuperar Senha",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: email,
                    validator: (value) {
                      return model.validateEmail(value!);
                    },
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FkFProgressButton(
                    title: model.btnChangeState,
                    bgColorButton: ColorTheme.colorFirst,
                    textColorButton: Colors.white,
                    colorProgress: Colors.white,
                    onPressedCallback: () async {
                      if (formKey.currentState!.validate()) {
                        model.sendCodeToEmail(email.text);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  FkFProgressButton(
                    title: 'FECHAR',
                    bgColorButton: Colors.black,
                    textColorButton: Colors.white,
                    colorProgress: Colors.white,
                    onPressedCallback: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )));
  }

  Widget CodeAndPassView() {
    final model = ref.watch(recoverPassViewModel);
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        TextFormField(
          controller: password,
          validator: (value) {
            return model.validatePassword(value!, repeatPass.text);
          },
          obscureText: hidePassword,
          decoration: InputDecoration(
            labelText: 'Senha',
            border: OutlineInputBorder(),
            prefixIcon: const Icon(
              Icons.lock_outlined,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                toggleEyePass();
              },
              child: Icon(hidePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
            width: width,
            child: Text(
                'A senha deve conter pelo menos uma letra maiúscula, uma minúscula, símbolos e números, e 8 caracteres.',
                textAlign: TextAlign.start,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 12,
                  ),
                ))),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: repeatPass,
          obscureText: hideRepeatPass,
          validator: (value) {
            return model.validateRepeatPassword(password.text, value!);
          },
          decoration: InputDecoration(
            labelText: 'Repetir Senha',
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(
              Icons.lock_outlined,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                toggleEyeRepeatPass();
              },
              child: Icon(hideRepeatPass
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
