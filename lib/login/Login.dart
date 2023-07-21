import 'package:dtrade/components/ProgressButton.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:dtrade/login/LoginViewModel.dart';
import 'package:dtrade/routes/AppRoutes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);


  @override
  ConsumerState<Login> createState() => LoginConsumerState();
}

class LoginConsumerState extends ConsumerState<Login> {
  bool hidePassword = true;
  Color borderColorEmail = Colors.black;
  final formKey = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController senha;

  void toggleEye() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  @override
  void initState() {
    email = TextEditingController(text: '');
    senha = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final model = ref.watch(loginViewModel);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(children: [
              const SizedBox(height: 62.0),
              Text(
                'DTrade',
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 62,
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
                controller: senha,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.lock_outlined,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      toggleEye();
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
                  child: RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                        text: 'Esqueceu a senha?',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print('buttons clicked');
                          }),
                  )),
              const SizedBox(height: 32.0),
              FkFProgressButton(
                title: model.state.btnLogin,
                bgColorButton: Colors.black,
                textColorButton: Colors.white,
                colorProgress: Colors.white,
                onPressedCallback: () async {
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).pushNamed(AppRoutes.tabbar);
                  }
                },
              ),
              const SizedBox(height: 8.0),
              FkFProgressButton(
                title: 'CADASTRAR',
                bgColorButton: ColorTheme.colorFirst,
                textColorButton: Colors.white,
                colorProgress: Colors.white,
                onPressedCallback: () async {
                  Navigator.of(context).pushNamed(AppRoutes.cadastro);
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}
