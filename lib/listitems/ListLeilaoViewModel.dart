import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dtrade/api/https.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final listLeilaoViewModel =
    ChangeNotifierProvider((ref) => ListLeilaoViewModel());

class ListLeilaoViewModel extends ChangeNotifier {
  Future<dynamic> getList(int clas) async {
    return await Api.instance.getAuctionItems(clas);
  }

  Future<String> createFileFromString(String str) async {
    Uint8List bytes = base64.decode(str);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File("$dir/${DateTime.now().millisecondsSinceEpoch}.png");
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
