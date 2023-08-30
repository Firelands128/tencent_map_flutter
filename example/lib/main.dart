import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

import 'pages/add_remove_marker.dart';
import 'pages/camera_move.dart';
import 'pages/camera_region_move.dart';
import 'pages/controls.dart';
import 'pages/events.dart';
import 'pages/flutter_marker.dart';
import 'pages/layers.dart';
import 'pages/location.dart';
import 'pages/map_style.dart';
import 'pages/map_types.dart';

void main() {
  runApp(const App());
}

/// 主程序
class App extends StatefulWidget {
  /// 主程序构造函数
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    TencentMap.init(
      agreePrivacy: true,
      iosApiKey: 'TOCBZ-IY266-74KSP-MTWNM-PBYAT-LWB3O',
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(),
      ),
      home: Scaffold(
        body: ListView(children: [
          Item('地图类型切换', (_) => const MapTypesPage()),
          Item('地图样式切换', (_) => const MapStylePage()),
          Item('视野移动', (_) => const CameraMovePage()),
          Item('视野范围设置', (_) => const CameraRegionMovePage()),
          Item('图层：路况、室内图、3D 建筑', (_) => const LayersPage()),
          Item('控件：比例尺、指南针', (_) => const ControlsPage()),
          Item('地图事件回调', (_) => const EventsPage()),
          Item('定位', (_) => const LocationPage()),
          Item('动态添加、移除标记', (_) => const AddRemoveMarkerPage()),
          Item('Flutter widget 标记', (_) => const FlutterMarkerPage()),
        ]),
      ),
    );
  }
}

/// 示例项目
class Item extends StatelessWidget {
  /// 示例标题
  final String title;

  /// 示例创建器
  final Widget Function(BuildContext) builder;

  /// 示例项目构造函数
  const Item(this.title, this.builder, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: builder)),
    );
  }
}
