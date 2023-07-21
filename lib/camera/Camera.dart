import 'package:camera_camera/camera_camera.dart';
import 'package:dtrade/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Camera extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CameraCamera(
        onFile: (file) async => Navigator.pushNamed(context, AppRoutes.previewcam,
            arguments: file));
  }
}
