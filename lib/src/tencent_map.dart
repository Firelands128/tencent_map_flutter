part of '../tencent_map_flutter.dart';

/// 腾讯地图
class TencentMap extends StatefulWidget {
  const TencentMap({
    Key? key,
    this.androidTexture = false,
    this.mapType = MapType.normal,
    this.mapStyle,
    this.logoScale = 1.0,
    this.logoPosition,
    this.scalePosition,
    this.compassOffset,
    this.compassEnabled = true,
    this.scaleEnabled = true,
    this.scaleFadeEnabled = true,
    this.rotateGesturesEnabled = true,
    this.scrollGesturesEnabled = true,
    this.zoomGesturesEnabled = true,
    this.skewGesturesEnabled = true,
    this.trafficEnabled = false,
    this.indoorViewEnabled = false,
    this.indoorPickerEnabled = false,
    this.buildingsEnabled = true,
    this.buildings3dEnabled = false,
    this.myLocationEnabled = false,
    this.userLocationType = UserLocationType.trackingLocationRotate,
    this.onMapCreated,
    this.onScaleViewChanged,
    this.onPress,
    this.onLongPress,
    this.onTapPoi,
    this.onCameraMoveStart,
    this.onCameraMove,
    this.onCameraMoveEnd,
    this.onTapMarker,
    this.onMarkerDragStart,
    this.onMarkerDrag,
    this.onMarkerDragEnd,
    this.onLocation,
    this.onUserLocationClick,
  }) : super(key: key);

  /// android 是否使用 TextureMapView
  ///
  /// 默认的 SurfaceMapView 可能存在布局异常，使用 TextureMapView
  /// 可以解决，但性能较差
  final bool androidTexture;

  /// 地图类型
  final MapType mapType;

  /// 地图样式编号
  final int? mapStyle;

  /// Logo大小
  final double logoScale;

  /// Logo控件位置
  final UIControlPosition? logoPosition;

  /// 比例尺控件位置
  final UIControlPosition? scalePosition;

  /// 指南针控件位置偏移
  final UIControlOffset? compassOffset;

  /// 是否显示指南针
  final bool compassEnabled;

  /// 是否显示比例尺控件
  final bool scaleEnabled;

  /// 是否淡出比例尺
  final bool scaleFadeEnabled;

  /// 是否允许旋转手势
  final bool rotateGesturesEnabled;

  /// 是否允许拖拽手势
  final bool scrollGesturesEnabled;

  /// 是否允许缩放手势
  final bool zoomGesturesEnabled;

  /// 是否允许倾斜手势
  final bool skewGesturesEnabled;

  /// 是否打开路况图层
  final bool trafficEnabled;

  /// 是否显示室内图
  ///
  /// 室内图只有在缩放级别 [17， 22] 范围才生效，但是在18级之上（包含18级）才会有楼层边条显示。
  final bool indoorViewEnabled;

  /// 是否显示室内图楼层控件
  final bool indoorPickerEnabled;

  /// 是否显示建筑物
  final bool buildingsEnabled;

  /// 是否显示3D建筑物
  final bool buildings3dEnabled;

  /// 是否显示当前定位
  final bool myLocationEnabled;

  /// 定位样式
  final UserLocationType userLocationType;

  /// 地图创建完成事件回调函数
  ///
  /// 可以使用参数 [TencentMapController] 调用地图方法
  final void Function(TencentMapController)? onMapCreated;

  /// 当地图比例尺变化时触发该回调，方法会传入单位长度信息，单位为米
  final void Function(double)? onScaleViewChanged;

  /// 当点击地图上任意地点时会触发该回调，方法会传入点击的坐标点，事件可能被上层覆盖物拦截
  final void Function(LatLng)? onPress;

  /// 当地图上任意地点进行长按点击时会触发该回调，事件可能被上层覆盖物拦截（Android Only）
  final void Function(LatLng)? onLongPress;

  /// 当点击地图上任意的POI时调用，方法会传入点击的POI信息
  final void Function(Poi)? onTapPoi;

  /// 当地图视野即将改变时会触发该回调（iOS Only）
  final void Function(CameraPosition)? onCameraMoveStart;

  /// 当地图视野发生变化时触发该回调。视野持续变化时本回调可能会被频繁多次调用, 请不要做耗时或复杂的事情
  final void Function(CameraPosition)? onCameraMove;

  /// 当地图视野变化完成时触发该回调，需注意当前地图状态有可能并不是稳定状态
  final void Function(CameraPosition)? onCameraMoveEnd;

  /// 当点击点标记时触发该回调（Android Only）
  final void Function(String markerId)? onTapMarker;

  /// 当开始拖动点标记时触发该回调（Android Only）
  final void Function(String markerId, LatLng position)? onMarkerDragStart;

  /// 当拖动点标记时触发该回调（Android Only）
  final void Function(String markerId, LatLng position)? onMarkerDrag;

  /// 当拖动点标记完成时触发该回调（Android Only）
  final void Function(String markerId, LatLng position)? onMarkerDragEnd;

  /// 当前位置改变时触发该回调（Android Only）
  final void Function(Location)? onLocation;

  /// 当点击地图上的定位标会触发该回调
  final void Function(LatLng)? onUserLocationClick;

  @override
  createState() => TencentMapState();

  /// 初始化 SDK，显示地图前必须调用
  ///
  /// 请确保用户同意腾讯地图 SDK 隐私协议并设置 [agreePrivacy] = true
  static Future<void> init({bool agreePrivacy = false}) {
    return TencentMapMethodChannel.instance.agreePrivacy(agreePrivacy);
  }
}

class TencentMapState extends State<TencentMap> {
  static final defaultUIControlOffset = UIControlOffset(x: 0, y: 0);
  late final int mapId;

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: "tencent_map_flutter",
          creationParams: {"texture": widget.androidTexture},
          creationParamsCodec: const StandardMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: "tencent_map_flutter",
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      default:
        return Text("$defaultTargetPlatform is not supported");
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    MapConfig config = MapConfig();
    if (widget.mapType != oldWidget.mapType) {
      config.mapType = widget.mapType;
    }
    if (widget.mapStyle != null && widget.mapStyle != oldWidget.mapStyle) {
      config.mapStyle = widget.mapStyle;
    }
    if (widget.logoScale != oldWidget.logoScale) {
      config.logoScale = widget.logoScale;
    }
    if (widget.logoPosition != oldWidget.logoPosition) {
      config.logoPosition = widget.logoPosition ??
          UIControlPosition(
            anchor: UIControlAnchor.bottomRight,
            offset: defaultUIControlOffset,
          );
    }
    if (widget.scalePosition != oldWidget.scalePosition) {
      config.scalePosition = widget.scalePosition ??
          UIControlPosition(
            anchor: UIControlAnchor.bottomLeft,
            offset: defaultUIControlOffset,
          );
    }
    if (widget.compassOffset != null &&
        widget.compassOffset != oldWidget.compassOffset) {
      config.compassOffset = widget.compassOffset;
    }
    if (widget.compassEnabled != oldWidget.compassEnabled) {
      config.compassEnabled = widget.compassEnabled;
    }
    if (widget.scaleEnabled != oldWidget.scaleEnabled) {
      config.scaleEnabled = widget.scaleEnabled;
    }
    if (widget.scaleFadeEnabled != oldWidget.scaleFadeEnabled) {
      config.scaleFadeEnabled = widget.scaleFadeEnabled;
    }
    if (widget.skewGesturesEnabled != oldWidget.skewGesturesEnabled) {
      config.skewGesturesEnabled = widget.skewGesturesEnabled;
    }
    if (widget.scrollGesturesEnabled != oldWidget.scrollGesturesEnabled) {
      config.scrollGesturesEnabled = widget.scrollGesturesEnabled;
    }
    if (widget.zoomGesturesEnabled != oldWidget.zoomGesturesEnabled) {
      config.zoomGesturesEnabled = widget.zoomGesturesEnabled;
    }
    if (widget.rotateGesturesEnabled != oldWidget.rotateGesturesEnabled) {
      config.rotateGesturesEnabled = widget.rotateGesturesEnabled;
    }
    if (widget.trafficEnabled != oldWidget.trafficEnabled) {
      config.trafficEnabled = widget.trafficEnabled;
    }
    if (widget.indoorViewEnabled != oldWidget.indoorViewEnabled) {
      config.indoorViewEnabled = widget.indoorViewEnabled;
    }
    if (widget.indoorPickerEnabled != oldWidget.indoorPickerEnabled) {
      config.indoorPickerEnabled = widget.indoorPickerEnabled;
    }
    if (widget.buildingsEnabled != oldWidget.buildingsEnabled) {
      config.buildingsEnabled = widget.buildingsEnabled;
    }
    if (widget.buildings3dEnabled != oldWidget.buildings3dEnabled) {
      config.buildings3dEnabled = widget.buildings3dEnabled;
    }
    if (widget.myLocationEnabled != oldWidget.myLocationEnabled) {
      config.myLocationEnabled = widget.myLocationEnabled;
    }
    if (widget.userLocationType != oldWidget.userLocationType) {
      config.userLocationType = widget.userLocationType;
    }
    TencentMapMethodChannel.instance.updateMapConfig(config, mapId: mapId);
  }

  _onPlatformViewCreated(int id) {
    mapId = id;
    final TencentMapController controller = TencentMapController.init(id, this);
    _initMap();
    widget.onMapCreated?.call(controller);
  }

  _initMap() {
    MapConfig config = MapConfig(
      mapType: widget.mapType,
      mapStyle: widget.mapStyle,
      logoScale: widget.logoScale,
      logoPosition: widget.logoPosition,
      scalePosition: widget.scalePosition,
      compassOffset: widget.compassOffset,
      compassEnabled: widget.compassEnabled,
      scaleEnabled: widget.scaleEnabled,
      scaleFadeEnabled: widget.scaleFadeEnabled,
      skewGesturesEnabled: widget.skewGesturesEnabled,
      scrollGesturesEnabled: widget.scrollGesturesEnabled,
      rotateGesturesEnabled: widget.rotateGesturesEnabled,
      zoomGesturesEnabled: widget.zoomGesturesEnabled,
      trafficEnabled: widget.trafficEnabled,
      indoorViewEnabled: widget.indoorViewEnabled,
      indoorPickerEnabled: widget.indoorPickerEnabled,
      buildingsEnabled: widget.buildingsEnabled,
      buildings3dEnabled: widget.buildings3dEnabled,
      myLocationEnabled: widget.myLocationEnabled,
      userLocationType: widget.userLocationType,
    );
    TencentMapMethodChannel.instance.updateMapConfig(config, mapId: mapId);
  }
}
