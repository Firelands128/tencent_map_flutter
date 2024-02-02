import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';
import 'package:tencent_map_example/utils.dart';

/// 限制地图区域页面
class RestrictMapPage extends StatefulWidget {
  /// 限制地图区域页面构造函数
  const RestrictMapPage({super.key});

  /// 限制地图区域页面标题
  static const title = '限制地图区域';

  @override
  State<RestrictMapPage> createState() => _RestrictMapPageState();
}

class _RestrictMapPageState extends State<RestrictMapPage> {
  final Region restrictedRegion = Region(
    north: 39.98437,
    east: 116.31863,
    south: 39.97837,
    west: 116.31363,
  );
  late TencentMapController controller;
  var restricted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(RestrictMapPage.title),
        actions: [
          Row(children: [
            const Text('限制'),
            Switch(
              value: restricted,
              onChanged: (value) {
                setState(() {
                  restricted = value;
                  if (value) {
                    controller.setRestrictRegion(restrictedRegion, RestrictRegionMode.fitWidth);
                  } else {
                    controller.removeRestrictRegion();
                  }
                });
              },
            ),
          ]),
        ],
      ),
      body: Stack(
        children: [
          TencentMap(
            mapType: context.isDark ? MapType.dark : MapType.normal,
            onMapCreated: (controller) => this.controller = controller,
          ),
        ],
      ),
    );
  }
}
