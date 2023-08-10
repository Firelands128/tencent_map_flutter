// ignore: depend_on_referenced_packages
import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon.g.dart',
    kotlinOut: 'android/src/main/kotlin/com/morbit/tencent_map/Pigeon.kt',
    kotlinOptions: KotlinOptions(package: 'com.morbit.tencent_map'),
    swiftOut: 'ios/Classes/Pigeon.swift',
    swiftOptions: SwiftOptions(),
    // dartPackageName: "com.morbit",

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

  void destory();
}

@FlutterApi()
abstract class TencentMapHandler {
  void onTap(LatLng latLng);

  void onTapPoi(MapPoi poi);

  void onLongPress(LatLng latLng);

  void onCameraMove(CameraPosition cameraPosition);

  void onCameraIdle(CameraPosition cameraPosition);

  void onLocation(Location location);

  void onTapMarker(String markerId);

  void onMarkerDragStart(String markerId, LatLng latLng);

  void onMarkerDrag(String markerId, LatLng latLng);

  void onMarkerDragEnd(String markerId, LatLng latLng);
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

class LatLng {
  double? latitude;
  double? longitude;
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
  List<double?>? anchor;
}

class PolylineOptions {
  List<LatLng?>? points;
}

class Bitmap {
  String? asset;
  Uint8List? bytes;
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
