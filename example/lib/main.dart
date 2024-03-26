import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tencent_map_flutter/tencent_map_flutter.dart';

import 'pages/add_remove_marker.dart';
import 'pages/camera_move.dart';
import 'pages/camera_region_move.dart';
import 'pages/flutter_marker.dart';
import 'pages/map_controls.dart';
import 'pages/map_controls_position.dart';
import 'pages/map_events.dart';
import 'pages/map_layers.dart';
import 'pages/map_location.dart';
import 'pages/map_logo_scale.dart';
import 'pages/map_restriction.dart';
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
    TencentMap.init(agreePrivacy: true);
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status != PermissionStatus.granted) {
      await Permission.location.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
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
            Item(
              MapTypesPage.title,
              (_) => const MapTypesPage(),
            ),
            Item(
              CameraMovePage.title,
              (_) => const CameraMovePage(),
            ),
            Item(
              CameraRegionMovePage.title,
              (_) => const CameraRegionMovePage(),
            ),
            Item(
              MapRestrictionPage.title,
              (_) => const MapRestrictionPage(),
            ),
            Item(
              MapLayersPage.title,
              (_) => const MapLayersPage(),
            ),
            Item(
              MapControlsPage.title,
              (_) => const MapControlsPage(),
            ),
            Item(
              MapControlsPositionPage.title,
              (_) => const MapControlsPositionPage(),
            ),
            Item(
              MapLogoScalePage.title,
              (_) => const MapLogoScalePage(),
            ),
            Item(
              MapEventsPage.title,
              (_) => const MapEventsPage(),
            ),
            Item(
              UserLocationPage.title,
              (_) => const UserLocationPage(),
            ),
            Item(
              AddRemoveMarkerPage.title,
              (_) => const AddRemoveMarkerPage(),
            ),
            Item(
              FlutterMarkerPage.title,
              (_) => const FlutterMarkerPage(),
            ),
          ]),
        ),
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
