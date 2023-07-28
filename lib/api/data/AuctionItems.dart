class AuctionItems {
  String status;
  List<AuctionItemsData> items;

  AuctionItems({required this.status, required this.items});

  factory AuctionItems.fromJson(Map<String, dynamic> json) {
    final itemList = (json['items'] as List)
        .map((item) => AuctionItemsData.fromJson(item as List<dynamic>))
        .toList();

    return AuctionItems(status: json['status'] as String, items: itemList);
  }
}

class AuctionItemsData {
  String uuid;
  String name;
  int typeItem;
  int itemTier;
  int itemRarity;
  String itemPower;
  int itemLevel;
  String initialPrice;
  String actualPrice;
  String description;

  AuctionItemsData(
      {required this.uuid,
      required this.name,
      required this.typeItem,
      required this.itemTier,
      required this.itemRarity,
      required this.itemPower,
      required this.itemLevel,
      required this.initialPrice,
      required this.actualPrice,
      required this.description});

  factory AuctionItemsData.fromJson(List<dynamic> json) {
    return AuctionItemsData(
        uuid: json[0] as String,
        name: json[1] as String,
        typeItem: json[2] as int,
        itemTier: json[3] as int,
        itemRarity: json[4] as int,
        itemPower: json[5] as String,
        itemLevel: json[6] as int,
        initialPrice: json[7] as String,
        actualPrice: json[8] as String,
        description: json[9] as String);
  }
}
