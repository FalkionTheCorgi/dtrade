import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawerLayoutViewModel =
    ChangeNotifierProvider((ref) => DrawerLayoutViewModel());

class DrawerLayoutViewModel extends ChangeNotifier {
  var item = ClassD.barbarian;

  void changeItem(ClassD newClass) {
    item = newClass;
    notifyListeners();
  }

  String returnItemDrawerChoose() {
    switch (item) {
      case ClassD.barbarian:
        return 'Bárbaro';
      case ClassD.druid:
        return "Druida";
      case ClassD.necromancer:
        return "Necromancer";
      case ClassD.rogue:
        return "Rogue";
      case ClassD.sorcerer:
        return "Sorcerer";
    }
  }
}

enum ClassD { barbarian, rogue, sorcerer, druid, necromancer }
