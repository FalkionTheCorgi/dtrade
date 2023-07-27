import 'dart:convert';

import 'package:dtrade/api/data/Items.dart';
import 'package:dtrade/api/data/Message.dart';
import 'package:dtrade/api/data/profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<Message> postRegisterUser(
      String email, String battletag, String uuid) async {
    final url = Uri.http('10.0.2.2:5000', '/profile');

    Map<String, dynamic> data = {
      'email': email,
      'battletag': battletag,
      'uuid': uuid,
    };

    String jsonData = jsonEncode(data);

    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, headers: headers, body: jsonData);

    final parsed = jsonDecode(response.body);

    final responseParsed = Message.fromJson(parsed);

    return responseParsed;
  }

  Future<Profile> getProfile() async {
    final url = Uri.http('10.0.2.2:5000', '/profile');

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final response = await http.get(url, headers: headers);

    final parsed = jsonDecode(response.body);

    final responseParsed = Profile.fromJson(parsed);

    return responseParsed;
  }

  Future<bool> getTokenValid() async {
    final url = Uri.http('10.0.2.2:5000', '/token');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Items?> getItems() async {
    final url = Uri.http('10.0.2.2:5000', '/items');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final response = await http.get(url, headers: headers);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    Items responseParsed = Items.fromJson(parsed);

    if (response.statusCode == 200) {
      return responseParsed;
    } else {
      return null;
    }
  }

  static final Api _instance = Api._internal();

  Api._internal();

  static Api get instance => _instance;
}
