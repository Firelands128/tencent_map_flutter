import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tencent_map/tencent_map.dart';

import '../utils.dart';

class FlutterMarkerPage extends StatefulWidget {
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
    final position = LatLng(latitude: 39.909, longitude: 116.397);
    controller.moveCamera(CameraPosition(target: position));
    final image = await screenshot.capture();
    await controller.addMarket(
      MarkerOptions(position: position, icon: Bitmap(bytes: image)),
    );
  }
}
