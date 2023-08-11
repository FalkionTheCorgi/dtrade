class AuctionItems {
  String status;
  int quantidade;
  List<AuctionItemsData> items;

  AuctionItems({
    required this.status,
    required this.quantidade,
    required this.items,
  });

  factory AuctionItems.fromJson(Map<String, dynamic> json) {
    final itemList = (json['items'] as List)
        .map((item) => AuctionItemsData.fromJson(item as Map<String, dynamic>))
        .toList();

    return AuctionItems(
      status: json['status'] as String,
      quantidade: json['quantidade'] as int,
      items: itemList,
    );
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
  int armor;
  int damagePerSecond;
  int attackPerSecond;
  int damagePerHitMin;
  int damagePerHitMax;
  List<ImplicitAndAffixData> implicit;
  List<ImplicitAndAffixData> affix;
  String? battletag;

  AuctionItemsData({
    required this.uuid,
    required this.name,
    required this.typeItem,
    required this.itemTier,
    required this.itemRarity,
    required this.itemPower,
    required this.itemLevel,
    required this.armor,
    required this.initialPrice,
    required this.actualPrice,
    required this.battletag,
    required this.socket,
    required this.damagePerSecond,
    required this.attackPerSecond,
    required this.damagePerHitMin,
    required this.damagePerHitMax,
    required this.implicit,
    required this.affix,
  });

  factory AuctionItemsData.fromJson(Map<String, dynamic> json) {
    final itemsImplicit = (json['implicit'] as List)
        .map((item) =>
            ImplicitAndAffixData.fromJson(item as Map<String, dynamic>))
        .toList();

    final itemsAffix = (json['affix'] as List)
        .map((item) =>
            ImplicitAndAffixData.fromJson(item as Map<String, dynamic>))
        .toList();

    return AuctionItemsData(
      uuid: json['uuid'] as String,
      name: json['name'] as String,
      typeItem: json['type_item'] as int,
      itemTier: json['tier'] as String,
      armor: json['armor'] as int,
      itemRarity: json['item_rarity'] as int,
      itemPower: json['item_power'] as String,
      itemLevel: json['item_level'] as int,
      initialPrice: json['initial_price'] as String,
      actualPrice: json['actual_price'] as String,
      battletag: json['battletag'] as String?,
      socket: json['socket'] as int,
      damagePerSecond: json['damage_per_second'] as int,
      attackPerSecond: json['attack_per_second'] as int,
      damagePerHitMin: json['damage_per_hit_min'] as int,
      damagePerHitMax: json['damage_per_hit_max'] as int,
      implicit: itemsImplicit,
      affix: itemsAffix,
    );
  }
}

class ImplicitAndAffixData {
  String effect;
  String value;

  ImplicitAndAffixData({
    required this.effect,
    required this.value,
  });

  factory ImplicitAndAffixData.fromJson(Map<String, dynamic> json) {
    return ImplicitAndAffixData(
      effect: json['title'] as String,
      value: json['value'] as String,
    );
  }
}
