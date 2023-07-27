class Items {
  String status;
  List<ItemData> item;

  Items({required this.status, required this.item});

  factory Items.fromJson(Map<String, dynamic> json) {
    final itemList = (json['items'] as List)
        .map((item) => ItemData.fromJson(item as List<dynamic>))
        .toList();

    print(itemList);
    return Items(status: json['status'] as String, item: itemList);
  }
}

class ItemData {
  int id;
  String item;

  ItemData({required this.id, required this.item});

  factory ItemData.fromJson(List<dynamic> json) {
    return ItemData(id: json[0] as int, item: json[1] as String);
  }
}
