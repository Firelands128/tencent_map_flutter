import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';

class MapTypeItem {
  final String name;
  final int value;

  MapTypeItem(this.name, this.value);
}

class MapTypesPage extends StatefulWidget {
  const MapTypesPage({Key? key}) : super(key: key);

  @override
  State<MapTypesPage> createState() => _MapTypesPageState();
}

class _MapTypesPageState extends State<MapTypesPage> {
  var mapType = MapType.satellite;
  final types = {
    MapType.normal: '常规',
    MapType.satellite: '卫星',
    MapType.dark: '黑夜',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('地图类型切换'),
        actions: [
          CupertinoButton(
            onPressed: showOptions,
            child: Text(
              types[mapType]!,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1?.color,
              ),
            ),
          ),
        ],
      ),
      body: TencentMap(mapType: mapType),
    );
  }

  void showOptions() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(children: [
        for (final item in types.entries)
          SimpleDialogOption(
            onPressed: () {
              setState(() => mapType = item.key);
              Navigator.pop(context);
            },
            child: Row(children: [
              Icon(
                item.key == mapType
                    ? Icons.check_circle_outlined
                    : Icons.radio_button_unchecked,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(item.value),
            ]),
          ),
      ]),
    );
  }
}
