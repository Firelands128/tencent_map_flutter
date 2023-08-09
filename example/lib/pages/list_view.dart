import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';
import '../utils.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('列表内嵌地图')),
      body: ListView(children: [
        const SizedBox(height: 400),
        SizedBox(
          height: 400,
          child: TencentMap(
            mapType: context.isDark ? MapType.dark : MapType.normal,
          ),
        ),
        const SizedBox(height: 400),
      ]),
    );
  }

  logger(String name) {
    // ignore: avoid_print
    return (dynamic data) => print('$name: ${data.encode()}');
  }
}
