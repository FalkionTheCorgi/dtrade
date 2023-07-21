import 'package:dtrade/cadastro/CadastroViewModel.dart';
import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Cadastro extends ConsumerStatefulWidget {
  @override
  ConsumerState<Cadastro> createState() => CadastroConsumerState();
}

class CadastroConsumerState extends ConsumerState<Cadastro> {
  bool hidePassword = true;
  bool hideRepeatPass = true;
  final formKey = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController repeatPass;
  late TextEditingController battleTag;

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
    battleTag = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    battleTag.dispose();
    password.dispose();
    repeatPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final model = ref.watch(cadastroViewModel);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 32.0),
                  Text(
                    'Cadastro',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 32,
                      ),
                    ),
                  ),
                  const SizedBox(height: 62.0),
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
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: battleTag,
                    validator: (value) {
                      return model.validateBattleTag(value!);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Battletag',
                      border: OutlineInputBorder(),
                      prefixIcon: ImageIcon(AssetImage('assets/Battlenet.png')),
                    ),
                  ),
                  const SizedBox(height: 16.0),
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
                      return model.validateRepeatPassword(
                          password.text, value!);
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
                  /*const SizedBox(height: 16.0),
                  Row(
                    children: [Checkbox(value: value, onChanged: onChanged)],
                  ),*/
                  const SizedBox(height: 32.0),
                  FkFProgressButton(
                    title: model.state.btnRegister,
                    bgColorButton: Colors.black,
                    textColorButton: Colors.white,
                    colorProgress: Colors.white,
                    onPressedCallback: () async {
                      if (formKey.currentState!.validate()) {}
                    },
                  ),
                  const SizedBox(height: 8.0),
                  FkFProgressButton(
                    title: 'VOLTAR',
                    bgColorButton: ColorTheme.colorFirst,
                    textColorButton: Colors.white,
                    colorProgress: Colors.white,
                    onPressedCallback: () async {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }
}
