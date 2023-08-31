// ignore: depend_on_referenced_packages
import 'package:pigeon/pigeon.dart';

/// 配置Pigeon
@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon.g.dart',
    kotlinOut: 'android/src/main/kotlin/com/morbit/tencent_map/Pigeon.kt',
    kotlinOptions: KotlinOptions(package: 'com.morbit.tencent_map'),
    swiftOut: 'ios/Classes/Pigeon.swift',
    swiftOptions: SwiftOptions(),
  ),
)

/// 地图SDK接口
@HostApi()
abstract class TencentMapSdkApi {
  /// 初始化地图SDK，显示地图前必须调用
  void initSdk(String? iosApiKey, bool agreePrivacy);
}

/// 地图操作接口
@HostApi()
abstract class TencentMapApi {
  /// 设置地图类型
  void setMapType(MapType type);

  /// 设置个性化地图样式，在官网绑定个性化地图样式，输入样式编号
  void setMapStyle(int index);

  /// 设置Logo大小
  void setLogoScale(double scale);

  /// 设置LOGO的位置
  void setLogoPosition(UIControlAnchor anchor, UIControlOffset offset);

  /// 设置比例尺的位置（iOS不支持改变位置锚点，仅支持改变位置偏移）
  void setScalePosition(UIControlAnchor anchor, UIControlOffset offset);

  /// 设置指南针的位置偏移
  void setCompassOffset(UIControlOffset offset);

  /// 设置是否显示指南针
  void setCompassEnabled(bool enabled);

  /// 设置是否显示比例尺
  void setScaleEnabled(bool enabled);

  /// 设置比例尺是否淡出
  void setScaleFadeEnabled(bool enabled);

  /// 设置是否使用旋转手势
  void setRotateGesturesEnabled(bool enabled);

  /// 设置是否使用滚动手势
  void setScrollGesturesEnabled(bool enabled);

  /// 设置是否使用缩放手势
  void setZoomGesturesEnabled(bool enabled);

  /// 设置是否使用倾斜手势
  void setSkewGesturesEnabled(bool enabled);

  /// 设置是否显示室内图（需要API key支持）
  void setIndoorViewEnabled(bool enabled);

  /// 设置是否显示室内图楼层控件
  void setIndoorPickerEnabled(bool enabled);

  /// 设置是否显示路况
  void setTrafficEnabled(bool enabled);

  /// 设置是否显示建筑物
  void setBuildingsEnabled(bool enabled);

  /// 设置是否显示3D建筑物
  void setBuildings3dEnabled(bool enabled);

  /// 设置是否开启定位
  void setMyLocationEnabled(bool enabled);

  /// 设置定位模式
  void setUserLocationType(UserLocationType type);

  /// 获取当前定位信息
  Location getUserLocation();

  /// 移动地图视野
  void moveCamera(CameraPosition position, int duration);

  /// 移动地图视野到某个地图区域
  void moveCameraToRegion(Region region, EdgePadding padding, int duration);

  /// 移动地图视野到包含一组坐标点的某个地图区域
  void moveCameraToRegionWithPosition(List<Position?> positions, EdgePadding padding, int duration);

  /// 限制地图显示区域
  void setRestrictRegion(Region region, RestrictRegionMode mode);

  /// 添加标记点
  String addMarker(MarkerOptions options);

  /// 添加折线
  String addPolyline(PolylineOptions options);

  /// 开始
  void start();

  /// 暂停
  void pause();

  /// 恢复
  void resume();

  /// 停止
  void stop();

  /// 销毁
  void destroy();
}

/// 标记点操作接口
@HostApi()
abstract class MarkerApi {
  /// 移除标记点
  void remove(String id);

  /// 更新标记点的位置
  void setPosition(String id, Position position);

  /// 更新标记点的图标
  void setIcon(String id, Bitmap icon);

  /// 更新标记点的锚点
  void setAnchor(String id, Anchor anchor);

  /// 更新标记点的透明度
  void setAlpha(String id, double alpha);

  /// 更新标记点的旋转角度
  void setRotation(String id, double rotation);

  /// 更新标记点的Z轴显示顺序
  void setZIndex(String id, int zIndex);

  /// 更新标记点的是否可拖拽属性值
  void setDraggable(String id, bool draggable);
}

/// 地图状态事件回调处理器
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

/// 地图类型
enum MapType {
  /// 常规地图
  normal,

  /// 卫星地图
  satellite,

  /// 暗色地图
  dark,
}

/// UI控件位置锚点
enum UIControlAnchor {
  // 左下角
  bottomLeft,

  // 右下角
  bottomRight,

  // 左上角
  topLeft,

  // 右上角
  topRight,
}

/// UI控件位置偏移
class UIControlOffset {
  /// X轴方向的位置偏移
  late double x;

  /// Y轴方向的位置偏移
  late double y;
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

/// 点标记图标锚点
class Anchor {
  /// 点标记图标锚点的X坐标
  late double x;

  /// 点标记图标锚点的Y坐标
  late double y;
}

/// 位置
class Position {
  /// 位置的纬度
  late double latitude;

  /// 位置的经度
  late double longitude;
}

/// 定位点
class Location {
  /// 定位点的位置
  late Position position;

  /// 定位点的方向
  double? heading;

  /// 定位点的精确度
  double? accuracy;
}

/// 地图兴趣点
class MapPoi {
  /// 兴趣点的名称
  late String name;

  /// 兴趣点的位置
  late Position position;
}

/// 地图视野
class CameraPosition {
  /// 地图视野的位置
  Position? position;

  /// 地图视野的旋转角度
  double? heading;

  /// 地图视野的倾斜角度
  double? skew;

  /// 地图视野的缩放级别
  double? zoom;
}

/// 地图区域
class Region {
  /// 最北的纬度
  late double north;

  /// 最东的经度
  late double east;

  /// 最南的纬度
  late double south;

  /// 最西的经度
  late double west;
}

/// 视野边缘宽度
class EdgePadding {
  /// 上边缘宽度
  late double top;

  /// 右边缘宽度
  late double right;

  /// 下边缘宽度
  late double bottom;

  /// 左边缘宽度
  late double left;
}

/// 限制显示区域模式
enum RestrictRegionMode {
  /// 适配宽度
  fitWidth,

  /// 适配高度
  fitHeight,
}

/// 标记点配置属性
class MarkerOptions {
  /// 标记点的位置
  late Position position;

  /// 标记点的透明度
  double? alpha;

  /// 标记点的旋转角度
  double? rotation;

  /// 标记点的Z轴显示顺序
  int? zIndex;

  /// 标记点是否支持3D悬浮（Android Only)
  bool? flat;

  /// 标记点是否支持拖动
  bool? draggable;

  /// 标记点的图标信息
  Bitmap? icon;

  /// 标记点的锚点
  Anchor? anchor;
}

/// 折线配置属性
class PolylineOptions {
  /// 折线中拐点位置的列表
  List<Position?>? points;
}

/// 图片信息
class Bitmap {
  /// 图片资源路径
  String? asset;

  /// 图片数据
  Uint8List? bytes;
}
