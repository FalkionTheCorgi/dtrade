import 'package:dtrade/api/data/profile.dart';
import 'package:dtrade/api/https.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final drawerLayoutViewModel =
    ChangeNotifierProvider((ref) => DrawerLayoutViewModel());

class DrawerLayoutViewModel extends ChangeNotifier {
  var item = ClassD.barbarian;
  var typeGame = TypeGame.softcore;
  String battletag = '';
  var refresh = true;

  void changeItem(ClassD newClass) {
    item = newClass;
    notifyListeners();
  }

  void changeTypeGame(TypeGame newType) {
    typeGame = newType;
    notifyListeners();
  }

  String returnItemDrawerChoose() {
    switch (item) {
      case ClassD.barbarian:
        return 'Barbarian';
      case ClassD.druid:
        return "Druid";
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

  int returnIntTypeGame() {
    switch (typeGame) {
      case TypeGame.softcore:
        return 1;
      case TypeGame.hardcore:
        return 2;
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

  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    await FirebaseAuth.instance.signOut();
  }
}

enum ClassD { barbarian, rogue, sorcerer, druid, necromancer }

enum TypeGame { softcore, hardcore }
