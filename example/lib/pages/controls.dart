import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

import '../utils.dart';

class ControlsPage extends StatefulWidget {
  const ControlsPage({Key? key}) : super(key: key);

  @override
  createState() => _State();
}

const scaleControls = '比例尺';
const compass = '指南针';
const myLocationButtonEnabled = '定位按钮';

class _State extends State<ControlsPage> {
  final _state = <String, bool>{};
  final _items = [scaleControls, compass, myLocationButtonEnabled];

  @override
  build(context) {
    final items = _items.map(
      (it) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: const EdgeInsets.only(top: 16), child: Text(it)),
          Switch(
            value: _state[it] ?? true,
            onChanged: (value) => setState(() => _state[it] = value),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('控件：比例尺、指南针、定位按钮')),
      body: TencentMap(
        mapType: context.isDark ? MapType.dark : MapType.normal,
        scaleControlsEnabled: _state[scaleControls] ?? true,
        compassEnabled: _state[compass] ?? true,
        myLocationButtonEnabled: _state[myLocationButtonEnabled] ?? true,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.toList(),
      ),
    );
  }
}
