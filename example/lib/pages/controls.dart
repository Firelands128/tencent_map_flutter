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
  static const scaleControls = '比例尺';
  static const compass = '指南针';

  final _items = [scaleControls, compass];
  final _state = {
    scaleControls: true,
    compass: true,
  };

  @override
  build(context) {
    final items = _items.map(
      (item) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: const EdgeInsets.only(top: 16), child: Text(item)),
          Switch(
            value: _state[item]!,
            onChanged: (value) => setState(() => _state[item] = value),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(title: const Text(ControlsPage.title)),
      body: TencentMap(
        androidTexture: true,
        mapType: context.isDark ? MapType.dark : MapType.normal,
        scaleControlsEnabled: _state[scaleControls]!,
        compassEnabled: _state[compass]!,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.toList(),
      ),
    );
  }
}
