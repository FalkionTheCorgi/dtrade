import 'package:dtrade/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future main() async {
  runApp(const ProviderScope(
    child: MyApp(
      flavor: 'dev',
    ),
  ));
}
