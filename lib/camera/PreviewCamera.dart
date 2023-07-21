import 'dart:io';

import 'package:dtrade/tabbar/TabBarControllerViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreviewCamera extends ConsumerStatefulWidget {
  final File file;

  const PreviewCamera({Key? key, required this.file}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PreviewCameraState();
}

class PreviewCameraState extends ConsumerState<PreviewCamera> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    final tabBarModel = ref.watch(tabBarViewModel);
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Stack(
            children: [
              Positioned.fill(
                  child: Image.file(
                widget.file,
                fit: BoxFit.cover,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.black.withOpacity(0.5),
                              child: IconButton(
                                  icon: const Icon(Icons.check,
                                      color: Colors.white, size: 30),
                                  onPressed: () => {
                                        tabBarModel.setFile(widget.file),
                                        Navigator.of(context)
                                            .popUntil((_) => count++ >= 2)
                                      })))),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.black.withOpacity(0.5),
                              child: IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.white, size: 30),
                                  onPressed: () =>
                                      {Navigator.of(context).pop()}))))
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
