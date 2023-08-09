class Tier {
  String status;
  List<TierData> tierList;

  Tier({required this.status, required this.tierList});

  factory Tier.fromJson(Map<String, dynamic> json) {
    final itemList = (json['tier'] as List)
        .map((item) => TierData.fromJson(item as List<dynamic>))
        .toList();

    return Tier(status: json['status'] as String, tierList: itemList);
  }
}

class TierData {
  int id;
  String tier;

  TierData({required this.id, required this.tier});

  factory TierData.fromJson(List<dynamic> json) {
    return TierData(id: json[0] as int, tier: json[1] as String);
  }
}
