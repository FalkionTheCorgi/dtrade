import 'package:dtrade/TopBar/TopBar.dart';
import 'package:dtrade/bottombar/BottomBar.dart';
import 'package:dtrade/bottombar/BottomBarViewModel.dart';
import 'package:dtrade/addItem/AddItemViewModel.dart';
import 'package:dtrade/data/DataItemRegister.dart';
import 'package:dtrade/drawer/DrawerLayout.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:dtrade/leilao/andamento/LeilaoAndamento.dart';
import 'package:dtrade/leilao/concluido/LeilaoConcluido.dart';
import 'package:dtrade/listitems/ListLeilao.dart';
import 'package:dtrade/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabBarController extends ConsumerStatefulWidget {
  const TabBarController({Key? key}) : super(key: key);

  @override
  ConsumerState<TabBarController> createState() => TabBarControllerState();
}

class TabBarControllerState extends ConsumerState<TabBarController> {
  final key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bottomBarModel = ref.watch(bottomBarViewModel);
    final model = ref.watch(addItemViewModel);

    return DefaultTabController(
        length: bottomBarModel.selectedIndex == 0 ? 1 : 2,
        child: Scaffold(
          key: key,
          drawer: DrawerLayout(),
          appBar: PreferredSize(
              preferredSize: bottomBarModel.selectedIndex == 0
                  ? const Size.fromHeight(50.0)
                  : const Size.fromHeight(90.0),
              child: TopBar()),
          bottomNavigationBar: const BottomBar(),
          body: TabBarView(
            children: [
              if (bottomBarModel.selectedIndex != 0) LeilaoAndamento(),
              if (bottomBarModel.selectedIndex != 0) LeilaoConcluido(),
              if (bottomBarModel.selectedIndex == 0) ListLeilao()
            ],
          ),
          floatingActionButton: Visibility(
              visible: bottomBarModel.selectedIndex == 0,
              child: FloatingActionButton(
                onPressed: () {
                  model.file = null;
                  //model.bottomsheetType = false;
                  model.dataItem = DataItemRegister();
                  /*showModalBottomSheet(
                      showDragHandle: true,
                      isDismissible: false,
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return AddItemImage();
                      });*/
                  Navigator.of(context)
                      .pushNamed(AppRoutes.addItem, arguments: model.dataItem);
                },
                backgroundColor: ColorTheme.colorFirst,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ));
  }
}
