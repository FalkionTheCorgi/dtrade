import 'package:dtrade/login/Login.dart';
import 'package:dtrade/start/startviewmodel.dart';
import 'package:dtrade/tabbar/TabBarController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Start extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => StartState();
}

class StartState extends ConsumerState<Start> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(startViewModel);

    return FutureBuilder(
        future: model.getTokenValidation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print('haserror');
            model.clearToken();
            return Login();
          } else {
            // Se a função for concluída com sucesso, verifica o resultado.
            bool tokenValid = snapshot.data as bool? ?? false;
            if (tokenValid) {
              return const TabBarController();
            } else {
              return const Login();
            }
          }
        });
  }
}
