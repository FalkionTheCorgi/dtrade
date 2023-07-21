import 'package:dtrade/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future main() async {
  runApp(const ProviderScope(
    child: MyApp(flavor: 'release'),
  ));
}

class MyApp extends StatelessWidget {
  final String flavor;

  const MyApp({required this.flavor});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DTrade',
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ));
  }
}
