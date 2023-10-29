class ChipItem {
  int id;
  String value;
  String item;

  ChipItem({required this.id, required this.value, required this.item});

  Map<String, dynamic> toJson() => {'id': id, 'value': value, 'item': item};

}
