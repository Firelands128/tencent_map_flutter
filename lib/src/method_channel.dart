part of tencent_map;

/// Tencent map API
class TencentMapMethodChannel {
  static final TencentMapMethodChannel _instance = TencentMapMethodChannel();

  static TencentMapMethodChannel get instance => _instance;

  final MethodChannel _initializerChannel = const MethodChannel("plugins.flutter.dev/tencent_map_initializer");

  final Map<int, MethodChannel> _channels = <int, MethodChannel>{};

  /// Accesses the MethodChannel associated to the passed mapId.
  MethodChannel _channel(int mapId) {
    final MethodChannel? channel = _channels[mapId];
    if (channel == null) {
      throw UnknownMapIDError(mapId);
    }
    return channel;
  }

  Future<void> init(int mapId) async {
    MethodChannel? channel = _channels[mapId];
    if (channel == null) {
      channel = MethodChannel(
        "plugins.flutter.dev/tencent_map_$mapId",
        const StandardMethodCodec(_TencentMapApiCodec()),
      );
      channel.setMethodCallHandler((MethodCall call) => _handleMethodCall(call, mapId));
      _channels[mapId] = channel;
    }
  }

  // The controller we need to broadcast the different events coming from handleMethodCall.
  final StreamController<MapEvent<Object?>> _mapEventStreamController = StreamController<MapEvent<Object?>>.broadcast();

  // Returns a filtered view of the events in the _controller, by mapId.
  Stream<MapEvent<Object?>> _events(int mapId) =>
      _mapEventStreamController.stream.where((MapEvent<Object?> event) => event.mapId == mapId);

  Stream<ScaleViewChangedEvent> onScaleViewChanged({required int mapId}) {
    return _events(mapId).whereType<ScaleViewChangedEvent>();
  }

  Stream<MapPressEvent> onMapPress({required int mapId}) {
    return _events(mapId).whereType<MapPressEvent>();
  }

  Stream<MapLongPressEvent> onMapLongPress({required int mapId}) {
    return _events(mapId).whereType<MapLongPressEvent>();
  }

  Stream<PoiTapEvent> onPoiTap({required int mapId}) {
    return _events(mapId).whereType<PoiTapEvent>();
  }

  Stream<CameraMoveStartEvent> onCameraMoveStart({required int mapId}) {
    return _events(mapId).whereType<CameraMoveStartEvent>();
  }

  Stream<CameraMoveEvent> onCameraMove({required int mapId}) {
    return _events(mapId).whereType<CameraMoveEvent>();
  }

  Stream<CameraMoveEndEvent> onCameraMoveEnd({required int mapId}) {
    return _events(mapId).whereType<CameraMoveEndEvent>();
  }

  Stream<TapMarkerEvent> onTapMarker({required int mapId}) {
    return _events(mapId).whereType<TapMarkerEvent>();
  }

  Stream<MarkerDragStartEvent> onMarkerDragStart({required int mapId}) {
    return _events(mapId).whereType<MarkerDragStartEvent>();
  }

  Stream<MarkerDragEvent> onMarkerDrag({required int mapId}) {
    return _events(mapId).whereType<MarkerDragEvent>();
  }

  Stream<MarkerDragEndEvent> onMarkerDragEnd({required int mapId}) {
    return _events(mapId).whereType<MarkerDragEndEvent>();
  }

  Stream<LocationChangedEvent> onLocationChanged({required int mapId}) {
    return _events(mapId).whereType<LocationChangedEvent>();
  }

  Stream<UserLocationClickEvent> onUserLocationClick({required int mapId}) {
    return _events(mapId).whereType<UserLocationClickEvent>();
  }

  Future<dynamic> _handleMethodCall(MethodCall call, int mapId) async {
    switch (call.method) {
      case "onScaleViewChanged":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(ScaleViewChangedEvent(
          mapId,
          arguments["scale"] as double,
        ));
        break;
      case "onPress":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(MapPressEvent(
          mapId,
          arguments["position"] as Position,
        ));
        break;
      case "onLongPress":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(MapLongPressEvent(
          mapId,
          arguments["position"] as Position,
        ));
        break;
      case "onTapPoi":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(PoiTapEvent(
          mapId,
          arguments["poi"] as Poi,
        ));
        break;
      case "onCameraMoveStart":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(CameraMoveStartEvent(
          mapId,
          arguments["position"] as CameraPosition,
        ));
        break;
      case "onCameraMove":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(CameraMoveEvent(
          mapId,
          arguments["position"] as CameraPosition,
        ));
        break;
      case "onCameraMoveEnd":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(CameraMoveEndEvent(
          mapId,
          arguments["position"] as CameraPosition,
        ));
        break;
      case "onTapMarker":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(TapMarkerEvent(
          mapId,
          arguments["markerId"] as String,
        ));
        break;
      case "onMarkerDragStart":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(MarkerDragStartEvent(
          mapId,
          arguments["position"] as Position,
          arguments["markerId"] as String,
        ));
        break;
      case "onMarkerDrag":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(MarkerDragEvent(
          mapId,
          arguments["position"] as Position,
          arguments["markerId"] as String,
        ));
        break;
      case "onMarkerDragEnd":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(MarkerDragEndEvent(
          mapId,
          arguments["position"] as Position,
          arguments["markerId"] as String,
        ));
        break;
      case "onLocation":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(LocationChangedEvent(
          mapId,
          arguments["location"] as Location,
        ));
        break;
      case "onUserLocationClick":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        _mapEventStreamController.add(UserLocationClickEvent(
          mapId,
          arguments["position"] as Position,
        ));
        break;
      default:
        throw MissingPluginException();
    }
  }

  Map<String, Object?> _getArgumentDictionary(MethodCall call) {
    return (call.arguments as Map<Object?, Object?>).cast<String, Object?>();
  }

  /// 同意隐私协议，显示地图前必须调用
  Future<void> agreePrivacy(bool agree) async {
    return _initializerChannel.invokeMethod(
      "agreePrivacy",
      <String, dynamic>{
        "agree": agree,
      },
    );
  }

  /// 设置地图类型
  Future<void> setMapType(MapType type, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setMapType",
      <String, dynamic>{
        "type": type.index,
      },
    );
  }

  /// 设置个性化地图样式，在官网绑定个性化地图样式，输入样式编号
  Future<void> setMapStyle(int index, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setMapStyle",
      <String, dynamic>{
        "index": index,
      },
    );
  }

  /// 设置Logo大小
  Future<void> setLogoScale(double scale, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setLogoScale",
      <String, dynamic>{
        "scale": scale,
      },
    );
  }

  /// 设置LOGO的位置
  Future<void> setLogoPosition(UIControlPosition position, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setLogoPosition",
      <String, dynamic>{
        "position": position,
      },
    );
  }

  /// 设置比例尺的位置（iOS不支持改变位置锚点，仅支持改变位置偏移）
  Future<void> setScalePosition(UIControlPosition position, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setScalePosition",
      <String, dynamic>{
        "position": position,
      },
    );
  }

  /// 设置指南针的位置偏移
  Future<void> setCompassOffset(UIControlOffset offset, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setCompassOffset",
      <String, dynamic>{
        "offset": offset,
      },
    );
  }

  /// 设置是否显示指南针
  Future<void> setCompassEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setCompassEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置是否显示比例尺
  Future<void> setScaleEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setScaleEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置比例尺是否淡出
  Future<void> setScaleFadeEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setScaleFadeEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置是否使用旋转手势
  Future<void> setRotateGesturesEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setRotateGesturesEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置是否使用滚动手势
  Future<void> setScrollGesturesEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setScrollGesturesEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置是否使用缩放手势
  Future<void> setZoomGesturesEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setZoomGesturesEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置是否使用倾斜手势
  Future<void> setSkewGesturesEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setSkewGesturesEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置是否显示室内图（需要API key支持）
  Future<void> setIndoorViewEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setIndoorViewEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置是否显示室内图楼层控件
  Future<void> setIndoorPickerEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setIndoorPickerEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置是否显示路况
  Future<void> setTrafficEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setTrafficEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置是否显示建筑物
  Future<void> setBuildingsEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setBuildingsEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置是否显示3D建筑物
  Future<void> setBuildings3dEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setBuildings3dEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置是否开启定位
  Future<void> setMyLocationEnabled(bool enabled, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setMyLocationEnabled",
      <String, dynamic>{
        "enabled": enabled,
      },
    );
  }

  /// 设置定位模式
  Future<void> setUserLocationType(UserLocationType type, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setUserLocationType",
      <String, dynamic>{
        "type": type.index,
      },
    );
  }

  /// 获取当前定位信息
  Future<Location> getUserLocation({required int mapId}) async {
    final result = await _channel(mapId).invokeMethod<Location>("getUserLocation");
    if (result == null) throw "Failed to get user location";
    return result;
  }

  /// 移动地图视野
  Future<void> moveCamera(CameraPosition position, int duration, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "moveCamera",
      <String, dynamic>{
        "position": position,
        "duration": duration,
      },
    );
  }

  /// 移动地图视野到某个地图区域
  Future<void> moveCameraToRegion(Region region, EdgePadding padding, int duration, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "moveCameraToRegion",
      <String, dynamic>{
        "region": region,
        "padding": padding,
        "duration": duration,
      },
    );
  }

  /// 移动地图视野到包含一组坐标点的某个地图区域
  Future<void> moveCameraToRegionWithPosition(List<Position?> positions, EdgePadding padding, int duration,
      {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "moveCameraToRegionWithPosition",
      <String, dynamic>{
        "positions": positions,
        "padding": padding,
        "duration": duration,
      },
    );
  }

  /// 限制地图显示区域
  Future<void> setRestrictRegion(Region region, RestrictRegionMode mode, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "setRestrictRegion",
      <String, dynamic>{
        "region": region,
        "mode": mode.index,
      },
    );
  }

  /// 添加标记点
  Future<void> addMarker(Marker marker, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "addMarker",
      <String, dynamic>{
        "marker": marker,
      },
    );
  }

  /// 移除标记点
  Future<void> removeMarker(String id, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "removeMarker",
      <String, dynamic>{
        "id": id,
      },
    );
  }

  /// 更新标记点
  Future<void> updateMarker(String markerId, MarkerUpdateOptions options, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "updateMarker",
      <String, dynamic>{
        "markerId": markerId,
        "options": options,
      },
    );
  }

  /// 开始
  Future<void> start({required int mapId}) {
    return _channel(mapId).invokeMethod("start");
  }

  /// 暂停
  Future<void> pause({required int mapId}) {
    return _channel(mapId).invokeMethod("pause");
  }

  /// 恢复
  Future<void> resume({required int mapId}) {
    return _channel(mapId).invokeMethod("resume");
  }

  /// 停止
  Future<void> stop({required int mapId}) {
    return _channel(mapId).invokeMethod("stop");
  }

  /// 销毁
  Future<void> destroy({required int mapId}) {
    return _channel(mapId).invokeMethod("destroy");
  }
}

class _TencentMapApiCodec extends StandardMessageCodec {
  const _TencentMapApiCodec();

  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is Anchor) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is Bitmap) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is CameraPosition) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is EdgePadding) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is Location) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is Marker) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is MarkerUpdateOptions) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is Position) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else if (value is Region) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else if (value is UIControlOffset) {
      buffer.putUint8(137);
      writeValue(buffer, value.encode());
    } else if (value is UIControlPosition) {
      buffer.putUint8(138);
      writeValue(buffer, value.encode());
    } else if (value is Poi) {
      buffer.putUint8(139);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return Anchor.decode(readValue(buffer)!);
      case 129:
        return Bitmap.decode(readValue(buffer)!);
      case 130:
        return CameraPosition.decode(readValue(buffer)!);
      case 131:
        return EdgePadding.decode(readValue(buffer)!);
      case 132:
        return Location.decode(readValue(buffer)!);
      case 133:
        return Marker.decode(readValue(buffer)!);
      case 134:
        return MarkerUpdateOptions.decode(readValue(buffer)!);
      case 135:
        return Position.decode(readValue(buffer)!);
      case 136:
        return Region.decode(readValue(buffer)!);
      case 137:
        return UIControlOffset.decode(readValue(buffer)!);
      case 138:
        return UIControlPosition.decode(readValue(buffer)!);
      case 139:
        return Poi.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
