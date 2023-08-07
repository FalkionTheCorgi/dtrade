import 'package:flutter/material.dart';

Widget titleScreen(String text) {
  return Text(
    text,
    style: const TextStyle(fontFamily: 'DiabloHeavy', fontSize: 24),
  );
}

Widget emptyList(String text) {
  return Text(
    text,
    style: const TextStyle(fontFamily: 'DiabloHeavy', fontSize: 16),
  );
}
