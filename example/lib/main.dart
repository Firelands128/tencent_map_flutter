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
          Item(MapTypesPage.title, (_) => const MapTypesPage()),
          Item(MapStylePage.title, (_) => const MapStylePage()),
          Item(CameraMovePage.title, (_) => const CameraMovePage()),
          Item(CameraRegionMovePage.title, (_) => const CameraRegionMovePage()),
          Item(LayersPage.title, (_) => const LayersPage()),
          Item(ControlsPage.title, (_) => const ControlsPage()),
          Item(EventsPage.title, (_) => const EventsPage()),
          Item(LocationPage.title, (_) => const LocationPage()),
          Item(AddRemoveMarkerPage.title, (_) => const AddRemoveMarkerPage()),
          Item(FlutterMarkerPage.title, (_) => const FlutterMarkerPage()),
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
