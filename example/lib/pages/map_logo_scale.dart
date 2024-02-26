import 'package:flutter/material.dart';
import 'package:tencent_map_flutter/tencent_map_flutter.dart';
import 'package:tencent_map_flutter_example/utils.dart';

/// 地图Logo大小设置页面
class MapLogoScalePage extends StatefulWidget {
  /// 地图Logo大小设置页面构造函数
  const MapLogoScalePage({super.key});

  /// 地图Logo大小设置页面标题
  static const title = '地图Logo大小';

  @override
  State<MapLogoScalePage> createState() => _MapLogoScalePageState();
}

class _MapLogoScalePageState extends State<MapLogoScalePage> {
  var scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(MapLogoScalePage.title)),
      body: TencentMap(
        androidTexture: true,
        mapType: context.isDark ? MapType.dark : MapType.normal,
        logoScale: scale,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text("Logo大小: ${scale.toStringAsFixed(2)}"),
              ),
              Slider(
                value: scale,
                min: 0.7,
                max: 1.3,
                onChanged: (double value) => setState(() => scale = value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
