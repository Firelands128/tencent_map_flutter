import 'package:flutter/material.dart';
import 'package:tencent_map_flutter/tencent_map_flutter.dart';

import '../utils.dart';

/// 地图控件显示页面
class MapControlsPage extends StatefulWidget {
  /// 地图控件显示页面构造函数
  const MapControlsPage({Key? key}) : super(key: key);

  /// 地图控件显示页面标题
  static const title = '地图控件显示';

  @override
  State<MapControlsPage> createState() => _MapControlsPageState();
}

class _MapControlsPageState extends State<MapControlsPage> {
  static const scale = '比例尺';
  static const scaleFade = '比例尺淡出';
  static const compass = '指南针';

  final _items = [scale, scaleFade, compass];
  final _state = {
    scale: true,
    scaleFade: true,
    compass: true,
  };

  List<Widget> get items {
    return _items
        .map(
          (item) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(item),
              ),
              Switch(
                value: _state[item]!,
                onChanged: (value) => setState(() => _state[item] = value),
              ),
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(MapControlsPage.title)),
      body: TencentMap(
        androidTexture: true,
        mapType: context.isDark ? MapType.dark : MapType.normal,
        scaleEnabled: _state[scale]!,
        scaleFadeEnabled: _state[scaleFade]!,
        compassEnabled: _state[compass]!,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    );
  }
}
