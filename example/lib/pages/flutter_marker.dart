import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tencent_map/tencent_map.dart';

import '../utils.dart';

/// 显示Flutter widget标记页面
class FlutterMarkerPage extends StatefulWidget {
  /// 显示Flutter widget标记页面构造函数
  const FlutterMarkerPage({Key? key}) : super(key: key);

  @override
  State<FlutterMarkerPage> createState() => _FlutterMarkerPageState();
}

class _FlutterMarkerPageState extends State<FlutterMarkerPage> {
  late TencentMapController controller;
  final screenshot = ScreenshotController();

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter widget 标记')),
      body: Stack(children: [
        Screenshot(
          controller: screenshot,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              child: const FlutterLogo(size: 32),
            ),
          ),
        ),
        Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: TencentMap(
            mapType: context.isDark ? MapType.dark : MapType.normal,
            onMapCreated: onMapCreated,
          ),
        ),
      ]),
    );
  }

  void onMapCreated(TencentMapController controller) async {
    final position = Position(latitude: 39.909, longitude: 116.397);
    controller.moveCamera(CameraPosition(position: position));
    final image = await screenshot.capture();
    await controller.addMarker(
      MarkerOptions(position: position, icon: Bitmap(bytes: image)),
    );
  }
}
