import 'package:flutter/material.dart';
import 'package:tencent_map_flutter/tencent_map_flutter.dart';

import '../utils.dart';

/// 地图图层显示页面
class MapLayersPage extends StatefulWidget {
  /// 地图图层显示页面构造函数
  const MapLayersPage({Key? key}) : super(key: key);

  /// 地图图层显示页面标题
  static const title = '地图图层显示';

  @override
  State<MapLayersPage> createState() => _MapLayersPageState();
}

class _MapLayersPageState extends State<MapLayersPage> {
  static const traffic = '路况';
  static const buildings = '建筑物';
  static const buildings3d = '3D建筑物';

  final _state = {
    traffic: false,
    buildings: true,
    buildings3d: true,
  };
  final _items = [traffic, buildings, buildings3d];

  List<Widget> get items {
    return _items
        .map(
          (it) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: const EdgeInsets.only(top: 16), child: Text(it)),
              Switch(
                value: _state[it] ?? false,
                onChanged: (value) => setState(() => _state[it] = value),
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(MapLayersPage.title)),
      body: TencentMap(
        mapType: context.isDark ? MapType.dark : MapType.normal,
        trafficEnabled: _state[traffic] ?? false,
        buildingsEnabled: _state[buildings] ?? false,
        buildings3dEnabled: _state[buildings3d] ?? false,
        onMapCreated: (controller) {
          controller.moveCamera(CameraPosition(zoom: 18));
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }
}
