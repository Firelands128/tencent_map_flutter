import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'marker.dart';
import 'pigeon.g.dart';

/// 腾讯地图
class TencentMap extends StatefulWidget {
  const TencentMap({
    Key? key,
    this.androidTexture = false,
    this.onMapCreated,
    this.compassEnabled = false,
    this.scaleControlsEnabled = true,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.tiltGesturesEnabled = true,
    this.trafficEnabled = false,
    this.indoorViewEnabled = false,
    this.buildingsEnabled = true,
    this.myLocationButtonEnabled = false,
    this.myLocationEnabled = false,
    this.myLocationStyle,
    this.mapType = MapType.normal,
    this.onTap,
    this.onTapPoi,
    this.onLongPress,
    this.onCameraMove,
    this.onCameraIdle,
    this.onTapMarker,
    this.onMarkerDragStart,
    this.onMarkerDrag,
    this.onMarkerDragEnd,
    this.onLocation,
  }) : super(key: key);

  /// android 是否使用 TextureMapView
  ///
  /// 默认的 SurfaceMapView 可能存在布局异常，使用 TextureMapView
  /// 可以解决，但性能较差
  final bool androidTexture;

  /// 地图类型
  final MapType mapType;

  /// 是否显示指南针
  final bool compassEnabled;

  /// 是否显示比例尺控件
  final bool scaleControlsEnabled;

  /// 是否允许旋转手势
  final bool rotateGesturesEnabled;

  /// 是否允许拖拽手势
  final bool scrollGesturesEnabled;

  /// 是否允许倾斜手势
  final bool tiltGesturesEnabled;

  /// 是否打开路况图层
  final bool trafficEnabled;

  /// 是否显示室内图
  ///
  /// 室内图只有在缩放级别 [17， 22] 范围才生效，但是在18级之上（包含18级）才会有楼层边条显示。
  final bool indoorViewEnabled;

  /// 是否显示 3D 建筑物
  final bool buildingsEnabled;

  /// 是否显示定位按钮
  final bool myLocationButtonEnabled;

  /// 是否显示当前定位
  final bool myLocationEnabled;

  /// 定位样式
  final MyLocationStyle? myLocationStyle;

  /// 地图创建完成事件回调函数
  ///
  /// 可以使用参数 [TencentMapController] 调用地图方法
  final void Function(TencentMapController)? onMapCreated;

  /// 地图空白区域单击事件回调函数
  final void Function(LatLng)? onTap;

  /// 地图兴趣点单击事件回调函数
  final void Function(MapPoi)? onTapPoi;

  /// 地图长按事件回调函数
  final void Function(LatLng)? onLongPress;

  /// 地图视野改变事件回调函数
  final void Function(CameraPosition)? onCameraMove;

  /// 地图视野结束改变事件回调函数
  final void Function(CameraPosition)? onCameraIdle;

  /// 地图标记点击事件回调函数
  final void Function(String markerId)? onTapMarker;

  /// 地图标记开始拖拽事件回调函数
  final void Function(String markerId, LatLng latLng)? onMarkerDragStart;

  /// 地图标记拖拽事件回调函数
  final void Function(String markerId, LatLng latLng)? onMarkerDrag;

  /// 地图标记拖拽结束事件回调函数
  final void Function(String markerId, LatLng latLng)? onMarkerDragEnd;

  /// 地图定位回调函数
  final void Function(Location)? onLocation;

  @override
  createState() => _TencentMapState();

  static final _sdkApi = TencentMapSdkApi();

  /// 初始化 SDK，显示地图前必须调用
  ///
  /// 请确保用户同意腾讯地图 SDK 隐私协议并设置 [agreePrivacy] = true
  static Future<void> init({String? iosApiKey, bool agreePrivacy = false}) {
    return _sdkApi.initSdk(iosApiKey, agreePrivacy);
  }
}

class _TencentMapState extends State<TencentMap> with WidgetsBindingObserver {
  static final _api = TencentMapApi();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _api.resume();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        _api.pause();
        break;
      case AppLifecycleState.detached:
        _api.destory();
        break;
    }
  }

  @override
  build(context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: 'tencent_map',
          creationParams: {'texture': widget.androidTexture},
          creationParamsCodec: const StandardMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: 'tencent_map',
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      default:
        return Text('$defaultTargetPlatform is not supported');
    }
  }

  @override
  didUpdateWidget(old) {
    super.didUpdateWidget(old);
    if (widget.mapType != old.mapType) {
      _api.setMapType(widget.mapType);
    }
    if (widget.compassEnabled != old.compassEnabled) {
      _api.setCompassEnabled(widget.compassEnabled);
    }
    if (widget.scaleControlsEnabled != old.scaleControlsEnabled) {
      _api.setScaleControlsEnabled(widget.scaleControlsEnabled);
    }
    if (widget.tiltGesturesEnabled != old.tiltGesturesEnabled) {
      _api.setTiltGesturesEnabled(widget.tiltGesturesEnabled);
    }
    if (widget.scrollGesturesEnabled != old.scrollGesturesEnabled) {
      _api.setScrollGesturesEnabled(widget.scrollGesturesEnabled);
    }
    if (widget.rotateGesturesEnabled != old.rotateGesturesEnabled) {
      _api.setRotateGesturesEnabled(widget.rotateGesturesEnabled);
    }
    if (widget.trafficEnabled != old.trafficEnabled) {
      _api.setTrafficEnabled(widget.trafficEnabled);
    }
    if (widget.indoorViewEnabled != old.indoorViewEnabled) {
      _api.setIndoorViewEnabled(widget.indoorViewEnabled);
    }
    if (widget.buildingsEnabled != old.buildingsEnabled) {
      _api.setBuildingsEnabled(widget.buildingsEnabled);
    }
    if (widget.myLocationButtonEnabled != old.myLocationButtonEnabled) {
      _api.setMyLocationButtonEnabled(widget.myLocationButtonEnabled);
    }
    if (widget.myLocationEnabled != old.myLocationEnabled) {
      _api.setMyLocationEnabled(widget.myLocationEnabled);
    }
    if (widget.myLocationStyle != old.myLocationStyle && widget.myLocationStyle != null) {
      _api.setMyLocationStyle(widget.myLocationStyle!);
    }
  }

  _onPlatformViewCreated(int id) {
    TencentMapHandler.setup(_TencentMapHandler(widget));
    didUpdateWidget(const TencentMap());
    widget.onMapCreated?.call(TencentMapController(_api));
  }
}

class _TencentMapHandler extends TencentMapHandler {
  TencentMap tencentMap;

  _TencentMapHandler(this.tencentMap);

  @override
  void onCameraIdle(CameraPosition cameraPosition) {
    tencentMap.onCameraIdle?.call(cameraPosition);
  }

  @override
  void onCameraMove(CameraPosition cameraPosition) {
    tencentMap.onCameraMove?.call(cameraPosition);
  }

  @override
  void onLongPress(LatLng latLng) {
    tencentMap.onLongPress?.call(latLng);
  }

  @override
  void onTap(LatLng latLng) {
    tencentMap.onTap?.call(latLng);
  }

  @override
  void onTapPoi(MapPoi mapPoi) {
    tencentMap.onTapPoi?.call(mapPoi);
  }

  @override
  void onTapMarker(String markerId) {
    tencentMap.onTapMarker?.call(markerId);
  }

  @override
  void onMarkerDragStart(String markerId, LatLng latLng) {
    tencentMap.onMarkerDragStart?.call(markerId, latLng);
  }

  @override
  void onMarkerDrag(String markerId, LatLng latLng) {
    tencentMap.onMarkerDrag?.call(markerId, latLng);
  }

  @override
  void onMarkerDragEnd(String markerId, LatLng latLng) {
    tencentMap.onMarkerDragEnd?.call(markerId, latLng);
  }

  @override
  void onLocation(Location location) {
    tencentMap.onLocation?.call(location);
  }
}

/// 地图控制器，提供地图控制接口
class TencentMapController {
  TencentMapController(this._api);

  final TencentMapApi _api;

  /// 移动视野
  void moveCamera(CameraPosition position, [Duration? duration]) {
    _api.moveCamera(position, duration?.inMilliseconds ?? 0);
  }

  /// 添加标记
  Future<Marker> addMarket(MarkerOptions options) async {
    return Marker(await _api.addMarker(options));
  }

  /// 销毁地图
  Future<void> destory() {
    return _api.destory();
  }

  /// 停止地图渲染
  Future<void> stop() {
    return _api.stop();
  }

  /// 暂停地图渲染
  Future<void> pause() {
    return _api.pause();
  }

  /// 恢复地图渲染
  Future<void> resume() {
    return _api.resume();
  }

  /// 设置当前定位
  Future<void> setMyLocation(Location location) {
    return _api.setMyLocation(location);
  }
}
