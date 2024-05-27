import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:tencent_map_flutter/tencent_map_flutter.dart';

import '../utils.dart';

/// 添加、移除标记点页面
class AddRemoveMarkerPage extends StatefulWidget {
  /// 添加、移除标记点页面构造函数
  const AddRemoveMarkerPage({Key? key}) : super(key: key);

  /// 添加、移除标记点页面标题
  static const title = '动态添加、移除标记';

  @override
  State<AddRemoveMarkerPage> createState() => _AddRemoveMarkerPageState();
}

class _AddRemoveMarkerPageState extends State<AddRemoveMarkerPage> {
  late TencentMapController controller;
  final markers = <String, Marker>{};
  int _markerIdCounter = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.snackBar('点击地图添加标记，点击标记删除');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AddRemoveMarkerPage.title)),
      body: TencentMap(
        mapType: context.isDark ? MapType.dark : MapType.normal,
        onMapCreated: (controller) => this.controller = controller,
        onPress: (position) => onTap(position),
        onLongPress: (position) => onTap(position),
        onTapPoi: (poi) => onTap(poi.position),
        onTapMarker: (markerId) => onTapMarker(markerId),
        onMarkerDragEnd: (markerId, position) =>
            context.alert('${position.latitude}, ${position.longitude}'),
      ),
    );
  }

  void onTap(LatLng position) async {
    final String markerId = 'marker_id_${_markerIdCounter++}';
    final marker = Marker(
      id: markerId,
      position: position,
      icon: Bitmap(asset: 'images/marker.png'),
      anchor: Anchor(x: 0.5, y: 1),
      draggable: true,
    );
    markers[markerId] = marker;
    controller.addMarker(marker);
  }

  void onTapMarker(String markerId) {
    controller.removeMarker(markerId);
    markers.remove(markerId);
  }
}
