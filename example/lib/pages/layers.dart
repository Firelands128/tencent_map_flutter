import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

import '../utils.dart';

/// 图层显示页面：路况、室内图、3D建筑
class LayersPage extends StatefulWidget {
  /// 图层显示页面构造函数
  const LayersPage({Key? key}) : super(key: key);

  @override
  createState() => _State();
}

class _State extends State<LayersPage> {
  static const traffic = '路况';
  static const indoor = '室内图';
  static const buildings = '建筑物';
  static const buildings3d = '3D建筑物';

  final _state = {
    traffic: false,
    indoor: false,
    buildings: true,
    buildings3d: true,
  };
  final _items = [traffic, indoor, buildings, buildings3d];

  @override
  build(context) {
    final items = _items.map(
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
    );
    return Scaffold(
      appBar: AppBar(title: const Text('图层：路况、室内图、3D 建筑')),
      body: TencentMap(
        mapType: context.isDark ? MapType.dark : MapType.normal,
        trafficEnabled: _state[traffic] ?? false,
        indoorViewEnabled: _state[indoor] ?? false,
        indoorPickerEnabled: _state[indoor] ?? false,
        buildingsEnabled: _state[buildings] ?? false,
        buildings3dEnabled: _state[buildings3d] ?? false,
        onMapCreated: (controller) {
          controller.moveCamera(CameraPosition(zoom: 18));
        },
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.toList(),
      ),
    );
  }
}
