import 'package:dtrade/bottomsheet/configuracoes/Configuracoes.dart';
import 'package:dtrade/drawer/DrawerLayoutViewModel.dart';
import 'package:dtrade/drawer/data/D4Class.dart';
import 'package:dtrade/drawer/data/D4TypeGame.dart';
import 'package:dtrade/listitems/ListLeilaoViewModel.dart';
import 'package:dtrade/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerLayout extends ConsumerStatefulWidget {
  @override
  DrawerLayoutState createState() => DrawerLayoutState();
}

int _selectedIndex = 0;
int _selectedTypeGame = 0;

class DrawerLayoutState extends ConsumerState<DrawerLayout> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    final model = ref.read(drawerLayoutViewModel);
    model.getProfile();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTypeGameTapped(int index) {
    setState(() {
      _selectedTypeGame = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(drawerLayoutViewModel);
    final listModel = ref.watch(listLeilaoViewModel);

    return Drawer(
      child: Container(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  const SizedBox(
                    width: 90,
                    height: 90,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://picsum.photos/id/237/200/300'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  responseBattletag(),
                ],
              ),
            ),
            sectionList(
              "Type Game"
            ),
            typeGameItemList(
                RegisteredTypeGame.softcore.image,
                RegisteredTypeGame.softcore.typeGame,
                RegisteredTypeGame.softcore.rowItem
            ),
            typeGameItemList(
                RegisteredTypeGame.hardcore.image,
                RegisteredTypeGame.hardcore.typeGame,
                RegisteredTypeGame.hardcore.rowItem
            ),
            const Divider(),
            sectionList(
              "Classes"
            ),
            classItemList(
                RegisteredClass.barbarian.image,
                RegisteredClass.barbarian.className,
                RegisteredClass.barbarian.classD,
                RegisteredClass.barbarian.rowItem
            ),
            classItemList(
                RegisteredClass.rogue.image,
                RegisteredClass.rogue.className,
                RegisteredClass.rogue.classD,
                RegisteredClass.rogue.rowItem
            ),
            classItemList(
                RegisteredClass.druid.image,
                RegisteredClass.druid.className,
                RegisteredClass.druid.classD,
                RegisteredClass.druid.rowItem
            ),
            classItemList(
                RegisteredClass.necromancer.image,
                RegisteredClass.necromancer.className,
                RegisteredClass.necromancer.classD,
                RegisteredClass.necromancer.rowItem
            ),
            classItemList(
                RegisteredClass.sorcerer.image,
                RegisteredClass.sorcerer.className,
                RegisteredClass.sorcerer.classD,
                RegisteredClass.sorcerer.rowItem
            ),
            const Divider(),
            sectionList(
              "Options"
            ),
            ListTile(
              title: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 4),
                    Text('Settings',
                        style: TextStyle(fontFamily: 'Diablo', fontSize: 16))
                  ]),
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                    showDragHandle: true,
                    isDismissible: false,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return Configuracoes();
                    });
              },
            ),
            ListTile(
              title: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 4),
                    Text('Logout',
                        style: TextStyle(fontFamily: 'Diablo', fontSize: 16))
                  ]),
              onTap: () async {
                await model.signOut().then((value) {
                  Navigator.of(context)
                      .restorablePopAndPushNamed(AppRoutes.login);
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget responseBattletag() {
    final model = ref.watch(drawerLayoutViewModel);

    if (model.battletag.isEmpty) {
      return const SizedBox(
        width: 24.0, // Defina o valor desejado para a largura
        height: 24.0, // Defina o valor desejado para a altura
        child: CircularProgressIndicator(
          strokeWidth:
              3.0, // Defina o valor desejado para a largura da linha// Defina a cor desejada para o indicador
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ImageIcon(AssetImage('assets/Battlenet.png')),
          const SizedBox(width: 4),
          Text(model.battletag,
              style:
                  GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 18)))
        ],
      );
    }
  }

  Widget classItemList(
      AssetImage assetImage,
      String text,
      ClassD classItem,
      int rowIndex
  ){

    final model = ref.watch(drawerLayoutViewModel);
    final listModel = ref.watch(listLeilaoViewModel);

    return
      ListTile(
        selectedColor: Colors.red,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageIcon(assetImage),
              const SizedBox(width: 4),
              Text(text,
                  style: const TextStyle(fontFamily: 'Diablo', fontSize: 16))
            ]),
        selected: _selectedIndex == rowIndex,
        onTap: () {
          // Update the state of the app
          _onItemTapped(rowIndex);
          model.changeItem(classItem);
          listModel.resetList();
          listModel.getList(model.returnIntItemChoose());
          Navigator.pop(context);
        },
      );
  }

  Widget typeGameItemList(
      AssetImage assetImage,
      String text,
      int rowIndex
      ){

    final model = ref.watch(drawerLayoutViewModel);
    final listModel = ref.watch(listLeilaoViewModel);

    return
      ListTile(
        selectedColor: Colors.red,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageIcon(assetImage),
              const SizedBox(width: 4),
              Text(text,
                  style: const TextStyle(fontFamily: 'Diablo', fontSize: 16))
            ]),
        selected: _selectedTypeGame == rowIndex,
        onTap: () {
          _onTypeGameTapped(rowIndex);
          Navigator.pop(context);
        },
      );
  }

  Widget sectionList(
      String title
  ){
    return ListTile(
      title: Text(title,
          style: const TextStyle(fontFamily: 'Diablo', fontSize: 16)),
    );
  }

}
