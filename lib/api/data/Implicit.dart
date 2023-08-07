class Implicit {
  String status;
  List<ImplicitData> item;

  Implicit({required this.status, required this.item});

  factory Implicit.fromJson(Map<String, dynamic> json) {
    final itemList = (json['items'] as List)
        .map((item) => ImplicitData.fromJson(item as List<dynamic>))
        .toList();

    return Implicit(status: json['status'] as String, item: itemList);
  }
}

class ImplicitData {
  int id;
  String implicit;

  ImplicitData({required this.id, required this.implicit});

  factory ImplicitData.fromJson(List<dynamic> json) {
    return ImplicitData(id: json[0] as int, implicit: json[1] as String);
  }
}
