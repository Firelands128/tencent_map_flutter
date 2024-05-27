import 'package:flutter/material.dart';
import 'package:tencent_map_flutter/tencent_map_flutter.dart';

import '../utils.dart';

/// 地图定位页面
class UserLocationPage extends StatefulWidget {
  /// 地图定位页面构造函数
  const UserLocationPage({Key? key}) : super(key: key);

  /// 地图定位页面标题
  static const title = '地图定位';

  @override
  State<UserLocationPage> createState() => _UserLocationPageState();
}

class _UserLocationPageState extends State<UserLocationPage> {
  late TencentMapController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(UserLocationPage.title),
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
          debugPrint(
            '${location.position.latitude}, ${location.position.longitude}',
          );
        },
        onMapCreated: (controller) async {
          this.controller = controller;
        },
      ),
    );
  }
}
