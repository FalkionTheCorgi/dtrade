import 'package:dtrade/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This is the last thing you need to add.
  await Firebase.initializeApp();

  runApp(const ProviderScope(
    child: MyApp(
      flavor: 'dev',
    ),
  ));
}
