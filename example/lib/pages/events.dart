import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

import '../utils.dart';

/// 地图事件回调页面
class EventsPage extends StatefulWidget {
  /// 地图事件回调页面构造函数
  const EventsPage({Key? key}) : super(key: key);

  /// 地图事件回调页面标题
  static const title = '地图事件回调';

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.snackBar('请查看控制台输出');
    });
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text(EventsPage.title)),
      body: TencentMap(
        mapType: context.isDark ? MapType.dark : MapType.normal,
        onPress: logger('onTap'),
        onLongPress: logger('onLongPress'),
        onTapPoi: logger('onTapPoi'),
        onCameraMoveStart: logger("onCameraMoveStart"),
        onCameraMove: logger("onCameraMove"),
        onCameraMoveEnd: logger("onCameraMoveEnd"),
      ),
    );
  }

  logger(String name) {
    // ignore: avoid_print
    return (dynamic data) => print('$name: ${data.encode()}');
  }
}
