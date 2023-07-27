import 'package:dtrade/api/https.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawerLayoutViewModel =
    ChangeNotifierProvider((ref) => DrawerLayoutViewModel());

class DrawerLayoutViewModel extends ChangeNotifier {
  var item = ClassD.barbarian;
  String battletag = '';

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

  Future<bool> getProfile() async {
    final profile = await Api.instance.getProfile();

    battletag = profile.profile[0].battletag;

    if (battletag.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

enum ClassD { barbarian, rogue, sorcerer, druid, necromancer }
