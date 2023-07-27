import 'package:dtrade/api/https.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final startViewModel = ChangeNotifierProvider((ref) => StartViewModel());

class StartViewModel extends ChangeNotifier {
  Future<bool> getTokenValidation() async {
    return await Api.instance.getTokenValid();
  }

  Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
