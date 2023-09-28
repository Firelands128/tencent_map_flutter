part of tencent_map;

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
  final void Function(Position)? onPress;

  /// 当地图上任意地点进行长按点击时会触发该回调，事件可能被上层覆盖物拦截（Android Only）
  final void Function(Position)? onLongPress;

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
  final void Function(String markerId, Position position)? onMarkerDragStart;

  /// 当拖动点标记时触发该回调（Android Only）
  final void Function(String markerId, Position position)? onMarkerDrag;

  /// 当拖动点标记完成时触发该回调（Android Only）
  final void Function(String markerId, Position position)? onMarkerDragEnd;

  /// 当前位置改变时触发该回调（Android Only）
  final void Function(Location)? onLocation;

  /// 当点击地图上的定位标会触发该回调
  final void Function(Position)? onUserLocationClick;

  @override
  createState() => TencentMapState();

  /// 初始化 SDK，显示地图前必须调用
  ///
  /// 请确保用户同意腾讯地图 SDK 隐私协议并设置 [agreePrivacy] = true
  static Future<void> init({bool agreePrivacy = false}) {
    return TencentMapMethodChannel.instance.agreePrivacy(agreePrivacy);
  }
}

class TencentMapState extends State<TencentMap> with WidgetsBindingObserver {
  static final defaultUIControlOffset = UIControlOffset(x: 0, y: 0);
  late final int mapId;

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
        TencentMapMethodChannel.instance.resume(mapId: mapId);
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        TencentMapMethodChannel.instance.pause(mapId: mapId);
        break;
      case AppLifecycleState.detached:
        TencentMapMethodChannel.instance.destroy(mapId: mapId);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: "tencent_map",
          creationParams: {"texture": widget.androidTexture},
          creationParamsCodec: const StandardMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: "tencent_map",
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      default:
        return Text("$defaultTargetPlatform is not supported");
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mapType != oldWidget.mapType) {
      TencentMapMethodChannel.instance.setMapType(widget.mapType, mapId: mapId);
    }
    if (widget.mapStyle != null && widget.mapStyle != oldWidget.mapStyle) {
      TencentMapMethodChannel.instance.setMapStyle(widget.mapStyle!, mapId: mapId);
    }
    if (widget.logoScale != oldWidget.logoScale) {
      TencentMapMethodChannel.instance.setLogoScale(widget.logoScale, mapId: mapId);
    }
    if (widget.logoPosition != oldWidget.logoPosition) {
      TencentMapMethodChannel.instance.setLogoPosition(
          widget.logoPosition ??
              UIControlPosition(
                anchor: UIControlAnchor.bottomRight,
                offset: defaultUIControlOffset,
              ),
          mapId: mapId);
    }
    if (widget.scalePosition != oldWidget.scalePosition) {
      TencentMapMethodChannel.instance.setScalePosition(
          widget.scalePosition ??
              UIControlPosition(
                anchor: UIControlAnchor.bottomLeft,
                offset: defaultUIControlOffset,
              ),
          mapId: mapId);
    }
    if (widget.compassOffset != null && widget.compassOffset != oldWidget.compassOffset) {
      TencentMapMethodChannel.instance.setCompassOffset(
        widget.compassOffset!,
        mapId: mapId,
      );
    }
    if (widget.compassEnabled != oldWidget.compassEnabled) {
      TencentMapMethodChannel.instance.setCompassEnabled(
        widget.compassEnabled,
        mapId: mapId,
      );
    }
    if (widget.scaleEnabled != oldWidget.scaleEnabled) {
      TencentMapMethodChannel.instance.setScaleEnabled(
        widget.scaleEnabled,
        mapId: mapId,
      );
    }
    if (widget.scaleFadeEnabled != oldWidget.scaleFadeEnabled) {
      TencentMapMethodChannel.instance.setScaleFadeEnabled(
        widget.scaleFadeEnabled,
        mapId: mapId,
      );
    }
    if (widget.skewGesturesEnabled != oldWidget.skewGesturesEnabled) {
      TencentMapMethodChannel.instance.setSkewGesturesEnabled(
        widget.skewGesturesEnabled,
        mapId: mapId,
      );
    }
    if (widget.scrollGesturesEnabled != oldWidget.scrollGesturesEnabled) {
      TencentMapMethodChannel.instance.setScrollGesturesEnabled(
        widget.scrollGesturesEnabled,
        mapId: mapId,
      );
    }
    if (widget.zoomGesturesEnabled != oldWidget.zoomGesturesEnabled) {
      TencentMapMethodChannel.instance.setZoomGesturesEnabled(
        widget.zoomGesturesEnabled,
        mapId: mapId,
      );
    }
    if (widget.rotateGesturesEnabled != oldWidget.rotateGesturesEnabled) {
      TencentMapMethodChannel.instance.setRotateGesturesEnabled(
        widget.rotateGesturesEnabled,
        mapId: mapId,
      );
    }
    if (widget.trafficEnabled != oldWidget.trafficEnabled) {
      TencentMapMethodChannel.instance.setTrafficEnabled(
        widget.trafficEnabled,
        mapId: mapId,
      );
    }
    if (widget.indoorViewEnabled != oldWidget.indoorViewEnabled) {
      TencentMapMethodChannel.instance.setIndoorViewEnabled(
        widget.indoorViewEnabled,
        mapId: mapId,
      );
    }
    if (widget.indoorPickerEnabled != oldWidget.indoorPickerEnabled) {
      TencentMapMethodChannel.instance.setIndoorPickerEnabled(
        widget.indoorPickerEnabled,
        mapId: mapId,
      );
    }
    if (widget.buildingsEnabled != oldWidget.buildingsEnabled) {
      TencentMapMethodChannel.instance.setBuildingsEnabled(
        widget.buildingsEnabled,
        mapId: mapId,
      );
    }
    if (widget.buildings3dEnabled != oldWidget.buildings3dEnabled) {
      TencentMapMethodChannel.instance.setBuildings3dEnabled(
        widget.buildings3dEnabled,
        mapId: mapId,
      );
    }
    if (widget.myLocationEnabled != oldWidget.myLocationEnabled) {
      TencentMapMethodChannel.instance.setMyLocationEnabled(
        widget.myLocationEnabled,
        mapId: mapId,
      );
    }
    if (widget.userLocationType != oldWidget.userLocationType) {
      TencentMapMethodChannel.instance.setUserLocationType(
        widget.userLocationType,
        mapId: mapId,
      );
    }
  }

  _onPlatformViewCreated(int id) async {
    mapId = id;
    final TencentMapController controller = await TencentMapController.init(id, this);
    widget.onMapCreated?.call(controller);
    initMap();
  }

  initMap() {
    TencentMapMethodChannel.instance.setMapType(widget.mapType, mapId: mapId);
    if (widget.mapStyle != null) TencentMapMethodChannel.instance.setMapStyle(widget.mapStyle!, mapId: mapId);
    TencentMapMethodChannel.instance.setLogoScale(widget.logoScale, mapId: mapId);
    TencentMapMethodChannel.instance.setLogoPosition(
      widget.logoPosition ??
          UIControlPosition(
            anchor: UIControlAnchor.bottomRight,
            offset: defaultUIControlOffset,
          ),
      mapId: mapId,
    );
    TencentMapMethodChannel.instance.setScalePosition(
      widget.scalePosition ??
          UIControlPosition(
            anchor: UIControlAnchor.bottomLeft,
            offset: defaultUIControlOffset,
          ),
      mapId: mapId,
    );
    TencentMapMethodChannel.instance.setCompassOffset(widget.compassOffset ?? defaultUIControlOffset, mapId: mapId);
    TencentMapMethodChannel.instance.setCompassEnabled(widget.compassEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setScaleEnabled(widget.scaleEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setScaleFadeEnabled(widget.scaleFadeEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setSkewGesturesEnabled(widget.skewGesturesEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setScrollGesturesEnabled(widget.scrollGesturesEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setZoomGesturesEnabled(widget.zoomGesturesEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setRotateGesturesEnabled(widget.rotateGesturesEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setTrafficEnabled(widget.trafficEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setIndoorViewEnabled(widget.indoorViewEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setIndoorPickerEnabled(widget.indoorPickerEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setBuildingsEnabled(widget.buildingsEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setBuildings3dEnabled(widget.buildings3dEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setMyLocationEnabled(widget.myLocationEnabled, mapId: mapId);
    TencentMapMethodChannel.instance.setUserLocationType(widget.userLocationType, mapId: mapId);
  }
}
