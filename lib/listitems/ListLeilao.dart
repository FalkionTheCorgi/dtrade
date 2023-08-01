import 'package:dtrade/api/data/AuctionItems.dart';
import 'package:dtrade/listitems/ListLeilaoRow.dart';
import 'package:dtrade/listitems/ListLeilaoViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ListLeilao extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ListLeilaoState();
}

class ListLeilaoState extends ConsumerState<ListLeilao> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(listLeilaoViewModel);

    return FutureBuilder(
        future: model.getList(1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Nenhum Leilão Aberto',
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                      fontSize: 62,
                    ))));
          } else {
            // Se a função for concluída com sucesso, verifica o resultado.

            if (snapshot.data is AuctionItems) {
              AuctionItems items = snapshot.data as AuctionItems;

              return items.items.isNotEmpty
                  ? ListView(
                      padding: const EdgeInsets.all(8),
                      children: <Widget>[
                          for (var item in items.items)
                            ListLeilaoRow(
                                idPub: item.uuid,
                                name: item.name,
                                category: item.typeItem,
                                ip: item.itemPower,
                                lastBet: item.battletag ?? "Seja o primeiro",
                                initial: item.initialPrice,
                                value: item.actualPrice,
                                description: item.description)
                        ])
                  : Center(
                      child: Text('Nenhum Leilão Aberto',
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                            fontSize: 20,
                          ))));
            } else {
              return Center(
                  child: Text('Nenhum Leilão Aberto',
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                        fontSize: 20,
                      ))));
            }
          }
        });
  }
}
