import 'package:dtrade/bottomsheet/recuperarSenha/RecoverPassword.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(children: [
              const SizedBox(height: 62.0),
              logo(),
              const SizedBox(height: 62.0),
              fieldEmailAndPassword(),
              const SizedBox(height: 32.0),
              buttons()
            ]),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return Text(
      'DTrade',
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 62,
        ),
      ),
    );
  }

  Widget fieldEmailAndPassword() {
    final model = ref.watch(loginViewModel);
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
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
          validator: (value) {
            return model.validatePassword(value!);
          },
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
                      showModalBottomSheet(
                          showDragHandle: true,
                          isDismissible: false,
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return RecoverPassword();
                          });
                    }),
            )),
      ],
    );
  }

  Widget buttons() {
    final model = ref.watch(loginViewModel);

    return Column(
      children: [
        FkFProgressButton(
          title: model.state.btnLogin,
          bgColorButton: Colors.black,
          textColorButton: Colors.white,
          colorProgress: Colors.white,
          onPressedCallback: () async {
            if (formKey.currentState!.validate()) {
              model.loginFirebase(email.text, senha.text).then((String result) {
                if (result.isEmpty) {
                  Navigator.of(context).pushNamed(AppRoutes.tabbar);
                } else {}
              });
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
      ],
    );
  }
}
