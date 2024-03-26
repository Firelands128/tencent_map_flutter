import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tencent_map_flutter/tencent_map_flutter.dart';
import 'package:tencent_map_flutter_example/utils.dart';

/// 地图控件位置设置页面
class MapControlsPositionPage extends StatefulWidget {
  /// 地图控件位置设置页面构造函数
  const MapControlsPositionPage({super.key});

  /// 地图控件位置设置页面标题
  static const title = '地图控件位置';

  @override
  State<MapControlsPositionPage> createState() =>
      _MapControlsPositionPageState();
}

class _MapControlsPositionPageState extends State<MapControlsPositionPage> {
  static const logo = "Logo";
  static const scale = "比例尺";
  static const compass = "指南针";
  final anchorLabels = {
    UIControlAnchor.bottomLeft: '左下角',
    UIControlAnchor.bottomRight: '右下角',
    UIControlAnchor.topLeft: '左上角',
    UIControlAnchor.topRight: '右上角',
  };
  UIControlPosition logoPosition = UIControlPosition(
    anchor: UIControlAnchor.bottomRight,
    offset: UIControlOffset(x: 0, y: 0),
  );
  UIControlPosition scalePosition = UIControlPosition(
    anchor: UIControlAnchor.bottomLeft,
    offset: UIControlOffset(x: 0, y: 0),
  );
  UIControlOffset compassOffset = UIControlOffset(x: 0, y: 0);

  void showOptions({
    required UIControlAnchor anchor,
    required ValueChanged<UIControlAnchor> onChanged,
  }) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          for (final item in anchorLabels.entries)
            SimpleDialogOption(
              onPressed: () {
                onChanged(item.key);
                Navigator.pop(context);
              },
              child: Row(children: [
                Icon(
                  item.key == anchor
                      ? Icons.check_circle_outlined
                      : Icons.radio_button_unchecked,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(item.value),
              ]),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(MapControlsPositionPage.title)),
      body: Column(
        children: [
          Expanded(
            child: TencentMap(
              androidTexture: true,
              mapType: context.isDark ? MapType.dark : MapType.normal,
              scaleEnabled: true,
              scaleFadeEnabled: false,
              compassEnabled: true,
              logoPosition: logoPosition,
              scalePosition: scalePosition,
              compassOffset: compassOffset,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () => showOptions(
                          anchor: logoPosition.anchor,
                          onChanged: (anchor) => setState(() => logoPosition =
                              logoPosition.copyWith(anchor: anchor)),
                        ),
                        child: Text(
                          "$logo - ${anchorLabels[logoPosition.anchor]}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _OffsetTextField(
                            label: "X",
                            offset: logoPosition.offset,
                            onChanged: (value) => setState(() {
                              logoPosition = logoPosition.copyWith(
                                offset: UIControlOffset(
                                  x: value,
                                  y: logoPosition.offset.y,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(width: 10),
                          _OffsetTextField(
                            label: "Y",
                            offset: logoPosition.offset,
                            onChanged: (value) => setState(() {
                              logoPosition = logoPosition.copyWith(
                                offset: UIControlOffset(
                                  x: logoPosition.offset.x,
                                  y: value,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Platform.isAndroid
                          ? Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () => showOptions(
                                  anchor: scalePosition.anchor,
                                  onChanged: (anchor) => setState(
                                    () => scalePosition =
                                        scalePosition.copyWith(anchor: anchor),
                                  ),
                                ),
                                child: Text(
                                  "$scale - ${anchorLabels[logoPosition.anchor]}",
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                scale,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _OffsetTextField(
                            label: "X",
                            offset: scalePosition.offset,
                            onChanged: (value) => setState(() {
                              scalePosition = scalePosition.copyWith(
                                offset: UIControlOffset(
                                  x: value,
                                  y: scalePosition.offset.y,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(width: 10),
                          _OffsetTextField(
                            label: "Y",
                            offset: scalePosition.offset,
                            onChanged: (value) => setState(() {
                              scalePosition = scalePosition.copyWith(
                                offset: UIControlOffset(
                                  x: scalePosition.offset.x,
                                  y: value,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          compass,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _OffsetTextField(
                            label: "X",
                            offset: compassOffset,
                            onChanged: (value) => setState(() {
                              compassOffset = UIControlOffset(
                                x: value,
                                y: compassOffset.y,
                              );
                            }),
                          ),
                          const SizedBox(width: 10),
                          _OffsetTextField(
                            label: "Y",
                            offset: compassOffset,
                            onChanged: (value) => setState(() {
                              compassOffset = UIControlOffset(
                                x: compassOffset.x,
                                y: value,
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OffsetTextField extends StatelessWidget {
  const _OffsetTextField({
    required this.label,
    required this.offset,
    required this.onChanged,
  });

  final String label;
  final UIControlOffset offset;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        SizedBox(
          width: 50,
          child: TextFormField(
            initialValue: offset.x.toString(),
            onChanged: (value) {
              onChanged(value.isNotEmpty ? double.parse(value) : 0);
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(5),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
