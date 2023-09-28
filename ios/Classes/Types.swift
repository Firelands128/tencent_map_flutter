import Foundation
import Flutter

/// 地图类型
enum MapType: Int {
  /// 常规地图
  case normal = 0
  /// 卫星地图
  case satellite = 1
  /// 暗色地图
  case dark = 2
}

/// 限制显示区域模式
enum RestrictRegionMode: Int {
  /// 适配宽度
  case fitWidth = 0
  /// 适配高度
  case fitHeight = 1
}

/// UI控件位置锚点
enum UIControlAnchor: Int {
  case bottomLeft = 0
  case bottomRight = 1
  case topLeft = 2
  case topRight = 3
}

/// 定位模式：在地图的各种应用场景中，用户对定位点展示时也希望地图能跟随定位点旋转、移动等多种行为
enum UserLocationType: Int {
  /// 跟踪用户的位置与方向更新，默认是此种类型
  case trackingLocationRotate = 0
  /// 追踪用户的位置更新
  case trackingLocation = 1
  /// 跟踪用户的位置与方向更新，并移动到地图中心（Android only, Android default）
  case trackingLocationRotateCenter = 2
  /// 不追踪用户的位置与方向更新（iOS only）
  case noTracking = 3
  /// 跟踪用户的位置与方向更新，并地图依照用户方向旋转（Android only）
  case trackingRotate = 4
}

/// 点标记图标锚点
struct Anchor {
  /// 点标记图标锚点的X坐标
  var x: Double
  /// 点标记图标锚点的Y坐标
  var y: Double

  static func fromList(_ list: [Any?]) -> Anchor {
    let x = list[0] as! Double
    let y = list[1] as! Double

    return Anchor(
      x: x,
      y: y
    )
  }
  func toList() -> [Any?] {
    return [
      x,
      y,
    ]
  }
}

/// 图片信息
struct Bitmap {
  /// 图片资源路径
  var asset: String? = nil
  /// 图片数据
  var bytes: FlutterStandardTypedData? = nil

  static func fromList(_ list: [Any?]) -> Bitmap {
    let asset: String? = nilOrValue(list[0])
    let bytes: FlutterStandardTypedData? = nilOrValue(list[1])

    return Bitmap(
      asset: asset,
      bytes: bytes
    )
  }
  func toList() -> [Any?] {
    return [
      asset,
      bytes,
    ]
  }
}

/// 地图视野
struct CameraPosition {
  /// 地图视野的位置
  var position: Position? = nil
  /// 地图视野的旋转角度
  var heading: Double? = nil
  /// 地图视野的倾斜角度
  var skew: Double? = nil
  /// 地图视野的缩放级别
  var zoom: Double? = nil

  static func fromList(_ list: [Any?]) -> CameraPosition {
    var position: Position? = nil
    if let positionList: [Any?] = nilOrValue(list[0]) {
      position = Position.fromList(positionList)
    }
    let heading: Double? = nilOrValue(list[1])
    let skew: Double? = nilOrValue(list[2])
    let zoom: Double? = nilOrValue(list[3])

    return CameraPosition(
      position: position,
      heading: heading,
      skew: skew,
      zoom: zoom
    )
  }
  func toList() -> [Any?] {
    return [
      position?.toList(),
      heading,
      skew,
      zoom,
    ]
  }
}

/// 视野边缘宽度
struct EdgePadding {
  /// 上边缘宽度
  var top: Double
  /// 右边缘宽度
  var right: Double
  /// 下边缘宽度
  var bottom: Double
  /// 左边缘宽度
  var left: Double

  static func fromList(_ list: [Any?]) -> EdgePadding {
    let top = list[0] as! Double
    let right = list[1] as! Double
    let bottom = list[2] as! Double
    let left = list[3] as! Double

    return EdgePadding(
      top: top,
      right: right,
      bottom: bottom,
      left: left
    )
  }
  func toList() -> [Any?] {
    return [
      top,
      right,
      bottom,
      left,
    ]
  }
}

/// 定位点
struct Location {
  /// 定位点的位置
  var position: Position
  /// 定位点的方向
  var heading: Double? = nil
  /// 定位点的精确度
  var accuracy: Double? = nil

  static func fromList(_ list: [Any?]) -> Location {
    let position = Position.fromList(list[0] as! [Any?])
    let heading: Double? = nilOrValue(list[1])
    let accuracy: Double? = nilOrValue(list[2])

    return Location(
      position: position,
      heading: heading,
      accuracy: accuracy
    )
  }
  func toList() -> [Any?] {
    return [
      position.toList(),
      heading,
      accuracy,
    ]
  }
}

/// 地图属性配置
struct MapConfig {
  var mapType: MapType? = nil
  var mapStyle: Int32? = nil
  var logoScale: Double? = nil
  var logoPosition: UIControlPosition? = nil
  var scalePosition: UIControlPosition? = nil
  var compassOffset: UIControlOffset? = nil
  var compassEnabled: Bool? = nil
  var scaleEnabled: Bool? = nil
  var scaleFadeEnabled: Bool? = nil
  var skewGesturesEnabled: Bool? = nil
  var scrollGesturesEnabled: Bool? = nil
  var rotateGesturesEnabled: Bool? = nil
  var zoomGesturesEnabled: Bool? = nil
  var trafficEnabled: Bool? = nil
  var indoorViewEnabled: Bool? = nil
  var indoorPickerEnabled: Bool? = nil
  var buildingsEnabled: Bool? = nil
  var buildings3dEnabled: Bool? = nil
  var myLocationEnabled: Bool? = nil
  var userLocationType: UserLocationType? = nil

  static func fromList(_ list: [Any?]) -> MapConfig {
    var mapType: MapType? = nil
    if let type: Int = nilOrValue(list[0]) {
      mapType = MapType(rawValue: type)!
    }
    let mapStyle: Int32? = nilOrValue(list[1])
    let logoScale: Double? = nilOrValue(list[2])
    var logoPosition: UIControlPosition? = nil
    if let logoPositionList: [Any?] = nilOrValue(list[3]) {
      logoPosition = UIControlPosition.fromList(logoPositionList)
    }
    var scalePosition: UIControlPosition? = nil
    if let scalePositionList: [Any?] = nilOrValue(list[4]) {
      scalePosition = UIControlPosition.fromList(scalePositionList)
    }
    var compassOffset: UIControlOffset? = nil
    if let compassPositionList: [Any?] = nilOrValue(list[5]) {
      compassOffset = UIControlOffset.fromList(compassPositionList)
    }
    let compassEnabled: Bool? = nilOrValue(list[6])
    let scaleEnabled: Bool? = nilOrValue(list[7])
    let scaleFadeEnabled: Bool? = nilOrValue(list[8])
    let skewGesturesEnabled: Bool? = nilOrValue(list[9])
    let scrollGesturesEnabled: Bool? = nilOrValue(list[10])
    let rotateGesturesEnabled: Bool? = nilOrValue(list[11])
    let zoomGesturesEnabled: Bool? = nilOrValue(list[12])
    let trafficEnabled: Bool? = nilOrValue(list[13])
    let indoorViewEnabled: Bool? = nilOrValue(list[14])
    let indoorPickerEnabled: Bool? = nilOrValue(list[15])
    let buildingsEnabled: Bool? = nilOrValue(list[16])
    let buildings3dEnabled: Bool? = nilOrValue(list[17])
    let myLocationEnabled: Bool? = nilOrValue(list[18])
    var userLocationType: UserLocationType? = nil
    if let type: Int = nilOrValue(list[19]) {
      userLocationType = UserLocationType(rawValue: type)!
    }
    return MapConfig(
      mapType: mapType,
      mapStyle: mapStyle,
      logoScale: logoScale,
      logoPosition: logoPosition,
      scalePosition: scalePosition,
      compassOffset: compassOffset,
      compassEnabled: compassEnabled,
      scaleEnabled: scaleEnabled,
      scaleFadeEnabled: scaleFadeEnabled,
      skewGesturesEnabled: skewGesturesEnabled,
      scrollGesturesEnabled: scrollGesturesEnabled,
      rotateGesturesEnabled: rotateGesturesEnabled,
      zoomGesturesEnabled: zoomGesturesEnabled,
      trafficEnabled: trafficEnabled,
      indoorViewEnabled: indoorViewEnabled,
      indoorPickerEnabled: indoorPickerEnabled,
      buildingsEnabled: buildingsEnabled,
      buildings3dEnabled: buildings3dEnabled,
      myLocationEnabled: myLocationEnabled,
      userLocationType: userLocationType
    )
  }

  func toList() -> [Any?] {
    return [
      mapType?.rawValue,
      mapStyle,
      logoScale,
      logoPosition?.toList(),
      scalePosition?.toList(),
      compassOffset?.toList(),
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
      userLocationType?.rawValue,
    ]
  }
}

/// 标记点配置属性
struct Marker {
  /// 标记点ID
  var id: String
  /// 标记点的位置
  var position: Position
  /// 标记点的透明度
  var alpha: Double? = nil
  /// 标记点的旋转角度
  var rotation: Double? = nil
  /// 标记点的Z轴显示顺序
  var zIndex: Int64? = nil
  /// 标记点是否支持拖动
  var draggable: Bool? = nil
  /// 标记点的图标信息
  var icon: Bitmap? = nil
  /// 标记点的锚点
  var anchor: Anchor? = nil

  static func fromList(_ list: [Any?]) -> Marker {
    let id = list[0] as! String
    let position = Position.fromList(list[1] as! [Any?])
    let alpha: Double? = nilOrValue(list[2])
    let rotation: Double? = nilOrValue(list[3])
    let zIndex: Int64? = list[4] is NSNull ? nil : (list[4] is Int64? ? list[4] as! Int64?: Int64(list[4] as! Int32))
    let draggable: Bool? = nilOrValue(list[5])
    var icon: Bitmap? = nil
    if let iconList: [Any?] = nilOrValue(list[6]) {
      icon = Bitmap.fromList(iconList)
    }
    var anchor: Anchor? = nil
    if let anchorList: [Any?] = nilOrValue(list[7]) {
      anchor = Anchor.fromList(anchorList)
    }

    return Marker(
      id: id,
      position: position,
      alpha: alpha,
      rotation: rotation,
      zIndex: zIndex,
      draggable: draggable,
      icon: icon,
      anchor: anchor
    )
  }
  func toList() -> [Any?] {
    return [
      id,
      position.toList(),
      alpha,
      rotation,
      zIndex,
      draggable,
      icon?.toList(),
      anchor?.toList(),
    ]
  }
}

/// 标记点更新选项
struct MarkerUpdateOptions {
  /// 标记点的位置
  var position: Position? = nil
  /// 标记点的透明度
  var alpha: Double? = nil
  /// 标记点的旋转角度
  var rotation: Double? = nil
  /// 标记点的Z轴显示顺序
  var zIndex: Int64? = nil
  /// 标记点是否支持拖动
  var draggable: Bool? = nil
  /// 标记点的图标信息
  var icon: Bitmap? = nil
  /// 标记点的锚点
  var anchor: Anchor? = nil

  static func fromList(_ list: [Any?]) -> MarkerUpdateOptions {
    var position: Position? = nil
    if let positionList: [Any?] = nilOrValue(list[0]) {
      position = Position.fromList(positionList)
    }
    let alpha: Double? = nilOrValue(list[1])
    let rotation: Double? = nilOrValue(list[2])
    let zIndex: Int64? = list[3] is NSNull ? nil : (list[3] is Int64? ? list[3] as! Int64?: Int64(list[3] as! Int32))
    let draggable: Bool? = nilOrValue(list[4])
    var icon: Bitmap? = nil
    if let iconList: [Any?] = nilOrValue(list[5]) {
      icon = Bitmap.fromList(iconList)
    }
    var anchor: Anchor? = nil
    if let anchorList: [Any?] = nilOrValue(list[6]) {
      anchor = Anchor.fromList(anchorList)
    }

    return MarkerUpdateOptions(
      position: position,
      alpha: alpha,
      rotation: rotation,
      zIndex: zIndex,
      draggable: draggable,
      icon: icon,
      anchor: anchor
    )
  }
  func toList() -> [Any?] {
    return [
      position?.toList(),
      alpha,
      rotation,
      zIndex,
      draggable,
      icon?.toList(),
      anchor?.toList(),
    ]
  }
}

/// 地图兴趣点
struct Poi {
  /// 兴趣点的名称
  var name: String
  /// 兴趣点的位置
  var position: Position

  static func fromList(_ list: [Any?]) -> Poi {
    let name = list[0] as! String
    let position = Position.fromList(list[1] as! [Any?])

    return Poi(
      name: name,
      position: position
    )
  }
  func toList() -> [Any?] {
    return [
      name,
      position.toList(),
    ]
  }
}

/// 位置
struct Position {
  /// 位置的纬度
  var latitude: Double
  /// 位置的经度
  var longitude: Double

  static func fromList(_ list: [Any?]) -> Position {
    let latitude = list[0] as! Double
    let longitude = list[1] as! Double

    return Position(
      latitude: latitude,
      longitude: longitude
    )
  }
  func toList() -> [Any?] {
    return [
      latitude,
      longitude,
    ]
  }
}

/// 地图区域
struct Region {
  /// 最北的纬度
  var north: Double
  /// 最东的经度
  var east: Double
  /// 最南的纬度
  var south: Double
  /// 最西的经度
  var west: Double

  static func fromList(_ list: [Any?]) -> Region {
    let north = list[0] as! Double
    let east = list[1] as! Double
    let south = list[2] as! Double
    let west = list[3] as! Double

    return Region(
      north: north,
      east: east,
      south: south,
      west: west
    )
  }
  func toList() -> [Any?] {
    return [
      north,
      east,
      south,
      west,
    ]
  }
}

/// UI控件位置偏移
struct UIControlOffset {
  /// X轴方向的位置偏移
  var x: Double
  /// Y轴方向的位置偏移
  var y: Double

  static func fromList(_ list: [Any?]) -> UIControlOffset {
    let x = list[0] as! Double
    let y = list[1] as! Double

    return UIControlOffset(
      x: x,
      y: y
    )
  }
  func toList() -> [Any?] {
    return [
      x,
      y,
    ]
  }
}

/// UI控件位置
struct UIControlPosition {
  /// UI控件位置锚点
  var anchor: UIControlAnchor
  /// UI控件位置偏移
  var offset: UIControlOffset

  static func fromList(_ list: [Any?]) -> UIControlPosition? {
    let anchor = UIControlAnchor(rawValue: list[0] as! Int)!
    let offset = UIControlOffset.fromList(list[1] as! [Any?])

    return UIControlPosition(
      anchor: anchor,
      offset: offset
    )
  }
  func toList() -> [Any?] {
    return [
      anchor.rawValue,
      offset.toList(),
    ]
  }
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}
