import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:dtrade/extension/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class DialogAddImage extends ConsumerStatefulWidget {
  final void Function(File) onPressedCallback;

  DialogAddImage({required this.onPressedCallback});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DialogAddImageState();
}

class DialogAddImageState extends ConsumerState<DialogAddImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(
                Icons.browse_gallery_outlined,
                color: Colors.white,
              ),
              label: Text('Galeria',
                  style: GoogleFonts.roboto(
                      textStyle:
                          const TextStyle(fontSize: 14, color: Colors.white))),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () async {
                final picker = ImagePicker();
                picker.pickImage(source: ImageSource.gallery).then((value) {
                  widget.onPressedCallback(File(value!.path));
                  Navigator.of(context).pop();
                });
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
              label: Text('Camera',
                  style: GoogleFonts.roboto(
                      textStyle:
                          const TextStyle(fontSize: 14, color: Colors.white))),
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorTheme.colorFirst),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CameraCamera(
                              onFile: (file) {
                                widget.onPressedCallback(file);
                                Navigator.pop(context);
                              },
                            )));
              },
            ),
          ],
        ));
  }
}
