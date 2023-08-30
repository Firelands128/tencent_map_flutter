import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';
import 'package:tencent_map_example/utils.dart';

/// Logo大小设置页面
class LogoScalePage extends StatefulWidget {
  /// Logo大小设置页面构造函数
  const LogoScalePage({super.key});

  /// Logo大小设置页面标题
  static const title = 'Logo大小设置';

  @override
  State<LogoScalePage> createState() => _LogoScalePageState();
}

class _LogoScalePageState extends State<LogoScalePage> {
  var scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(LogoScalePage.title)),
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
