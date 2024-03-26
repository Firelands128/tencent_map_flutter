import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tencent_map_flutter/tencent_map_flutter.dart';

import '../utils.dart';

/// 地图事件回调页面
class MapEventsPage extends StatefulWidget {
  /// 地图事件回调页面构造函数
  const MapEventsPage({Key? key}) : super(key: key);

  /// 地图事件回调页面标题
  static const title = '地图事件回调';

  @override
  State<MapEventsPage> createState() => _MapEventsPageState();
}

class _MapEventsPageState extends State<MapEventsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.snackBar('请查看控制台输出');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(MapEventsPage.title)),
      body: TencentMap(
        mapType: context.isDark ? MapType.dark : MapType.normal,
        onScaleViewChanged: (unit) {
          stdout.writeln("onScaleViewChanged: ${unit.toString()}");
        },
        onPress: (position) {
          stdout.writeln("onTap: ${position.encode().toString()}");
        },
        onLongPress: (position) {
          stdout.writeln("onLongPress: ${position.encode().toString()}");
        },
        onTapPoi: (poi) {
          stdout.writeln("onTapPoi: ${poi.encode().toString()}");
        },
        onCameraMoveStart: (cameraPosition) {
          stdout.writeln("onCameraMoveStart: ${cameraPosition.encode().toString()}");
        },
        onCameraMove: (cameraPosition) {
          stdout.writeln("onCameraMove: ${cameraPosition.encode().toString()}");
        },
        onCameraMoveEnd: (cameraPosition) {
          stdout.writeln("onCameraMoveEnd: ${cameraPosition.encode().toString()}");
        },
        onUserLocationClick: (position) {
          stdout.writeln("onUserLocationClick: ${position.encode().toString()}");
        },
      ),
    );
  }
}
