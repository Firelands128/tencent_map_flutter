import "package:tencent_map/src/events.dart";

import "tencent_map.dart";
import "tencent_map_api.dart";
import "types.dart";

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
  static Future<TencentMapController> init(
    int id,
    TencentMapState tencentMapState,
  ) async {
    await TencentMapApi.instance.init(id);
    return TencentMapController._(
      tencentMapState,
      mapId: id,
    );
  }

  void _connectStreams(int mapId) {
    if (_tencentMapState.widget.onScaleViewChanged != null) {
      TencentMapApi.instance
          .onScaleViewChanged(mapId: mapId)
          .listen((ScaleViewChangedEvent e) => _tencentMapState.widget.onScaleViewChanged!(e.value));
    }
    if (_tencentMapState.widget.onPress != null) {
      TencentMapApi.instance
          .onMapPress(mapId: mapId)
          .listen((MapPressEvent e) => _tencentMapState.widget.onPress!(e.position));
    }
    if (_tencentMapState.widget.onLongPress != null) {
      TencentMapApi.instance
          .onMapLongPress(mapId: mapId)
          .listen((MapLongPressEvent e) => _tencentMapState.widget.onLongPress!(e.position));
    }
    if (_tencentMapState.widget.onTapPoi != null) {
      TencentMapApi.instance
          .onPoiTap(mapId: mapId)
          .listen((PoiTapEvent e) => _tencentMapState.widget.onTapPoi!(e.value));
    }
    if (_tencentMapState.widget.onCameraMoveStart != null) {
      TencentMapApi.instance
          .onCameraMoveStart(mapId: mapId)
          .listen((CameraMoveStartEvent e) => _tencentMapState.widget.onCameraMoveStart!(e.value));
    }
    if (_tencentMapState.widget.onCameraMove != null) {
      TencentMapApi.instance
          .onCameraMove(mapId: mapId)
          .listen((CameraMoveEvent e) => _tencentMapState.widget.onCameraMove!(e.value));
    }
    if (_tencentMapState.widget.onCameraMoveEnd != null) {
      TencentMapApi.instance
          .onCameraMoveEnd(mapId: mapId)
          .listen((CameraMoveEndEvent e) => _tencentMapState.widget.onCameraMoveEnd!(e.value));
    }
    if (_tencentMapState.widget.onTapMarker != null) {
      TencentMapApi.instance
          .onTapMarker(mapId: mapId)
          .listen((TapMarkerEvent e) => _tencentMapState.widget.onTapMarker!(e.value));
    }
    if (_tencentMapState.widget.onMarkerDragStart != null) {
      TencentMapApi.instance
          .onMarkerDragStart(mapId: mapId)
          .listen((MarkerDragStartEvent e) => _tencentMapState.widget.onMarkerDragStart!(e.value, e.position));
    }
    if (_tencentMapState.widget.onMarkerDrag != null) {
      TencentMapApi.instance
          .onMarkerDrag(mapId: mapId)
          .listen((MarkerDragEvent e) => _tencentMapState.widget.onMarkerDrag!(e.value, e.position));
    }
    if (_tencentMapState.widget.onMarkerDragEnd != null) {
      TencentMapApi.instance
          .onMarkerDragEnd(mapId: mapId)
          .listen((MarkerDragEndEvent e) => _tencentMapState.widget.onMarkerDragEnd!(e.value, e.position));
    }
    if (_tencentMapState.widget.onLocation != null) {
      TencentMapApi.instance
          .onLocationChanged(mapId: mapId)
          .listen((LocationChangedEvent e) => _tencentMapState.widget.onLocation!(e.value));
    }
    if (_tencentMapState.widget.onUserLocationClick != null) {
      TencentMapApi.instance
          .onUserLocationClick(mapId: mapId)
          .listen((UserLocationClickEvent e) => _tencentMapState.widget.onUserLocationClick!(e.position));
    }
  }

  /// 移动视野
  void moveCamera(CameraPosition position, [Duration? duration]) {
    TencentMapApi.instance.moveCamera(
      position,
      duration?.inMilliseconds ?? 0,
      mapId: mapId,
    );
  }

  /// 移动地图视野到某个地图区域
  void moveCameraRegion(Region region, EdgePadding padding, [Duration? duration]) {
    TencentMapApi.instance.moveCameraToRegion(
      region,
      padding,
      duration?.inMilliseconds ?? 0,
      mapId: mapId,
    );
  }

  /// 移动地图视野到包含一组坐标点的某个地图区域
  void moveCameraToRegionWithPosition(List<Position> positions, EdgePadding padding, [Duration? duration]) {
    TencentMapApi.instance.moveCameraToRegionWithPosition(
      positions,
      padding,
      duration?.inMilliseconds ?? 0,
      mapId: mapId,
    );
  }

  /// 限制地图显示区域
  void setRestrictRegion(Region region, RestrictRegionMode mode) {
    TencentMapApi.instance.setRestrictRegion(
      region,
      mode,
      mapId: mapId,
    );
  }

  /// 添加标记
  void addMarker(Marker marker) {
    TencentMapApi.instance.addMarker(
      marker,
      mapId: mapId,
    );
  }

  /// 移除标记点
  void removeMarker(String markerId) {
    TencentMapApi.instance.removeMarker(
      markerId,
      mapId: mapId,
    );
  }

  /// 更新标记点
  void updateMarker(String markerId, MarkerUpdateOptions options) {
    TencentMapApi.instance.updateMarker(
      markerId,
      options,
      mapId: mapId,
    );
  }

  /// 销毁地图
  Future<void> destroy() {
    return TencentMapApi.instance.destroy(mapId: mapId);
  }

  /// 停止地图渲染
  Future<void> stop() {
    return TencentMapApi.instance.stop(mapId: mapId);
  }

  /// 暂停地图渲染
  Future<void> pause() {
    return TencentMapApi.instance.pause(mapId: mapId);
  }

  /// 恢复地图渲染
  Future<void> resume() {
    return TencentMapApi.instance.resume(mapId: mapId);
  }

  /// 获取当前定位
  Future<Location> getUserLocation() {
    return TencentMapApi.instance.getUserLocation(mapId: mapId);
  }
}
