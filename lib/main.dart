import 'package:dtrade/bottomsheet/configuracoes/DarkModeProvider.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:dtrade/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future main() async {
  runApp(const ProviderScope(
    child: MyApp(flavor: 'release'),
  ));
}

class MyApp extends ConsumerWidget {
  final String flavor;

  const MyApp({required this.flavor});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkmode = ref.watch(darkModeProvider);

    return MaterialApp(
      title: 'DTrade',
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            primary: ColorTheme.colorFirst,
            onPrimary: Colors.black,
            secondary: Colors.black,
            onSurface: Colors.black,
            background: Colors.white),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
            primary: ColorTheme.colorFirst,
            onPrimary: Colors.white,
            secondary: Colors.green,
            onSecondary: Colors.white,
            primaryContainer: Colors.pink,
            onSecondaryContainer: ColorTheme.colorGrey,
            onError: Colors.white,
            background: Colors.black,
            onBackground: Colors.white,
            surface: ColorTheme.colorGrey,
            onSurface: Colors.white,
            onSurfaceVariant: Colors.white),
        useMaterial3: true,
      ),
      themeMode: darkmode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
