import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';
import 'package:tencent_map_example/utils.dart';

/// 地图视野范围移动页面
class CameraRegionMovePage extends StatefulWidget {
  /// 地图视野范围移动页面构造函数
  const CameraRegionMovePage({super.key});

  /// 地图视野范围移动页面标题
  static const title = '地图视野范围';

  @override
  State<CameraRegionMovePage> createState() => _CameraRegionMovePageState();
}

class _CameraRegionMovePageState extends State<CameraRegionMovePage> {
  late TencentMapController controller;
  var animated = false;

  Duration? get duration {
    return animated ? const Duration(seconds: 2) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(CameraRegionMovePage.title),
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
                onPressed: () => controller.moveCameraRegion(
                  Region(
                    north: 39.98437,
                    east: 116.31863,
                    south: 39.97837,
                    west: 116.31363,
                  ),
                  EdgePadding(
                    top: 0.2,
                    right: 0.2,
                    bottom: 0.2,
                    left: 0.2,
                  ),
                  duration,
                ),
              ),
              const SizedBox(width: 32),
              ElevatedButton(
                child: const Text(' 视野 2 '),
                onPressed: () => controller.moveCameraToRegionWithPosition(
                    [
                      Position(latitude: 39.98437, longitude: 116.31863),
                      Position(latitude: 39.98937, longitude: 116.32363),
                      Position(latitude: 39.98037, longitude: 116.31163),
                    ],
                    EdgePadding(
                      top: 0.2,
                      right: 0.2,
                      bottom: 0.2,
                      left: 0.2,
                    ),
                    duration),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
