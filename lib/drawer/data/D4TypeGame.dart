import 'package:flutter/material.dart';

class D4TypeGame{

  AssetImage image;
  String typeGame;
  int rowItem;

  D4TypeGame({
    required this.image,
    required this.typeGame,
    required this.rowItem
  });

}

class RegisteredTypeGame{

  static D4TypeGame softcore = D4TypeGame(
      image: const AssetImage('assets/barbarian.png'),
      typeGame: "Softcore",
      rowItem: 0
  );

  static D4TypeGame hardcore = D4TypeGame(
      image: const AssetImage('assets/barbarian.png'),
      typeGame: "Hardcore",
      rowItem: 1
  );

}