import 'package:dtrade/leilao/andamento/LeilaoAndamentoRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeilaoAndamento extends ConsumerStatefulWidget {
  @override
  ConsumerState<LeilaoAndamento> createState() => LeilaoAndamentoState();
}

class LeilaoAndamentoState extends ConsumerState<LeilaoAndamento> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LeilaoAndamentoRow(
            name: "Accelerating Circle",
            ip: "817",
            category: "Ring",
            initial: "50M",
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
