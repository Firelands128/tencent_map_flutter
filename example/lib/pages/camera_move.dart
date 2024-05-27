import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:tencent_map_flutter/tencent_map_flutter.dart';

import '../utils.dart';

/// 地图视野移动页面
class CameraMovePage extends StatefulWidget {
  /// 地图视野移动页面构造函数
  const CameraMovePage({Key? key}) : super(key: key);

  /// 地图视野移动页面标题
  static const title = '地图视野移动';

  @override
  State<CameraMovePage> createState() => _CameraMovePageState();
}

class _CameraMovePageState extends State<CameraMovePage> {
  late TencentMapController controller;
  var animated = false;
  static final position1 = CameraPosition(
    position: const LatLng(39.97837, 116.31363),
    zoom: 19,
    heading: 45,
    skew: 45,
  );
  static final position2 = CameraPosition(
    position: const LatLng(39.97537, 116.31363),
    zoom: 16,
    heading: 0,
    skew: 0,
  );

  @override
  Widget build(BuildContext context) {
    final duration = animated ? const Duration(seconds: 2) : null;
    return Scaffold(
      appBar: AppBar(
        title: const Text(CameraMovePage.title),
        actions: [
          Row(children: [
            const Text('动画'),
            Switch(
              value: animated,
              onChanged: (value) => setState(() => animated = value),
            ),
          ]),
        ],
      ),
      body: Stack(children: [
        TencentMap(
          mapType: context.isDark ? MapType.dark : MapType.normal,
          onMapCreated: (controller) => this.controller = controller,
        ),
        Positioned(
          top: 20,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text(' 视野 1 '),
                onPressed: () => controller.moveCamera(position1, duration),
              ),
              const SizedBox(width: 32),
              ElevatedButton(
                child: const Text(' 视野 2 '),
                onPressed: () => controller.moveCamera(position2, duration),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
