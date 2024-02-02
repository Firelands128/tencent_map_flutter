part of tencent_map;

/// Controller for a single TencentMap instance running on the host platform.
class TencentMapController {
  TencentMapController._(
    this._tencentMapState, {
    required this.mapId,
  }) {
    _connectStreams(mapId);
  }

  /// The mapId for this controller
  final int mapId;

  /// The map state for a single TencentMap instance
  final TencentMapState _tencentMapState;

  /// Initialize control of a [TencentMap] with [id].
  ///
  /// Mainly for internal use when instantiating a [TencentMapController] passed in [TencentMap.onMapCreated] callback.
  static TencentMapController init(
    int id,
    TencentMapState tencentMapState,
  ) {
    TencentMapMethodChannel.instance.init(id);
    return TencentMapController._(
      tencentMapState,
      mapId: id,
    );
  }

  void _connectStreams(int mapId) {
    if (_tencentMapState.widget.onScaleViewChanged != null) {
      TencentMapMethodChannel.instance
          .onScaleViewChanged(mapId: mapId)
          .listen((ScaleViewChangedEvent e) => _tencentMapState.widget.onScaleViewChanged!(e.value));
    }
    if (_tencentMapState.widget.onPress != null) {
      TencentMapMethodChannel.instance
          .onMapPress(mapId: mapId)
          .listen((MapPressEvent e) => _tencentMapState.widget.onPress!(e.position));
    }
    if (_tencentMapState.widget.onLongPress != null) {
      TencentMapMethodChannel.instance
          .onMapLongPress(mapId: mapId)
          .listen((MapLongPressEvent e) => _tencentMapState.widget.onLongPress!(e.position));
    }
    if (_tencentMapState.widget.onTapPoi != null) {
      TencentMapMethodChannel.instance
          .onPoiTap(mapId: mapId)
          .listen((PoiTapEvent e) => _tencentMapState.widget.onTapPoi!(e.value));
    }
    if (_tencentMapState.widget.onCameraMoveStart != null) {
      TencentMapMethodChannel.instance
          .onCameraMoveStart(mapId: mapId)
          .listen((CameraMoveStartEvent e) => _tencentMapState.widget.onCameraMoveStart!(e.value));
    }
    if (_tencentMapState.widget.onCameraMove != null) {
      TencentMapMethodChannel.instance
          .onCameraMove(mapId: mapId)
          .listen((CameraMoveEvent e) => _tencentMapState.widget.onCameraMove!(e.value));
    }
    if (_tencentMapState.widget.onCameraMoveEnd != null) {
      TencentMapMethodChannel.instance
          .onCameraMoveEnd(mapId: mapId)
          .listen((CameraMoveEndEvent e) => _tencentMapState.widget.onCameraMoveEnd!(e.value));
    }
    if (_tencentMapState.widget.onTapMarker != null) {
      TencentMapMethodChannel.instance
          .onTapMarker(mapId: mapId)
          .listen((TapMarkerEvent e) => _tencentMapState.widget.onTapMarker!(e.value));
    }
    if (_tencentMapState.widget.onMarkerDragStart != null) {
      TencentMapMethodChannel.instance
          .onMarkerDragStart(mapId: mapId)
          .listen((MarkerDragStartEvent e) => _tencentMapState.widget.onMarkerDragStart!(e.value, e.position));
    }
    if (_tencentMapState.widget.onMarkerDrag != null) {
      TencentMapMethodChannel.instance
          .onMarkerDrag(mapId: mapId)
          .listen((MarkerDragEvent e) => _tencentMapState.widget.onMarkerDrag!(e.value, e.position));
    }
    if (_tencentMapState.widget.onMarkerDragEnd != null) {
      TencentMapMethodChannel.instance
          .onMarkerDragEnd(mapId: mapId)
          .listen((MarkerDragEndEvent e) => _tencentMapState.widget.onMarkerDragEnd!(e.value, e.position));
    }
    if (_tencentMapState.widget.onLocation != null) {
      TencentMapMethodChannel.instance
          .onLocationChanged(mapId: mapId)
          .listen((LocationChangedEvent e) => _tencentMapState.widget.onLocation!(e.value));
    }
    if (_tencentMapState.widget.onUserLocationClick != null) {
      TencentMapMethodChannel.instance
          .onUserLocationClick(mapId: mapId)
          .listen((UserLocationClickEvent e) => _tencentMapState.widget.onUserLocationClick!(e.position));
    }
  }

  /// 移动视野
  void moveCamera(CameraPosition position, [Duration? duration]) {
    TencentMapMethodChannel.instance.moveCamera(
      position,
      duration?.inMilliseconds ?? 0,
      mapId: mapId,
    );
  }

  /// 移动地图视野到某个地图区域
  void moveCameraRegion(Region region, EdgePadding padding, [Duration? duration]) {
    TencentMapMethodChannel.instance.moveCameraToRegion(
      region,
      padding,
      duration?.inMilliseconds ?? 0,
      mapId: mapId,
    );
  }

  /// 移动地图视野到包含一组坐标点的某个地图区域
  void moveCameraToRegionWithPosition(List<Position> positions, EdgePadding padding, [Duration? duration]) {
    TencentMapMethodChannel.instance.moveCameraToRegionWithPosition(
      positions,
      padding,
      duration?.inMilliseconds ?? 0,
      mapId: mapId,
    );
  }

  /// 限制地图显示区域
  void setRestrictRegion(Region region, RestrictRegionMode mode) {
    TencentMapMethodChannel.instance.setRestrictRegion(
      region,
      mode,
      mapId: mapId,
    );
  }

  /// 添加标记
  void addMarker(Marker marker) {
    TencentMapMethodChannel.instance.addMarker(
      marker,
      mapId: mapId,
    );
  }

  /// 移除标记点
  void removeMarker(String markerId) {
    TencentMapMethodChannel.instance.removeMarker(
      markerId,
      mapId: mapId,
    );
  }

  /// 更新标记点
  void updateMarker(String markerId, MarkerUpdateOptions options) {
    TencentMapMethodChannel.instance.updateMarker(
      markerId,
      options,
      mapId: mapId,
    );
  }

  /// 获取当前定位
  Future<Location> getUserLocation() {
    return TencentMapMethodChannel.instance.getUserLocation(mapId: mapId);
  }

  /// 开始地图渲染
  Future<void> start() {
    return TencentMapMethodChannel.instance.start(mapId: mapId);
  }

  /// 暂停地图渲染
  Future<void> pause() {
    return TencentMapMethodChannel.instance.pause(mapId: mapId);
  }

  /// 恢复地图渲染
  Future<void> resume() {
    return TencentMapMethodChannel.instance.resume(mapId: mapId);
  }

  /// 停止地图渲染
  Future<void> stop() {
    return TencentMapMethodChannel.instance.stop(mapId: mapId);
  }

  /// 销毁地图
  Future<void> destroy() {
    return TencentMapMethodChannel.instance.destroy(mapId: mapId);
  }
}
