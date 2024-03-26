import 'package:flutter/material.dart';
import 'package:tencent_map_flutter/tencent_map_flutter.dart';
import 'package:tencent_map_flutter_example/utils.dart';

/// 限制地图区域页面
class MapRestrictionPage extends StatefulWidget {
  /// 限制地图区域页面构造函数
  const MapRestrictionPage({super.key});

  /// 限制地图区域页面标题
  static const title = '限制地图区域';

  @override
  State<MapRestrictionPage> createState() => _MapRestrictionPageState();
}

class _MapRestrictionPageState extends State<MapRestrictionPage> {
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
        title: const Text(MapRestrictionPage.title),
        actions: [
          Row(children: [
            const Text('限制'),
            Switch(
              value: restricted,
              onChanged: (value) {
                setState(() {
                  restricted = value;
                  if (value) {
                    controller.setRestrictRegion(
                      restrictedRegion,
                      RestrictRegionMode.fitWidth,
                    );
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
