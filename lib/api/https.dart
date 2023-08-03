import 'dart:convert';

import 'package:dtrade/api/data/AuctionItems.dart';
import 'package:dtrade/api/data/Items.dart';
import 'package:dtrade/api/data/Message.dart';
import 'package:dtrade/api/data/profile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  final link = '10.0.2.2:5000';
  final linkEmulator = '127.0.0.1:5000';

  Future<Message> postRegisterUser(
      String email, String battletag, String uuid) async {
    final url = Uri.http(link, '/profile');

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

  Future<dynamic> getProfile() async {
    final url = Uri.http(link, '/profile');

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final response = await http.get(url, headers: headers);

    final parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final responseParsed = Profile.fromJson(parsed);
      return responseParsed;
    } else {
      final responseParsed = Message.fromJson(parsed);
      return responseParsed;
    }
  }

  Future<bool> getTokenValid() async {
    final url = Uri.http(link, '/token');
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

  Future<dynamic> getItems() async {
    final url = Uri.http(link, '/items');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final response = await http.get(url, headers: headers);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Items responseParsed = Items.fromJson(parsed);
      return responseParsed;
    } else {
      Message responseParsed = Message.fromJson(parsed);
      return responseParsed;
    }
  }

  Future<Message> postItem(
      String name,
      String itemPower,
      String initialPrice,
      String description,
      int itemType,
      int itemTier,
      int itemRarity,
      int itemLevel) async {
    final url = Uri.http(link, '/auction_item');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
      'Content-Type': 'application/json'
    };

    Map<String, dynamic> data = {
      'name': name,
      'item_power': itemPower,
      'initial_price': initialPrice,
      'description': description,
      'item_type': itemType,
      'item_tier': itemTier,
      'item_rarity': itemRarity,
      'item_level': itemLevel
    };

    String jsonData = jsonEncode(data);

    final response = await http.post(url, headers: headers, body: jsonData);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    Message responseParsed = Message.fromJson(parsed);

    return responseParsed;
  }

  Future<dynamic> getAuctionItems(int clas, int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final queryParameters = {'class': clas.toString(), 'page': page.toString()};

    final url = Uri.http(link, '/auction_items', queryParameters);

    final response = await http.get(url, headers: headers);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      AuctionItems responseParsed = AuctionItems.fromJson(parsed);
      return responseParsed;
    } else {
      Message responseParsed = Message.fromJson(parsed);
      return responseParsed;
    }
  }

  Future<Message> postBetItem(String idItem, String value) async {
    final url = Uri.http(link, '/bet_item');

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
      'Content-Type': 'application/json'
    };

    Map<String, dynamic> data = {'id_item': idItem, 'value': value};

    String jsonData = jsonEncode(data);

    final response = await http.post(url, headers: headers, body: jsonData);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    Message responseParsed = Message.fromJson(parsed);

    return responseParsed;
  }

  Future<dynamic> getMyAuctionItemsProgress(int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final queryParameters = {'page': page.toString()};

    final url = Uri.http(link, '/auction_items_progress', queryParameters);

    final response = await http.get(url, headers: headers);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      AuctionItems responseParsed = AuctionItems.fromJson(parsed);
      return responseParsed;
    } else {
      Message responseParsed = Message.fromJson(parsed);
      return responseParsed;
    }
  }

  Future<dynamic> getMyAuctionItemsClosed(int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final queryParameters = {'page': page.toString()};

    final url = Uri.http(link, '/auction_items_closed', queryParameters);

    final response = await http.get(url, headers: headers);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      AuctionItems responseParsed = AuctionItems.fromJson(parsed);
      return responseParsed;
    } else {
      Message responseParsed = Message.fromJson(parsed);
      return responseParsed;
    }
  }

  Future<Message> deleteAuctionItem(String idPub) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
      'Content-Type': 'application/json'
    };

    Map<String, dynamic> data = {'id_pub': idPub};

    String jsonData = jsonEncode(data);

    final url = Uri.http(link, '/auction_item');

    final response = await http.delete(url, headers: headers, body: jsonData);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Message responseParsed = Message.fromJson(parsed);
      return responseParsed;
    } else {
      Message responseParsed = Message.fromJson(parsed);
      return responseParsed;
    }
  }

  static final Api _instance = Api._internal();

  Api._internal();

  static Api get instance => _instance;
}
