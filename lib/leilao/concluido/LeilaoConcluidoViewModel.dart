import 'package:dtrade/api/data/AuctionItems.dart';
import 'package:dtrade/api/https.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listLeilaoClosed =
    ChangeNotifierProvider((ref) => LeilaoConcluidoViewModel());

class LeilaoConcluidoViewModel extends ChangeNotifier {
  AuctionItems list = AuctionItems(status: 'INITIAL', quantidade: 0, items: []);
  AuctionItems emptyList =
      AuctionItems(status: 'EMPTY_LIST', quantidade: 0, items: []);
  int page = 1;

  void init() {
    getList();
  }

  void resetList() {
    list = AuctionItems(status: 'INITIAL', quantidade: 0, items: []);
    page = 1;
    notifyListeners();
  }

  Future<dynamic> getList() async {
    if (list.quantidade != list.items.length || list.status == 'INITIAL') {
      final response = await Api.instance.getMyAuctionItemsClosed(page);
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
  }
}
