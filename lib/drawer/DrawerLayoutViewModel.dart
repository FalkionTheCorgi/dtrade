import 'package:dtrade/api/data/profile.dart';
import 'package:dtrade/api/https.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawerLayoutViewModel =
    ChangeNotifierProvider((ref) => DrawerLayoutViewModel());

class DrawerLayoutViewModel extends ChangeNotifier {
  var item = ClassD.barbarian;
  String battletag = '';
  var refresh = true;

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

  int returnIntItemChoose() {
    refresh = true;
    switch (item) {
      case ClassD.barbarian:
        return 1;
      case ClassD.druid:
        return 2;
      case ClassD.necromancer:
        return 3;
      case ClassD.rogue:
        return 4;
      case ClassD.sorcerer:
        return 5;
    }
  }

  Future<void> getProfile() async {
    final response = await Api.instance.getProfile();

    if (response is Profile) {
      battletag = response.profile[0].battletag;
    } else {
      battletag = 'Sem battletag cadastrada';
    }
    notifyListeners();
  }
}

enum ClassD { barbarian, rogue, sorcerer, druid, necromancer }
