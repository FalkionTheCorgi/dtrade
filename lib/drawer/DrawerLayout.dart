import 'package:dtrade/bottomsheet/configuracoes/Configuracoes.dart';
import 'package:dtrade/drawer/DrawerLayoutViewModel.dart';
import 'package:dtrade/listitems/ListLeilaoViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerLayout extends ConsumerStatefulWidget {
  @override
  DrawerLayoutState createState() => DrawerLayoutState();
}

int _selectedIndex = 0;

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
            ListTile(
              title: Text("Classes",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(fontSize: 16))),
            ),
            ListTile(
              selectedColor: Colors.red,
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const ImageIcon(AssetImage('assets/barbarian.png')),
                SizedBox(width: 4),
                Text('Bárbaro',
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 16)))
              ]),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                model.changeItem(ClassD.barbarian);
                listModel.getList(model.returnIntItemChoose(), 1);

                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              selectedColor: Colors.red,
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const ImageIcon(AssetImage('assets/rogue.png')),
                const SizedBox(width: 4),
                Text('Rogue',
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 16)))
              ]),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                model.changeItem(ClassD.rogue);
                listModel.getList(model.returnIntItemChoose(), 1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              selectedColor: Colors.red,
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const ImageIcon(AssetImage('assets/druid.png')),
                SizedBox(width: 4),
                Text('Druida',
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 16)))
              ]),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                model.changeItem(ClassD.druid);
                listModel.getList(model.returnIntItemChoose(), 1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              selectedColor: Colors.red,
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const ImageIcon(AssetImage('assets/necromancer.png')),
                SizedBox(width: 4),
                Text('Necromancer',
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 16)))
              ]),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                model.changeItem(ClassD.necromancer);
                listModel.getList(model.returnIntItemChoose(), 1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              selectedColor: Colors.red,
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const ImageIcon(AssetImage('assets/sorcerer.png')),
                SizedBox(width: 4),
                Text('Mago',
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 16)))
              ]),
              selected: _selectedIndex == 4,
              onTap: () {
                // Update the state of the app
                _onItemTapped(4);
                model.changeItem(ClassD.sorcerer);
                listModel.getList(model.returnIntItemChoose(), 1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: Text("Opções",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(fontSize: 16))),
            ),
            ListTile(
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(Icons.settings),
                SizedBox(width: 4),
                Text('Configurações',
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 16)))
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
              title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(Icons.logout),
                SizedBox(width: 4),
                Text('Sair',
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 16)))
              ]),
              onTap: () {
                // Update the state of the app
                // Then close the drawer
                Navigator.pop(context);
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
              style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 18)))
        ],
      );
    }
  }
}
