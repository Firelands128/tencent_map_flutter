part of '../tencent_map_flutter.dart';

/// 地图类型
enum MapType {
  /// 常规地图
  normal,

  /// 卫星地图
  satellite,

  /// 暗色地图
  dark,
}

/// 限制显示区域模式
enum RestrictRegionMode {
  /// 适配宽度
  fitWidth,

  /// 适配高度
  fitHeight,
}

/// UI控件位置锚点
enum UIControlAnchor {
  bottomLeft,
  bottomRight,
  topLeft,
  topRight,
}

/// 定位模式: 在地图的各种应用场景中，用户对定位点展示时也希望地图能跟随定位点旋转、移动等多种行为
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
  Anchor({
    required this.x,
    required this.y,
  });

  /// 点标记图标锚点的X坐标
  double x;

  /// 点标记图标锚点的Y坐标
  double y;

  Object encode() {
    return <Object?>[
      x,
      y,
    ];
  }

  static Anchor decode(Object result) {
    result as List<Object?>;
    return Anchor(
      x: result[0]! as double,
      y: result[1]! as double,
    );
  }
}

/// 图片信息
class Bitmap {
  Bitmap({
    this.asset,
    this.bytes,
  });

  /// 图片资源路径
  String? asset;

  /// 图片数据
  Uint8List? bytes;

  Object encode() {
    return <Object?>[
      asset,
      bytes,
    ];
  }

  static Bitmap decode(Object result) {
    result as List<Object?>;
    return Bitmap(
      asset: result[0] as String?,
      bytes: result[1] as Uint8List?,
    );
  }
}

/// 地图视野
class CameraPosition {
  CameraPosition({
    this.position,
    this.heading,
    this.skew,
    this.zoom,
  });

  /// 地图视野的位置
  LatLng? position;

  /// 地图视野的旋转角度
  double? heading;

  /// 地图视野的倾斜角度
  double? skew;

  /// 地图视野的缩放级别
  double? zoom;

  Object encode() {
    return <Object?>[
      position?.position.encode(),
      heading,
      skew,
      zoom,
    ];
  }

  static CameraPosition decode(Object result) {
    result as List<Object?>;
    return CameraPosition(
      position: result[0] != null
          ? Position.decode(result[0]! as List<Object?>).latLng
          : null,
      heading: result[1] as double?,
      skew: result[2] as double?,
      zoom: result[3] as double?,
    );
  }
}

/// 视野边缘宽度
class EdgePadding {
  EdgePadding({
    required this.top,
    required this.right,
    required this.bottom,
    required this.left,
  });

  /// 上边缘宽度
  double top;

  /// 右边缘宽度
  double right;

  /// 下边缘宽度
  double bottom;

  /// 左边缘宽度
  double left;

  Object encode() {
    return <Object?>[
      top,
      right,
      bottom,
      left,
    ];
  }

  static EdgePadding decode(Object result) {
    result as List<Object?>;
    return EdgePadding(
      top: result[0]! as double,
      right: result[1]! as double,
      bottom: result[2]! as double,
      left: result[3]! as double,
    );
  }
}

/// 定位点
class Location {
  Location({
    required this.position,
    this.heading,
    this.accuracy,
  });

  /// 定位点的位置
  LatLng position;

  /// 定位点的方向
  double? heading;

  /// 定位点的精确度
  double? accuracy;

  Object encode() {
    return <Object?>[
      position.position.encode(),
      heading,
      accuracy,
    ];
  }

  static Location decode(Object result) {
    result as List<Object?>;
    return Location(
      position: Position.decode(result[0]! as List<Object?>).latLng,
      heading: result[1] as double?,
      accuracy: result[2] as double?,
    );
  }
}

/// 地图属性配置
class MapConfig {
  MapConfig({
    this.mapType,
    this.mapStyle,
    this.logoScale,
    this.logoPosition,
    this.scalePosition,
    this.compassOffset,
    this.compassEnabled,
    this.scaleEnabled,
    this.scaleFadeEnabled,
    this.skewGesturesEnabled,
    this.scrollGesturesEnabled,
    this.rotateGesturesEnabled,
    this.zoomGesturesEnabled,
    this.trafficEnabled,
    this.indoorViewEnabled,
    this.indoorPickerEnabled,
    this.buildingsEnabled,
    this.buildings3dEnabled,
    this.myLocationEnabled,
    this.userLocationType,
  });

  MapType? mapType;
  int? mapStyle;
  double? logoScale;
  UIControlPosition? logoPosition;
  UIControlPosition? scalePosition;
  UIControlOffset? compassOffset;
  bool? compassEnabled;
  bool? scaleEnabled;
  bool? scaleFadeEnabled;
  bool? skewGesturesEnabled;
  bool? scrollGesturesEnabled;
  bool? rotateGesturesEnabled;
  bool? zoomGesturesEnabled;
  bool? trafficEnabled;
  bool? indoorViewEnabled;
  bool? indoorPickerEnabled;
  bool? buildingsEnabled;
  bool? buildings3dEnabled;
  bool? myLocationEnabled;
  UserLocationType? userLocationType;

  Object encode() {
    return <Object?>[
      mapType?.index,
      mapStyle,
      logoScale,
      logoPosition?.encode(),
      scalePosition?.encode(),
      compassOffset?.encode(),
      compassEnabled,
      scaleEnabled,
      scaleFadeEnabled,
      skewGesturesEnabled,
      scrollGesturesEnabled,
      rotateGesturesEnabled,
      zoomGesturesEnabled,
      trafficEnabled,
      indoorViewEnabled,
      indoorPickerEnabled,
      buildingsEnabled,
      buildings3dEnabled,
      myLocationEnabled,
      userLocationType?.index,
    ];
  }

  static MapConfig decode(Object result) {
    result as List<Object?>;
    return MapConfig(
      mapType:
          result[0] != null ? MapType.values.elementAt(result[0] as int) : null,
      mapStyle: result[1] as int?,
      logoScale: result[2] as double?,
      logoPosition: result[3] != null
          ? UIControlPosition.decode(result[3]! as List<Object?>)
          : null,
      scalePosition: result[4] != null
          ? UIControlPosition.decode(result[4]! as List<Object?>)
          : null,
      compassOffset: result[5] != null
          ? UIControlOffset.decode(result[5]! as List<Object?>)
          : null,
      compassEnabled: result[6] as bool?,
      scaleEnabled: result[7] as bool?,
      scaleFadeEnabled: result[8] as bool?,
      skewGesturesEnabled: result[9] as bool?,
      scrollGesturesEnabled: result[10] as bool?,
      rotateGesturesEnabled: result[11] as bool?,
      zoomGesturesEnabled: result[12] as bool?,
      trafficEnabled: result[13] as bool?,
      indoorViewEnabled: result[14] as bool?,
      indoorPickerEnabled: result[15] as bool?,
      buildingsEnabled: result[16] as bool?,
      buildings3dEnabled: result[17] as bool?,
      myLocationEnabled: result[18] as bool?,
      userLocationType: result[19] != null
          ? UserLocationType.values.elementAt(result[19] as int)
          : null,
    );
  }
}

/// 标记点配置属性
class Marker {
  Marker({
    required this.id,
    required this.position,
    this.alpha,
    this.rotation,
    this.zIndex,
    this.draggable,
    this.icon,
    this.anchor,
  });

  /// 标记点ID
  String id;

  /// 标记点的位置
  LatLng position;

  /// 标记点的透明度
  double? alpha;

  /// 标记点的旋转角度
  double? rotation;

  /// 标记点的Z轴显示顺序
  int? zIndex;

  /// 标记点是否支持拖动
  bool? draggable;

  /// 标记点的图标信息
  Bitmap? icon;

  /// 标记点的锚点
  Anchor? anchor;

  Object encode() {
    return <Object?>[
      id,
      position.position.encode(),
      alpha,
      rotation,
      zIndex,
      draggable,
      icon?.encode(),
      anchor?.encode(),
    ];
  }

  static Marker decode(Object result) {
    result as List<Object?>;
    return Marker(
      id: result[0]! as String,
      position: Position.decode(result[1]! as List<Object?>).latLng,
      alpha: result[2] as double?,
      rotation: result[3] as double?,
      zIndex: result[4] as int?,
      draggable: result[5] as bool?,
      icon:
          result[6] != null ? Bitmap.decode(result[6]! as List<Object?>) : null,
      anchor:
          result[7] != null ? Anchor.decode(result[7]! as List<Object?>) : null,
    );
  }
}

/// 标记点更新配置属性
class MarkerUpdateOptions {
  MarkerUpdateOptions({
    this.position,
    this.alpha,
    this.rotation,
    this.zIndex,
    this.draggable,
    this.icon,
    this.anchor,
  });

  /// 标记点的位置
  LatLng? position;

  /// 标记点的透明度
  double? alpha;

  /// 标记点的旋转角度
  double? rotation;

  /// 标记点的Z轴显示顺序
  int? zIndex;

  /// 标记点是否支持拖动
  bool? draggable;

  /// 标记点的图标信息
  Bitmap? icon;

  /// 标记点的锚点
  Anchor? anchor;

  Object encode() {
    return <Object?>[
      position?.position.encode(),
      alpha,
      rotation,
      zIndex,
      draggable,
      icon?.encode(),
      anchor?.encode(),
    ];
  }

  static MarkerUpdateOptions decode(Object result) {
    result as List<Object?>;
    return MarkerUpdateOptions(
      position: result[0] != null
          ? Position.decode(result[0]! as List<Object?>).latLng
          : null,
      alpha: result[1] as double?,
      rotation: result[2] as double?,
      zIndex: result[3] as int?,
      draggable: result[4] as bool?,
      icon:
          result[5] != null ? Bitmap.decode(result[5]! as List<Object?>) : null,
      anchor:
          result[6] != null ? Anchor.decode(result[6]! as List<Object?>) : null,
    );
  }
}

/// 地图兴趣点
class Poi {
  Poi({
    required this.name,
    required this.position,
  });

  /// 兴趣点的名称
  String name;

  /// 兴趣点的位置
  LatLng position;

  Object encode() {
    return <Object?>[
      name,
      position.position.encode(),
    ];
  }

  static Poi decode(Object result) {
    result as List<Object?>;
    return Poi(
      name: result[0]! as String,
      position: Position.decode(result[1]! as List<Object?>).latLng,
    );
  }
}

/// 位置
class Position {
  Position({
    required double latitude,
    required double longitude,
  })  : latitude =
            latitude < -90.0 ? -90.0 : (latitude > 90.0 ? 90.0 : latitude),
        longitude = longitude >= -180 && longitude < 180
            ? longitude
            : (longitude + 180.0) % 360.0 - 180.0;

  /// 位置的纬度
  double latitude;

  /// 位置的经度
  double longitude;

  Object encode() {
    return <Object?>[
      latitude,
      longitude,
    ];
  }

  static Position decode(Object result) {
    assert(result is List && result.length == 2);
    result as List<Object?>;
    return Position(
      latitude: result[0]! as double,
      longitude: result[1]! as double,
    );
  }
}

/// 地图区域
class Region {
  Region({
    required this.north,
    required this.east,
    required this.south,
    required this.west,
  });

  /// 最北的纬度
  double north;

  /// 最东的经度
  double east;

  /// 最南的纬度
  double south;

  /// 最西的经度
  double west;

  Object encode() {
    return <Object?>[
      north,
      east,
      south,
      west,
    ];
  }

  static Region decode(Object result) {
    result as List<Object?>;
    return Region(
      north: result[0]! as double,
      east: result[1]! as double,
      south: result[2]! as double,
      west: result[3]! as double,
    );
  }
}

/// UI控件位置偏移
class UIControlOffset {
  UIControlOffset({
    required this.x,
    required this.y,
  });

  /// X轴方向的位置偏移
  double x;

  /// Y轴方向的位置偏移
  double y;

  Object encode() {
    return <Object?>[
      x,
      y,
    ];
  }

  static UIControlOffset decode(Object result) {
    result as List<Object?>;
    return UIControlOffset(
      x: result[0]! as double,
      y: result[1]! as double,
    );
  }
}

/// UI控件位置
class UIControlPosition {
  UIControlPosition({
    required this.anchor,
    required this.offset,
  });

  /// UI控件位置锚点
  UIControlAnchor anchor;

  /// UI控件位置偏移
  UIControlOffset offset;

  Object encode() {
    return <Object?>[
      anchor.index,
      offset.encode(),
    ];
  }

  static UIControlPosition decode(Object result) {
    result as List<Object?>;
    return UIControlPosition(
      anchor: UIControlAnchor.values[result[0]! as int],
      offset: UIControlOffset.decode(result[1]! as List<Object?>),
    );
  }

  UIControlPosition copyWith({
    UIControlAnchor? anchor,
    UIControlOffset? offset,
  }) {
    return UIControlPosition(
      anchor: anchor ?? this.anchor,
      offset: offset ?? this.offset,
    );
  }
}
