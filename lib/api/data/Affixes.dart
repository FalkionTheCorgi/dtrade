class Affixes {
  String status;
  List<AffixesData> item;

  Affixes({required this.status, required this.item});

  factory Affixes.fromJson(Map<String, dynamic> json) {
    final itemList = (json['items'] as List)
        .map((item) => AffixesData.fromJson(item as List<dynamic>))
        .toList();

    return Affixes(status: json['status'] as String, item: itemList);
  }
}

class AffixesData {
  int id;
  String affixe;

  AffixesData({required this.id, required this.affixe});

  factory AffixesData.fromJson(List<dynamic> json) {
    return AffixesData(id: json[0] as int, affixe: json[1] as String);
  }
}
