import 'dart:io';

import 'package:dtrade/bottomsheet/addItem/AddItemManually.dart';
import 'package:dtrade/bottomsheet/filter/FilterItems.dart';
import 'package:dtrade/cadastro/Cadastro.dart';
import 'package:dtrade/camera/PreviewCamera.dart';
import 'package:dtrade/camera/camera.dart';
import 'package:dtrade/data/DataItemRegister.dart';
import 'package:dtrade/login/Login.dart';
import 'package:dtrade/start/start.dart';
import 'package:dtrade/tabbar/TabBarController.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String start = '/';
  static const String login = '/login';
  static const String cadastro = '/cadastro';
  static const String tabbar = '/tabbar';
  static const String camera = '/camera';
  static const String previewcam = '/previewcam';
  static const String addItem = '/addItem';
  static const String filterItem = '/filter';

  static Route<dynamic> generateRoute(RouteSettings settings,
      {Object? arguments}) {
    switch (settings.name) {
      case start:
        return MaterialPageRoute(builder: (_) => Start());
      case login:
        return MaterialPageRoute(builder: (_) => Login());
      case cadastro:
        return AppRoutes().buildPageRouteBuilder(Cadastro());
      case camera:
        return AppRoutes().buildPageRouteBuilder(Camera());
      case previewcam:
        final args = settings.arguments as File;
        return AppRoutes().buildPageRouteBuilder(PreviewCamera(file: args));
      case tabbar:
        return AppRoutes().buildPageRouteBuilder(const TabBarController());
      case addItem:
        final args = settings.arguments as DataItemRegister;
        return AppRoutes().buildPageRouteBuilder(AddItemManually(
            nameItem: args.nameItem,
            categoryName: args.categoryName,
            rarity: args.rarity,
            sacredItem: args.sacredItem,
            itemPower: args.itemPower,
            lvlRankItem: args.lvlRankItem));
      case filterItem:
        final args = settings.arguments as int;
        return AppRoutes().buildPageRouteBuilder(FilterItems(
          screenFilter: args,
        ));
      default:
        return MaterialPageRoute(builder: (_) => const Login());
    }
  }

  PageRouteBuilder<dynamic> buildPageRouteBuilder(Widget view) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (context, animation, secondaryAnimation) => view,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 1000),
    );
  }
}
