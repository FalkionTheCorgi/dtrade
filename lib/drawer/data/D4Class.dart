import 'package:flutter/material.dart';
import '../DrawerLayoutViewModel.dart';

class D4Class{
  AssetImage image;
  String className;
  ClassD classD;
  int rowItem;

  D4Class({
    required this.image,
    required this.className,
    required this.classD,
    required this.rowItem
  });

}

class RegisteredClass{

  static D4Class barbarian = D4Class(
      image: const AssetImage('assets/barbarian.png'),
      className: "Barbarian",
      classD: ClassD.barbarian,
      rowItem: 0
  );

  static D4Class rogue = D4Class(
      image: const AssetImage('assets/rogue.png'),
      className: "Rogue",
      classD: ClassD.rogue,
      rowItem: 1
  );

  static D4Class druid = D4Class(
      image: const AssetImage('assets/druid.png'),
      className: "Druid",
      classD: ClassD.druid,
      rowItem: 2
  );

  static D4Class necromancer = D4Class(
      image: const AssetImage('assets/necromancer.png'),
      className: "Necromancer",
      classD: ClassD.necromancer,
      rowItem: 3
  );

  static D4Class sorcerer = D4Class(
      image: const AssetImage('assets/sorcerer.png'),
      className: "Sorcerer",
      classD: ClassD.sorcerer,
      rowItem: 4
  );

}