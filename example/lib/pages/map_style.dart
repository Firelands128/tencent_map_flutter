import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

/// 地图样式切换页面
class MapStylePage extends StatefulWidget {
  /// 地图样式切换页面构造函数
  const MapStylePage({Key? key}) : super(key: key);

  /// 地图样式切换页面标题
  static const title = '地图样式切换';

  @override
  State<MapStylePage> createState() => _MapStylePageState();
}

class _MapStylePageState extends State<MapStylePage> {
  int? mapStyle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MapStylePage.title),
        actions: [
          CupertinoButton(
            onPressed: showOptions,
            child: Text(
              mapStyle?.toString() ?? "未配置",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ],
      ),
      body: TencentMap(mapStyle: mapStyle),
    );
  }

  void showOptions() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(children: [
        for (final index in [1, 2, 3])
          SimpleDialogOption(
            onPressed: () {
              setState(() => mapStyle = index);
              Navigator.pop(context);
            },
            child: Row(children: [
              Icon(
                index == mapStyle ? Icons.check_circle_outlined : Icons.radio_button_unchecked,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(index.toString()),
            ]),
          ),
      ]),
    );
  }
}
