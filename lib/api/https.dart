import 'dart:convert';

import 'package:dtrade/api/data/Affixes.dart';
import 'package:dtrade/api/data/AuctionItems.dart';
import 'package:dtrade/api/data/Implicit.dart';
import 'package:dtrade/api/data/Items.dart';
import 'package:dtrade/api/data/Message.dart';
import 'package:dtrade/api/data/Sock.dart';
import 'package:dtrade/api/data/Tier.dart';
import 'package:dtrade/api/data/profile.dart';
import 'package:dtrade/addItem/data/ChipItem.dart';
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

  Future<dynamic> getAffixes(int idItem) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final queryParameters = {'id_item': idItem.toString()};

    final url = Uri.http(link, '/affixes', queryParameters);

    final response = await http.get(url, headers: headers);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Affixes responseParsed = Affixes.fromJson(parsed);
      return responseParsed;
    } else {
      Message responseParsed = Message.fromJson(parsed);
      return responseParsed;
    }
  }

  Future<dynamic> getImplicit(int idItem) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final queryParameters = {'id_item': idItem.toString()};

    final url = Uri.http(link, '/implicit', queryParameters);

    final response = await http.get(url, headers: headers);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Implicit responseParsed = Implicit.fromJson(parsed);
      return responseParsed;
    } else {
      Message responseParsed = Message.fromJson(parsed);
      return responseParsed;
    }
  }

  Future<dynamic> getItemsByClass(int clas) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final queryParameters = {'class': clas.toString()};

    final url = Uri.http(link, '/items_by_class', queryParameters);

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
      int itemType,
      int itemTier,
      int itemRarity,
      int itemLevel,
      List<ChipItem> listImplict,
      List<ChipItem> listAffix,
      int armor,
      int damagePerSecond,
      int attackPerSecond,
      int damagePerHitMin,
      int damagePerHitMax,
      int socket) async {
    final url = Uri.http(link, '/auction_item');
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> implicitToJson =
        listImplict.map((chipItem) => chipItem.toJson()).toList();
    List<Map<String, dynamic>> affixToJson =
        listAffix.map((chipItem) => chipItem.toJson()).toList();

    final headers = {
      'token': prefs.getString('token') ?? "",
      'Content-Type': 'application/json'
    };

    Map<String, dynamic> data = {
      'name': name,
      'item_power': itemPower,
      'initial_price': initialPrice,
      'item_type': itemType,
      'item_tier': itemTier,
      'item_rarity': itemRarity,
      'item_level': itemLevel,
      'implicit': implicitToJson,
      'affix': affixToJson,
      'armor': armor,
      'damage_per_second': damagePerSecond,
      'attack_per_second': attackPerSecond,
      'damage_per_hit_min': damagePerHitMin,
      'damage_per_hit_max': damagePerHitMax,
      'socket': socket
    };

    String jsonData = jsonEncode(data);

    final response = await http.post(url, headers: headers, body: jsonData);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    Message responseParsed = Message.fromJson(parsed);

    return responseParsed;
  }

  Future<dynamic> getAuctionItems(
      int clas,
      int page,
      String? name,
      String? minItemPower,
      String? maxItemPower,
      int? itemType,
      int? itemTier,
      int? itemRarity,
      int? itemLevel,
      int? armor,
      int? damagePerSecond,
      int? damagePerHitMin,
      int? damagePerHitMax,
      List<String>? affix,
      List<String>? implicit,
      int? socket) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final queryParameters = {'class': clas.toString(), 'page': page.toString()};

    if (name != null) {
      queryParameters.addAll({'name': name});
    }
    if (minItemPower != null) {
      queryParameters.addAll({'min_item_power': minItemPower});
    }
    if (maxItemPower != null) {
      queryParameters.addAll({'max_item_power': maxItemPower});
    }
    if (itemType != null) {
      queryParameters.addAll({'item_type': itemType.toString()});
    }
    if (itemTier != null) {
      queryParameters.addAll({'item_tier': itemTier.toString()});
    }
    if (itemRarity != null) {
      queryParameters.addAll({'item_rarity': itemRarity.toString()});
    }
    if (itemLevel != null) {
      queryParameters.addAll({'item_level': itemLevel.toString()});
    }
    if (armor != null) {
      queryParameters.addAll({'armor': armor.toString()});
    }
    if (damagePerSecond != null) {
      queryParameters.addAll({'damage_per_second': damagePerSecond.toString()});
    }
    if (damagePerHitMin != null) {
      queryParameters
          .addAll({'damage_per_hit_min': damagePerHitMin.toString()});
    }
    if (damagePerHitMax != null) {
      queryParameters
          .addAll({'damage_per_hit_max': damagePerHitMax.toString()});
    }
    if (affix != null) {
      queryParameters.addAll({'affix': affix.toString()});
    }
    if (implicit != null) {
      queryParameters.addAll({'implicit': implicit.toString()});
    }
    if (socket != null) {
      queryParameters.addAll({'socket': socket.toString()});
    }

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

  Future<dynamic> getTier() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'token': prefs.getString('token') ?? "",
    };

    final url = Uri.http(link, '/tier');

    final response = await http.get(url, headers: headers);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Tier responseParsed = Tier.fromJson(parsed);
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

    print(response.body);

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

  Future<dynamic> getSockets() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {'token': prefs.getString('token') ?? ""};

    final url = Uri.http(link, '/socket');

    final response = await http.get(url, headers: headers);

    Map<String, dynamic> parsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Sock responseParsed = Sock.fromJson(parsed);
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
