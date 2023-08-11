import 'package:dtrade/extension/Extension.dart';
import 'package:dtrade/extension/Rules.dart';
import 'package:dtrade/leilao/concluido/LeilaoConcluidoRow.dart';
import 'package:dtrade/leilao/concluido/LeilaoConcluidoViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeilaoConcluido extends ConsumerStatefulWidget {
  @override
  ConsumerState<LeilaoConcluido> createState() => LeilaoConcluidoState();
}

class LeilaoConcluidoState extends ConsumerState<LeilaoConcluido> {
  @override
  void initState() {
    /*scrollController = ScrollController();
    scrollController.addListener(scrollListener);*/
    final model = ref.read(listLeilaoClosed);
    model.init();
    return super.initState();
  }

  @override
  void dispose() {
    //scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(listLeilaoClosed);
    double width = MediaQuery.of(context).size.width;

    if (model.list.status == 'INITIAL') {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (model.list.items.isNotEmpty) {
        return RefreshIndicator(
          onRefresh: () async {
            model.resetList();
            model.getList();
          },
          child: ListView.builder(
              itemCount: model.list.items.length + 1,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                if (index < model.list.items.length) {
                  return LeilaoConcluidoRow(
                    idPub: model.list.items[index].uuid,
                    name: model.list.items[index].name,
                    category: model.list.items[index].typeItem,
                    ip: model.list.items[index].itemPower,
                    lastBet:
                        model.list.items[index].battletag ?? "be the first",
                    initial: model.list.items[index].initialPrice,
                    value: model.list.items[index].actualPrice,
                    itemLevel: model.list.items[index].itemLevel,
                    socket: model.list.items[index].socket,
                    affixes: model.list.items[index].affix,
                    implicit: model.list.items[index].implicit,
                    sacred: model.list.items[index].itemTier,
                    armor: model.list.items[index].armor,
                    damagePerSecond: model.list.items[index].damagePerSecond,
                    attackPerSecond: model.list.items[index].attackPerSecond,
                    damagePerHitMin: model.list.items[index].damagePerHitMin,
                    damagePerHitMax: model.list.items[index].damagePerHitMax,
                  );
                } else {
                  if (model.list.quantidade - model.list.items.length > 0) {
                    return circularProgressIndicator(width);
                  }
                }
                return null;
              }),
        );
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            emptyList('No Auction finished'),
            SizedBox(
              height: 24.0,
              width: 24.0,
              child: TextButton(
                child: const Icon(Icons.forward_10_outlined),
                onPressed: () {
                  model.resetList();
                  model.getList();
                },
              ),
            )
          ],
        );
      }
    }
  }
}
