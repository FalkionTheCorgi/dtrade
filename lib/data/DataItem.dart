class DataItem {
  final String name;
  final String ip;
  final String category;
  final String initialPrice;
  final String actualPrice;
  final List<String> descriptionItem;

  const DataItem(
      {required this.name,
      required this.ip,
      required this.category,
      required this.initialPrice,
      required this.actualPrice,
      required this.descriptionItem});
}
