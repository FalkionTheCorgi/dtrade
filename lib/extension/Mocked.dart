import 'package:dtrade/data/dataitem.dart';

class Mocked {
  static final List<DataItem> items = [
    const DataItem(
        name: "Item1",
        ip: "824",
        category: "Body Armour",
        initialPrice: "29M",
        actualPrice: "147.542",
        descriptionItem: [
          "Description1",
          "Description2",
          "Description3",
          "Description4",
          "Description5"
        ]),
    const DataItem(
        name: "Item2",
        ip: "800",
        category: "Ring",
        initialPrice: "32M",
        actualPrice: "101.745",
        descriptionItem: [
          "Description1",
          "Description2",
          "Description3",
          "Description4",
          "Description5"
        ]),
    const DataItem(
        name: "Item3",
        ip: "731",
        category: "Hat",
        initialPrice: "17M",
        actualPrice: "18.234",
        descriptionItem: [
          "Description1",
          "Description2",
          "Description3",
          "Description4",
          "Description5"
        ]),
    const DataItem(
        name: "Item4",
        ip: "856",
        category: "Boots",
        initialPrice: "67M",
        actualPrice: "799.678",
        descriptionItem: [
          "Description1",
          "Description2",
          "Description3",
          "Description4",
          "Description5"
        ]),
    const DataItem(
        name: "Item5",
        ip: "678",
        category: "Boots",
        initialPrice: "200M",
        actualPrice: "878M",
        descriptionItem: [
          "Description1",
          "Description2",
          "Description3",
          "Description4",
          "Description5"
        ]),
    const DataItem(
        name: "Item6",
        ip: "761",
        category: "Ring",
        initialPrice: "456M",
        actualPrice: "678.325",
        descriptionItem: [
          "Description1",
          "Description2",
          "Description3",
          "Description4",
          "Description5"
        ]),
  ];

  Mocked._();

  static final instance = Mocked._();
}
