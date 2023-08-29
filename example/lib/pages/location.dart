import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tencent_map/tencent_map.dart';

import '../utils.dart';

/// 定位页面
class LocationPage extends StatefulWidget {
  /// 定位页面构造函数
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late TencentMapController controller;

  @override
  void initState() {
    super.initState();
    Permission.location.request();
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('定位'),
        actions: [
          TextButton(
            onPressed: () async {
              Location location = await controller.getUserLocation();
              controller.moveCamera(
                CameraPosition(
                  position: location.position,
                  heading: location.heading,
                ),
              );
            },
            child: const Text("当前位置"),
          ),
        ],
      ),
      body: TencentMap(
        mapType: context.isDark ? MapType.dark : MapType.normal,
        androidTexture: true,
        myLocationEnabled: true,
        userLocationType: UserLocationType.trackingLocationRotate,
        onLocation: (location) {
          // ignore: avoid_print
          print('${location.position.latitude}, ${location.position.longitude}');
        },
        onMapCreated: (controller) async {
          this.controller = controller;
        },
      ),
    );
  }
}
