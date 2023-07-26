import 'dart:convert';

import 'package:dtrade/api/data/Message.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<Message> postRegisterUser(
      String email, String battletag, String uuid) async {
    final url = Uri.http('10.0.2.2:5000', '/profile');
    print('uuid: ' + uuid);
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

  static final Api _instance = Api._internal();

  Api._internal();

  static Api get instance => _instance;
}
