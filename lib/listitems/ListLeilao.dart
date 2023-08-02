import 'package:dtrade/api/data/AuctionItems.dart';
import 'package:dtrade/drawer/DrawerLayoutViewModel.dart';
import 'package:dtrade/extension/Extension.dart';
import 'package:dtrade/listitems/ListLeilaoRow.dart';
import 'package:dtrade/listitems/ListLeilaoViewModel.dart';
import 'package:dtrade/login/LoginViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ListLeilao extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ListLeilaoState();
}

class ListLeilaoState extends ConsumerState<ListLeilao> {
  /*scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        showIsLoading = true;
      });
    } else {
      setState(() {
        showIsLoading = false;
      });
    }
  }*/

  @override
  void initState() {
    /*scrollController = ScrollController();
    scrollController.addListener(scrollListener);*/
    final model = ref.read(listLeilaoViewModel);
    final drawerModel = ref.read(drawerLayoutViewModel);
    model.init(drawerModel.returnIntItemChoose(), 1);
    return super.initState();
  }

  @override
  void dispose() {
    //scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(listLeilaoViewModel);
    final drawerModel = ref.watch(drawerLayoutViewModel);
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
            model.getList(drawerModel.returnIntItemChoose(), 1).then((value) {
              if (value is AuctionItems) {
                setState(() {
                  model.list.items = value.items;
                });
              }
            });
          },
          child: ListView.builder(
              itemCount: model.list.items.length + 1,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                if (index < model.list.items.length) {
                  return ListLeilaoRow(
                      idPub: model.list.items[index].uuid,
                      name: model.list.items[index].name,
                      category: model.list.items[index].typeItem,
                      ip: model.list.items[index].itemPower,
                      lastBet: model.list.items[index].battletag ??
                          "Seja o primeiro",
                      initial: model.list.items[index].initialPrice,
                      value: model.list.items[index].actualPrice,
                      description: model.list.items[index].description);
                } else {
                  if (model.list.quantidade - model.list.items.length > 0) {
                    return circularProgressIndicator(width);
                  }
                }
              }),
        );
      } else {
        return Center(
            child: Text('Nenhum Leilão Aberto',
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                  fontSize: 20,
                ))));
      }
    }
  }
}
