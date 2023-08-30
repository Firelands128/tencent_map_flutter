import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

import '../utils.dart';

/// 控件显示页面：比例尺、指南针
class ControlsPage extends StatefulWidget {
  /// 控件显示页面构造函数
  const ControlsPage({Key? key}) : super(key: key);

  /// 控件显示页面标题
  static const title = '控件：比例尺、指南针';

  @override
  State<ControlsPage> createState() => _ControlsPageState();
}

class _ControlsPageState extends State<ControlsPage> {
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
    return _items.map(
          (item) =>
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: const EdgeInsets.only(top: 16), child: Text(item)),
              Switch(
                value: _state[item]!,
                onChanged: (value) => setState(() => _state[item] = value),
              ),
            ],
          ),
    ).toList();
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text(ControlsPage.title)),
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
