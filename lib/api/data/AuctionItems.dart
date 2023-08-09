class AuctionItems {
  String status;
  int quantidade;
  List<AuctionItemsData> items;

  AuctionItems(
      {required this.status, required this.quantidade, required this.items});

  factory AuctionItems.fromJson(Map<String, dynamic> json) {
    final itemList = (json['items'] as List)
        .map((item) => AuctionItemsData.fromJson(item as List<dynamic>))
        .toList();

    return AuctionItems(
        status: json['status'] as String,
        quantidade: json['quantidade'] as int,
        items: itemList);
  }
}

class AuctionItemsData {
  String uuid;
  String name;
  int typeItem;
  String itemTier;
  int itemRarity;
  String itemPower;
  int itemLevel;
  String initialPrice;
  String actualPrice;
  int socket;
  int damagePerSecond;
  int attackPerSecond;
  int damagePerHitMin;
  int damagePerHitMax;
  String? battletag;

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
      required this.battletag,
      required this.socket,
      required this.damagePerSecond,
      required this.attackPerSecond,
      required this.damagePerHitMin,
      required this.damagePerHitMax});

  factory AuctionItemsData.fromJson(List<dynamic> json) {
    return AuctionItemsData(
        uuid: json[0] as String,
        name: json[1] as String,
        typeItem: json[2] as int,
        itemTier: json[3] as String,
        itemRarity: json[4] as int,
        itemPower: json[5] as String,
        itemLevel: json[6] as int,
        initialPrice: json[7] as String,
        actualPrice: json[8] as String,
        battletag: json[9] as String?,
        socket: json[10] as int,
        damagePerSecond: json[11] as int,
        attackPerSecond: json[12] as int,
        damagePerHitMin: json[13] as int,
        damagePerHitMax: json[14] as int);
  }
}
