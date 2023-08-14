import 'package:dtrade/bottombar/BottomBarViewModel.dart';
import 'package:dtrade/drawer/DrawerLayoutViewModel.dart';
import 'package:dtrade/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBar extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => TopBarState();
}

class TopBarState extends ConsumerState<TopBar> {
  @override
  Widget build(BuildContext context) {
    final bottomBarModel = ref.watch(bottomBarViewModel);
    final drawerModel = ref.watch(drawerLayoutViewModel);

    return AnimatedSize(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 600),
        child: bottomBarModel.selectedIndex == 0
            ? AppBar(
                title: Text(
                  'DTRADE - ${drawerModel.returnItemDrawerChoose()}',
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'Diablo'),
                ),
                backgroundColor: Colors.black,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.filterItem, arguments: 1);
                      /*showModalBottomSheet(
                          showDragHandle: true,
                          isDismissible: false,
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return FilterItems();
                          });*/
                    },
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
                    Tab(
                        child: Text('PROGRESS',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Diablo'))),
                    Tab(
                        child: Text('FINISHED',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Diablo')))
                  ],
                  indicatorColor: Colors.white,
                ),
                title: const Text('DTRADE',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Diablo')),
                backgroundColor: Colors.black,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.filterItem, arguments: 1);
                      // Adicione a lógica para abrir as configurações aqui
                    },
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
                automaticallyImplyLeading: false));
  }
}
