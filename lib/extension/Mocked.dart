import 'package:dtrade/data/DataDropDownCategory.dart';
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

  static final listItemsCategory = [
    const DataDropDownCategory(value: -1, nameCategory: 'Select'),
    const DataDropDownCategory(value: 0, nameCategory: 'Axe'),
    const DataDropDownCategory(value: 1, nameCategory: 'Bow'),
    const DataDropDownCategory(value: 2, nameCategory: 'Dagger'),
    const DataDropDownCategory(value: 3, nameCategory: 'Two-Handed Axe'),
    const DataDropDownCategory(value: 4, nameCategory: 'Two-Handed Mace'),
    const DataDropDownCategory(value: 5, nameCategory: 'Staff'),
    const DataDropDownCategory(value: 6, nameCategory: 'Two-Handed Staff'),
    const DataDropDownCategory(value: 7, nameCategory: 'Sword'),
    const DataDropDownCategory(value: 8, nameCategory: 'Two-Handed Sword'),
    const DataDropDownCategory(value: 9, nameCategory: 'Scythe'),
    const DataDropDownCategory(value: 10, nameCategory: 'Two-Handed Scythe'),
    const DataDropDownCategory(value: 11, nameCategory: 'Wand'),
    const DataDropDownCategory(value: 12, nameCategory: 'Mace'),
    const DataDropDownCategory(value: 13, nameCategory: 'Crossbow'),
    const DataDropDownCategory(value: 14, nameCategory: 'Helm'),
    const DataDropDownCategory(value: 15, nameCategory: 'Glove'),
    const DataDropDownCategory(value: 16, nameCategory: 'Pants'),
    const DataDropDownCategory(value: 17, nameCategory: 'Boots'),
    const DataDropDownCategory(value: 18, nameCategory: 'Armor'),
  ];

  static final listItemsRarity = [
    const DataDropDownCategory(value: 0, nameCategory: 'Common'),
    const DataDropDownCategory(value: 1, nameCategory: 'Magic'),
    const DataDropDownCategory(value: 2, nameCategory: 'Rare'),
  ];

  static final listItemsTier = [
    const DataDropDownCategory(value: 0, nameCategory: 'Normal'),
    const DataDropDownCategory(value: 1, nameCategory: 'Sacred'),
    const DataDropDownCategory(value: 2, nameCategory: 'Ancestral'),
  ];

  Mocked._();

  static final instance = Mocked._();
}
