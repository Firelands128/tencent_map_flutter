part of '../tencent_map_flutter.dart';

/// Tencent map API
class TencentMapMethodChannel {
  static TencentMapMethodChannel instance = TencentMapMethodChannel();

  final MethodChannel _initializerChannel = const MethodChannel("plugins.flutter.dev/tencent_map_flutter_initializer");

  final Map<int, MethodChannel> _channels = <int, MethodChannel>{};

  /// Accesses the MethodChannel associated to the passed mapId.
  MethodChannel _channel(int mapId) {
    final MethodChannel? channel = _channels[mapId];
    if (channel == null) {
      throw UnknownMapIDError(mapId);
    }
    return channel;
  }

  void init(int mapId) {
    MethodChannel? channel = _channels[mapId];
    if (channel == null) {
      channel = MethodChannel(
        "plugins.flutter.dev/tencent_map_flutter_$mapId",
        const StandardMethodCodec(_TencentMapApiCodec()),
      );
      channel.setMethodCallHandler((MethodCall call) => _handleMethodCall(call, mapId));
      _channels[mapId] = channel;
    }
  }

  // The controller we need to broadcast the different events coming from handleMethodCall.
  final StreamController<MapEvent<Object?>> mapEventStreamController = StreamController<MapEvent<Object?>>.broadcast();

  // Returns a filtered view of the events in the _controller, by mapId.
  Stream<MapEvent<Object?>> _events(int mapId) =>
      mapEventStreamController.stream.where((MapEvent<Object?> event) => event.mapId == mapId);

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
        mapEventStreamController.add(ScaleViewChangedEvent(
          mapId,
          arguments["scale"] as double,
        ));
        break;
      case "onPress":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        mapEventStreamController.add(MapPressEvent(
          mapId,
          arguments["position"] as Position,
        ));
        break;
      case "onLongPress":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        mapEventStreamController.add(MapLongPressEvent(
          mapId,
          arguments["position"] as Position,
        ));
        break;
      case "onTapPoi":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        mapEventStreamController.add(PoiTapEvent(
          mapId,
          arguments["poi"] as Poi,
        ));
        break;
      case "onCameraMoveStart":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        mapEventStreamController.add(CameraMoveStartEvent(
          mapId,
          arguments["position"] as CameraPosition,
        ));
        break;
      case "onCameraMove":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        mapEventStreamController.add(CameraMoveEvent(
          mapId,
          arguments["position"] as CameraPosition,
        ));
        break;
      case "onCameraMoveEnd":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        mapEventStreamController.add(CameraMoveEndEvent(
          mapId,
          arguments["position"] as CameraPosition,
        ));
        break;
      case "onTapMarker":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        mapEventStreamController.add(TapMarkerEvent(
          mapId,
          arguments["markerId"] as String,
        ));
        break;
      case "onMarkerDragStart":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        mapEventStreamController.add(MarkerDragStartEvent(
          mapId,
          arguments["position"] as Position,
          arguments["markerId"] as String,
        ));
        break;
      case "onMarkerDrag":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        mapEventStreamController.add(MarkerDragEvent(
          mapId,
          arguments["position"] as Position,
          arguments["markerId"] as String,
        ));
        break;
      case "onMarkerDragEnd":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        mapEventStreamController.add(MarkerDragEndEvent(
          mapId,
          arguments["position"] as Position,
          arguments["markerId"] as String,
        ));
        break;
      case "onLocation":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        mapEventStreamController.add(LocationChangedEvent(
          mapId,
          arguments["location"] as Location,
        ));
        break;
      case "onUserLocationClick":
        final Map<String, Object?> arguments = _getArgumentDictionary(call);
        mapEventStreamController.add(UserLocationClickEvent(
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
  Future<void> agreePrivacy(bool agree) {
    return _initializerChannel.invokeMethod(
      "agreePrivacy",
      <String, dynamic>{
        "agree": agree,
      },
    );
  }

  /// 设置地图属性
  Future<void> updateMapConfig(MapConfig config, {required int mapId}) {
    return _channel(mapId).invokeMethod(
      "updateMapConfig",
      <String, dynamic>{
        "config": config,
      },
    );
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

  Future<void> removeRestrictRegion({required int mapId}) {
    return _channel(mapId).invokeMethod("removeRestrictRegion");
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

  /// 获取当前定位信息
  Future<Location> getUserLocation({required int mapId}) async {
    final result = await _channel(mapId).invokeMethod<Location>("getUserLocation");
    if (result == null) throw "Failed to get user location";
    return result;
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
    if (value is MapType) {
      buffer.putUint8(128);
      writeValue(buffer, value.index);
    } else if (value is RestrictRegionMode) {
      buffer.putUint8(129);
      writeValue(buffer, value.index);
    } else if (value is UIControlAnchor) {
      buffer.putUint8(130);
      writeValue(buffer, value.index);
    } else if (value is UserLocationType) {
      buffer.putUint8(131);
      writeValue(buffer, value.index);
    } else if (value is Anchor) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is Bitmap) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is CameraPosition) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is EdgePadding) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else if (value is Location) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else if (value is MapConfig) {
      buffer.putUint8(137);
      writeValue(buffer, value.encode());
    } else if (value is Marker) {
      buffer.putUint8(138);
      writeValue(buffer, value.encode());
    } else if (value is MarkerUpdateOptions) {
      buffer.putUint8(139);
      writeValue(buffer, value.encode());
    } else if (value is Poi) {
      buffer.putUint8(140);
      writeValue(buffer, value.encode());
    } else if (value is Position) {
      buffer.putUint8(141);
      writeValue(buffer, value.encode());
    } else if (value is Region) {
      buffer.putUint8(142);
      writeValue(buffer, value.encode());
    } else if (value is UIControlOffset) {
      buffer.putUint8(143);
      writeValue(buffer, value.encode());
    } else if (value is UIControlPosition) {
      buffer.putUint8(144);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return MapType.values.elementAt(readValue(buffer) as int);
      case 129:
        return RestrictRegionMode.values.elementAt(readValue(buffer) as int);
      case 130:
        return UIControlAnchor.values.elementAt(readValue(buffer) as int);
      case 131:
        return UserLocationType.values.elementAt(readValue(buffer) as int);
      case 132:
        return Anchor.decode(readValue(buffer)!);
      case 133:
        return Bitmap.decode(readValue(buffer)!);
      case 134:
        return CameraPosition.decode(readValue(buffer)!);
      case 135:
        return EdgePadding.decode(readValue(buffer)!);
      case 136:
        return Location.decode(readValue(buffer)!);
      case 137:
        return MapConfig.decode(readValue(buffer)!);
      case 138:
        return Marker.decode(readValue(buffer)!);
      case 139:
        return MarkerUpdateOptions.decode(readValue(buffer)!);
      case 140:
        return Poi.decode(readValue(buffer)!);
      case 141:
        return Position.decode(readValue(buffer)!);
      case 142:
        return Region.decode(readValue(buffer)!);
      case 143:
        return UIControlOffset.decode(readValue(buffer)!);
      case 144:
        return UIControlPosition.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
