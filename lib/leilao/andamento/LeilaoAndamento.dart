import 'package:dtrade/extension/Extension.dart';
import 'package:dtrade/leilao/andamento/LeilaoAndamentoRow.dart';
import 'package:dtrade/leilao/andamento/LeilaoAndamentoViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LeilaoAndamento extends ConsumerStatefulWidget {
  @override
  ConsumerState<LeilaoAndamento> createState() => LeilaoAndamentoState();
}

class LeilaoAndamentoState extends ConsumerState<LeilaoAndamento> {
  @override
  void initState() {
    /*scrollController = ScrollController();
    scrollController.addListener(scrollListener);*/
    final model = ref.read(listLeilaoAndamento);
    model.init(1);
    return super.initState();
  }

  @override
  void dispose() {
    //scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(listLeilaoAndamento);
    double width = MediaQuery.of(context).size.width;

    if (model.list.status == 'INITIAL') {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (model.list.items.isNotEmpty) {
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              model.list.items.clear();
            });
            model.getList(1);
          },
          child: ListView.builder(
              itemCount: model.list.items.length + 1,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                if (index < model.list.items.length) {
                  return LeilaoAndamentoRow(
                      idPub: model.list.items[index].uuid,
                      name: model.list.items[index].name,
                      category: model.list.items[index].typeItem,
                      ip: model.list.items[index].itemPower,
                      lastBet:
                          model.list.items[index].battletag ?? "Não iniciado",
                      initial: model.list.items[index].initialPrice,
                      value: model.list.items[index].actualPrice,
                      description: model.list.items[index].description);
                } else {
                  if (model.list.quantidade - model.list.items.length > 0) {
                    return circularProgressIndicator(width);
                  }
                }
                return null;
              }),
        );
      } else {
        return Center(
            child: Text('Nenhum Leilão Cadastrado',
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                  fontSize: 20,
                ))));
      }
    }
  }
}
