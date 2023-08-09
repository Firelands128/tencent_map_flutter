import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';
import '../utils.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

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
      appBar: AppBar(title: const Text('地图事件')),
      body: TencentMap(
        mapType: context.isDark ? MapType.dark : MapType.normal,
        onTap: logger('onTap'),
        onTapPoi: logger('onTapPoi'),
        onLongPress: logger('onLongPress'),
        onCameraIdle: logger('onCameraIdle'),
      ),
    );
  }

  logger(String name) {
    // ignore: avoid_print
    return (dynamic data) => print('$name: ${data.encode()}');
  }
}
