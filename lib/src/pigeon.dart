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

  void setMyLocation(Location location);

  void setMyLocationStyle(MyLocationStyle style);

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

  void setPosition(String id, LatLng position);

  void setAnchor(String id, double x, double y);

  void setZIndex(String id, int zIndex);

  void setAlpha(String id, double alpha);

  void setIcon(String id, Bitmap icon);

  void setDraggable(String id, bool draggable);
}

@FlutterApi()
abstract class TencentMapHandler {
  /// 当点击地图上任意地点时会触发该回调，方法会传入点击的坐标点，事件可能被上层覆盖物拦截
  void onPress(LatLng latLng);

  /// 当地图上任意地点进行长按点击时会触发该回调，事件可能被上层覆盖物拦截（Android Only）
  void onLongPress(LatLng latLng);

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
  void onMarkerDragStart(String markerId, LatLng latLng);

  /// 当拖动点标记时触发该回调（Android Only）
  void onMarkerDrag(String markerId, LatLng latLng);

  /// 当拖动点标记完成时触发该回调（Android Only）
  void onMarkerDragEnd(String markerId, LatLng latLng);

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
enum MyLocationType {
  /// 连续定位，但不会移动到地图中心点，并且会跟随设备移动
  followNoCenter,

  /// 连续定位，且将视角移动到地图中心，定位点依照设备方向旋转，并且会跟随设备移动,默认是此种类型
  locationRotate,

  /// 连续定位，但不会移动到地图中心点，定位点依照设备方向旋转，并且跟随设备移动
  locationRotateNoCenter,

  /// 连续定位，但不会移动到地图中心点，地图依照设备方向旋转，并且会跟随设备移动
  mapRotateNoCenter,
}

class MyLocationStyle {
  MyLocationType? myLocationType;
}

class Anchor {
  late double x;
  late double y;
}

class LatLng {
  late double latitude;
  late double longitude;
}

class Location {
  double? latitude;
  double? longitude;
  double? bearing;
  double? accuracy;
}

class MapPoi {
  late String name;
  late LatLng position;
}

class CameraPosition {
  double? bearing;
  LatLng? target;
  double? tilt;
  double? zoom;
}

class MarkerOptions {
  late LatLng position;
  double? alpha;
  double? rotation;
  int? zIndex;
  bool? flat;
  bool? draggable;
  Bitmap? icon;
  Anchor? anchor;
}

class PolylineOptions {
  List<LatLng?>? points;
}

class Bitmap {
  String? asset;
  Uint8List? bytes;
}
