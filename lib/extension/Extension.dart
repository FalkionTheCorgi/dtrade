import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void updateToken() async {
  final token = await FirebaseAuth.instance.currentUser?.getIdToken();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token ?? '');
}

Widget circularProgressIndicator(double width) {
  return SizedBox(
    width: width,
    height: 40,
    child: const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [CircularProgressIndicator()],
    )),
  );
}

Widget textWithoutIcon(String text) {
  return Text(text,
      style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 16)));
}

Widget textListItemAsset(String text, String image) {
  return Row(
    children: [
      Image.asset(image, width: 24, height: 24),
      const SizedBox(width: 4),
      Text(text,
          style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 16)))
    ],
  );
}

Widget textListItemIcon(String text, IconData image) {
  return Row(
    children: [
      Icon(image),
      const SizedBox(width: 4),
      Text(text,
          style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 16)))
    ],
  );
}

String returnImageType(int item) {
  switch (item) {
    case 1:
      return 'assets/axe.png';
    case 2:
      return 'assets/bow.png';
    case 3:
      return 'assets/dagger.png';
    case 4:
      return 'assets/two_handed_axe.png';
    case 5:
      return 'assets/two_handed_mace.png';
    case 6:
      return 'assets/staves.png';
    case 7:
      return 'assets/two_handed_staves.png';
    case 8:
      return 'assets/sword.png';
    case 9:
      return 'assets/two_handed_swords.png';
    case 10:
      return 'assets/scythes.png';
    case 11:
      return 'assets/two_handed_scythes.png';
    case 12:
      return 'assets/wand.png';
    case 13:
      return 'assets/maces.png';
    case 14:
      return 'assets/crossbow.png';
    case 15:
      return 'assets/greek_helmet.png';
    case 16:
      return 'assets/gloves.png';
    case 17:
      return 'assets/pants.png';
    case 18:
      return 'assets/boots.png';
    case 19:
      return 'assets/body_armor.png';
    case 20:
      return 'assets/focuses.png';
    case 21:
      return 'assets/ring.png';
    case 22:
      return 'assets/necklace.png';
    default:
      return 'assets/question.png';
  }
}
