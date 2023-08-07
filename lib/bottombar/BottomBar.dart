import 'package:dtrade/bottombar/BottomBarViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final model = ref.watch(bottomBarViewModel);

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.balance_outlined),
          label: 'Leilão',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
          ),
          label: 'Meus Leilões',
        ),
      ],
      currentIndex: model.selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      onTap: model.onItemTapped,
      backgroundColor: Colors.black,
      selectedLabelStyle: const TextStyle(fontFamily: 'Diablo'),
      unselectedLabelStyle: const TextStyle(fontFamily: 'Diablo'),
    );
  }
}
