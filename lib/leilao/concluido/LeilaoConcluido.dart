import 'package:dtrade/leilao/concluido/Leil%C3%A3oConcluidoRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeilaoConcluido extends ConsumerStatefulWidget {
  @override
  ConsumerState<LeilaoConcluido> createState() => LeilaoConcluidoState();
}

class LeilaoConcluidoState extends ConsumerState<LeilaoConcluido> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LeilaoConcluidoRow(
            name: "Accelerating Circle",
            ip: "817",
            category: "Ring",
            winner: "Cleito#1234",
            value: "200M",
            description: [
              "Shadow Resistance",
              "Poison Resistance",
              "Resource Generation",
              "Critical Strike Damage",
              "Critical Strike Chance",
              "Vulnerable Damage"
            ])
      ],
    );
  }
}
