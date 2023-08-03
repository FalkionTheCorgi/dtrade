import 'package:dtrade/api/data/AuctionItems.dart';
import 'package:dtrade/api/https.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listLeilaoClosed =
    ChangeNotifierProvider((ref) => LeilaoConcluidoViewModel());

class LeilaoConcluidoViewModel extends ChangeNotifier {
  AuctionItems list = AuctionItems(status: 'INITIAL', quantidade: 0, items: []);

  void init(int page) {
    getList(page);
  }

  Future<dynamic> getList(int page) async {
    final response = await Api.instance.getMyAuctionItemsClosed(page);
    if (response is AuctionItems) {
      list = response;
    }
    notifyListeners();
  }
}
