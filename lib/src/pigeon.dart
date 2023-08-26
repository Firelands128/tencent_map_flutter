// ignore: depend_on_referenced_packages
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon.g.dart',
    kotlinOut: 'android/src/main/kotlin/com/morbit/tencent_map/Pigeon.kt',
    kotlinOptions: KotlinOptions(package: 'com.morbit.tencent_map'),
    swiftOut: 'ios/Classes/Pigeon.swift',
    swiftOptions: SwiftOptions(),
  ),
)
@HostApi()
abstract class TencentMapSdkApi {
  void initSdk(String? iosApiKey, bool agreePrivacy);
}

@HostApi()
abstract class TencentMapApi {
  void setMapType(MapType type);

  void setCompassEnabled(bool enabled);

  void setScaleControlsEnabled(bool enabled);

  void setRotateGesturesEnabled(bool enabled);

  void setScrollGesturesEnabled(bool enabled);

  void setZoomGesturesEnabled(bool enabled);

  void setTiltGesturesEnabled(bool enabled);

  void setIndoorViewEnabled(bool enabled);

  void setTrafficEnabled(bool enabled);

  void setBuildingsEnabled(bool enabled);

  void setMyLocationButtonEnabled(bool enabled);

  void setMyLocationEnabled(bool enabled);

  void setUserLocationType(UserLocationType type);

  void moveCamera(CameraPosition position, int duration);

  String addMarker(MarkerOptions options);

  String addPolyline(PolylineOptions options);

  void pause();

  void resume();

  void stop();

  void start();

  void destroy();
}

@HostApi()
abstract class MarkerApi {
  void remove(String id);

  void setRotation(String id, double rotation);

  void setPosition(String id, Position position);

  void setAnchor(String id, double x, double y);

  void setZIndex(String id, int zIndex);

  void setAlpha(String id, double alpha);

  void setIcon(String id, Bitmap icon);

  void setDraggable(String id, bool draggable);
}

@FlutterApi()
abstract class TencentMapHandler {
  /// 当点击地图上任意地点时会触发该回调，方法会传入点击的坐标点，事件可能被上层覆盖物拦截
  void onPress(Position position);

  /// 当地图上任意地点进行长按点击时会触发该回调，事件可能被上层覆盖物拦截（Android Only）
  void onLongPress(Position position);

  /// 当点击地图上任意的POI时调用，方法会传入点击的POI信息
  void onTapPoi(MapPoi poi);

  /// 当地图视野即将改变时会触发该回调（iOS Only）
  void onCameraMoveStart(CameraPosition cameraPosition);

  /// 当地图视野发生变化时触发该回调。视野持续变化时本回调可能会被频繁多次调用, 请不要做耗时或复杂的事情
  void onCameraMove(CameraPosition cameraPosition);

  /// 当地图视野变化完成时触发该回调，需注意当前地图状态有可能并不是稳定状态
  void onCameraMoveEnd(CameraPosition cameraPosition);

  /// 当点击点标记时触发该回调（Android Only）
  void onTapMarker(String markerId);

  /// 当开始拖动点标记时触发该回调（Android Only）
  void onMarkerDragStart(String markerId, Position position);

  /// 当拖动点标记时触发该回调（Android Only）
  void onMarkerDrag(String markerId, Position position);

  /// 当拖动点标记完成时触发该回调（Android Only）
  void onMarkerDragEnd(String markerId, Position position);

  /// 当前位置改变时触发该回调（Android Only）
  void onLocation(Location location);
}

enum MapType {
  normal,
  satellite,
  dark,
}

/// 定位模式
///
/// 在地图的各种应用场景中，用户对定位点展示时也希望地图能跟随定位点旋转、移动等多种行为
enum UserLocationType {
  /// 跟踪用户的位置与方向更新，默认是此种类型
  trackingLocationRotate,

  /// 追踪用户的位置更新
  trackingLocation,

  /// 跟踪用户的位置与方向更新，并移动到地图中心（Android only, Android default）
  trackingLocationRotateCenter,

  /// 不追踪用户的位置与方向更新（iOS only）
  noTracking,

  /// 跟踪用户的位置与方向更新，并地图依照用户方向旋转（Android only）
  trackingRotate,
}

class Anchor {
  late double x;
  late double y;
}

class Position {
  late double latitude;
  late double longitude;
}

class Location {
  late Position position;
  double? bearing;
  double? accuracy;
}

class MapPoi {
  late String name;
  late Position position;
}

class CameraPosition {
  Position? target;
  double? bearing;
  double? tilt;
  double? zoom;
}

class MarkerOptions {
  late Position position;
  double? alpha;
  double? rotation;
  int? zIndex;
  bool? flat;
  bool? draggable;
  Bitmap? icon;
  Anchor? anchor;
}

class PolylineOptions {
  List<Position?>? points;
}

class Bitmap {
  String? asset;
  Uint8List? bytes;
}
