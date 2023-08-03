import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dtrade/api/data/AuctionItems.dart';
import 'package:dtrade/api/https.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final listLeilaoViewModel =
    ChangeNotifierProvider((ref) => ListLeilaoViewModel());

class ListLeilaoViewModel extends ChangeNotifier {
  AuctionItems list = AuctionItems(status: 'INITIAL', quantidade: 0, items: []);
  AuctionItems emptyList =
      AuctionItems(status: 'EMPTY_LIST', quantidade: 0, items: []);
  int page = 1;

  void resetList() {
    page = 1;
    list = AuctionItems(status: 'INITIAL', quantidade: 0, items: []);
    notifyListeners();
  }

  void init(int clas) {
    getList(clas);
  }

  Future<dynamic> getList(int clas) async {
    final response = await Api.instance.getAuctionItems(clas, page);
    if (response is AuctionItems) {
      list.status = response.status;
      list.quantidade = response.quantidade;
      list.items.addAll(response.items);
      page++;
    } else {
      list = emptyList;
    }
    notifyListeners();
  }

  Future<String> createFileFromString(String str) async {
    Uint8List bytes = base64.decode(str);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
