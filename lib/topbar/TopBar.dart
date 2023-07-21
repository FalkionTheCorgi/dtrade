import 'package:dtrade/bottombar/BottomBarViewModel.dart';
import 'package:dtrade/drawer/DrawerLayoutViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBar extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => TopBarState();
}

class TopBarState extends ConsumerState<TopBar> {
  @override
  Widget build(BuildContext context) {
    final bottomBarModel = ref.watch(bottomBarViewModel);
    final drawerModel = ref.watch(drawerLayoutViewModel);

    return AnimatedContainer(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 600),
        child: bottomBarModel.selectedIndex == 0
            ? AppBar(
                title: Text(
                  'DTRADE - ${drawerModel.returnItemDrawerChoose()}',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                backgroundColor: Colors.black,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ],
                leading: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                automaticallyImplyLeading: false)
            : AppBar(
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'EM ANDAMENTO'),
                    Tab(text: 'CONCLUÍDOS'),
                  ],
                  indicatorColor: Colors.white,
                ),
                title: Text(
                  'DTRADE',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                backgroundColor: Colors.black,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Adicione a lógica para abrir as configurações aqui
                    },
                  ),
                ],
                automaticallyImplyLeading: false));
  }
}
