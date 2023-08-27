// Autogenerated from Pigeon (v10.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// 地图类型
enum MapType: Int {
  /// 常规地图
  case normal = 0
  /// 卫星地图
  case satellite = 1
  /// 暗色地图
  case dark = 2
}

/// 定位模式
///
/// 在地图的各种应用场景中，用户对定位点展示时也希望地图能跟随定位点旋转、移动等多种行为
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
///
/// Generated class from Pigeon that represents data sent in messages.
struct Anchor {
  /// 点标记图标锚点的X坐标
  var x: Double
  /// 点标记图标锚点的Y坐标
  var y: Double

  static func fromList(_ list: [Any?]) -> Anchor? {
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

/// 位置
///
/// Generated class from Pigeon that represents data sent in messages.
struct Position {
  /// 位置的纬度
  var latitude: Double
  /// 位置的经度
  var longitude: Double

  static func fromList(_ list: [Any?]) -> Position? {
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

/// 定位点
///
/// Generated class from Pigeon that represents data sent in messages.
struct Location {
  /// 定位点的位置
  var position: Position
  /// 定位点的方向
  var bearing: Double? = nil
  /// 定位点的精确度
  var accuracy: Double? = nil

  static func fromList(_ list: [Any?]) -> Location? {
    let position = Position.fromList(list[0] as! [Any?])!
    let bearing: Double? = nilOrValue(list[1])
    let accuracy: Double? = nilOrValue(list[2])

    return Location(
      position: position,
      bearing: bearing,
      accuracy: accuracy
    )
  }
  func toList() -> [Any?] {
    return [
      position.toList(),
      bearing,
      accuracy,
    ]
  }
}

/// 地图兴趣点
///
/// Generated class from Pigeon that represents data sent in messages.
struct MapPoi {
  /// 兴趣点的名称
  var name: String
  /// 兴趣点的位置
  var position: Position

  static func fromList(_ list: [Any?]) -> MapPoi? {
    let name = list[0] as! String
    let position = Position.fromList(list[1] as! [Any?])!

    return MapPoi(
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

/// 地图视野
///
/// Generated class from Pigeon that represents data sent in messages.
struct CameraPosition {
  /// 地图视野的位置
  var target: Position? = nil
  /// 地图视野的旋转角度
  var bearing: Double? = nil
  /// 地图视野的倾斜角度
  var tilt: Double? = nil
  /// 地图视野的缩放级别
  var zoom: Double? = nil

  static func fromList(_ list: [Any?]) -> CameraPosition? {
    var target: Position? = nil
    if let targetList: [Any?] = nilOrValue(list[0]) {
      target = Position.fromList(targetList)
    }
    let bearing: Double? = nilOrValue(list[1])
    let tilt: Double? = nilOrValue(list[2])
    let zoom: Double? = nilOrValue(list[3])

    return CameraPosition(
      target: target,
      bearing: bearing,
      tilt: tilt,
      zoom: zoom
    )
  }
  func toList() -> [Any?] {
    return [
      target?.toList(),
      bearing,
      tilt,
      zoom,
    ]
  }
}

/// 标记点配置属性
///
/// Generated class from Pigeon that represents data sent in messages.
struct MarkerOptions {
  /// 标记点的位置
  var position: Position
  /// 标记点的透明度
  var alpha: Double? = nil
  /// 标记点的旋转角度
  var rotation: Double? = nil
  /// 标记点的Z轴显示顺序
  var zIndex: Int64? = nil
  /// 标记点是否支持3D悬浮（Android Only)
  var flat: Bool? = nil
  /// 标记点是否支持拖动
  var draggable: Bool? = nil
  /// 标记点的图标信息
  var icon: Bitmap? = nil
  /// 标记点的锚点
  var anchor: Anchor? = nil

  static func fromList(_ list: [Any?]) -> MarkerOptions? {
    let position = Position.fromList(list[0] as! [Any?])!
    let alpha: Double? = nilOrValue(list[1])
    let rotation: Double? = nilOrValue(list[2])
    let zIndex: Int64? = list[3] is NSNull ? nil : (list[3] is Int64? ? list[3] as! Int64? : Int64(list[3] as! Int32))
    let flat: Bool? = nilOrValue(list[4])
    let draggable: Bool? = nilOrValue(list[5])
    var icon: Bitmap? = nil
    if let iconList: [Any?] = nilOrValue(list[6]) {
      icon = Bitmap.fromList(iconList)
    }
    var anchor: Anchor? = nil
    if let anchorList: [Any?] = nilOrValue(list[7]) {
      anchor = Anchor.fromList(anchorList)
    }

    return MarkerOptions(
      position: position,
      alpha: alpha,
      rotation: rotation,
      zIndex: zIndex,
      flat: flat,
      draggable: draggable,
      icon: icon,
      anchor: anchor
    )
  }
  func toList() -> [Any?] {
    return [
      position.toList(),
      alpha,
      rotation,
      zIndex,
      flat,
      draggable,
      icon?.toList(),
      anchor?.toList(),
    ]
  }
}

/// 折线配置属性
///
/// Generated class from Pigeon that represents data sent in messages.
struct PolylineOptions {
  /// 折线中拐点位置的列表
  var points: [Position?]? = nil

  static func fromList(_ list: [Any?]) -> PolylineOptions? {
    let points: [Position?]? = nilOrValue(list[0])

    return PolylineOptions(
      points: points
    )
  }
  func toList() -> [Any?] {
    return [
      points,
    ]
  }
}

/// 图片信息
///
/// Generated class from Pigeon that represents data sent in messages.
struct Bitmap {
  /// 图片资源路径
  var asset: String? = nil
  /// 图片数据
  var bytes: FlutterStandardTypedData? = nil

  static func fromList(_ list: [Any?]) -> Bitmap? {
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
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol TencentMapSdkApi {
  func initSdk(iosApiKey: String?, agreePrivacy: Bool) throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class TencentMapSdkApiSetup {
  /// The codec used by TencentMapSdkApi.
  /// Sets up an instance of `TencentMapSdkApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: TencentMapSdkApi?) {
    let initSdkChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapSdkApi.initSdk", binaryMessenger: binaryMessenger)
    if let api = api {
      initSdkChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let iosApiKeyArg: String? = nilOrValue(args[0])
        let agreePrivacyArg = args[1] as! Bool
        do {
          try api.initSdk(iosApiKey: iosApiKeyArg, agreePrivacy: agreePrivacyArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      initSdkChannel.setMessageHandler(nil)
    }
  }
}
private class TencentMapApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return Anchor.fromList(self.readValue() as! [Any?])
      case 129:
        return Bitmap.fromList(self.readValue() as! [Any?])
      case 130:
        return CameraPosition.fromList(self.readValue() as! [Any?])
      case 131:
        return Location.fromList(self.readValue() as! [Any?])
      case 132:
        return MarkerOptions.fromList(self.readValue() as! [Any?])
      case 133:
        return PolylineOptions.fromList(self.readValue() as! [Any?])
      case 134:
        return Position.fromList(self.readValue() as! [Any?])
      case 135:
        return Position.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class TencentMapApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? Anchor {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? Bitmap {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? CameraPosition {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? Location {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else if let value = value as? MarkerOptions {
      super.writeByte(132)
      super.writeValue(value.toList())
    } else if let value = value as? PolylineOptions {
      super.writeByte(133)
      super.writeValue(value.toList())
    } else if let value = value as? Position {
      super.writeByte(134)
      super.writeValue(value.toList())
    } else if let value = value as? Position {
      super.writeByte(135)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class TencentMapApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return TencentMapApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return TencentMapApiCodecWriter(data: data)
  }
}

class TencentMapApiCodec: FlutterStandardMessageCodec {
  static let shared = TencentMapApiCodec(readerWriter: TencentMapApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol TencentMapApi {
  func setMapType(type: MapType) throws
  func setCompassEnabled(enabled: Bool) throws
  func setScaleControlsEnabled(enabled: Bool) throws
  func setRotateGesturesEnabled(enabled: Bool) throws
  func setScrollGesturesEnabled(enabled: Bool) throws
  func setZoomGesturesEnabled(enabled: Bool) throws
  func setTiltGesturesEnabled(enabled: Bool) throws
  func setIndoorViewEnabled(enabled: Bool) throws
  func setTrafficEnabled(enabled: Bool) throws
  func setBuildingsEnabled(enabled: Bool) throws
  func setMyLocationButtonEnabled(enabled: Bool) throws
  func setMyLocationEnabled(enabled: Bool) throws
  func setUserLocationType(type: UserLocationType) throws
  func getUserLocation() throws -> Location
  func moveCamera(position: CameraPosition, duration: Int64) throws
  func addMarker(options: MarkerOptions) throws -> String
  func addPolyline(options: PolylineOptions) throws -> String
  func pause() throws
  func resume() throws
  func stop() throws
  func start() throws
  func destroy() throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class TencentMapApiSetup {
  /// The codec used by TencentMapApi.
  static var codec: FlutterStandardMessageCodec { TencentMapApiCodec.shared }
  /// Sets up an instance of `TencentMapApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: TencentMapApi?) {
    let setMapTypeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setMapType", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setMapTypeChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let typeArg = MapType(rawValue: args[0] as! Int)!
        do {
          try api.setMapType(type: typeArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setMapTypeChannel.setMessageHandler(nil)
    }
    let setCompassEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setCompassEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setCompassEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enabledArg = args[0] as! Bool
        do {
          try api.setCompassEnabled(enabled: enabledArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setCompassEnabledChannel.setMessageHandler(nil)
    }
    let setScaleControlsEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setScaleControlsEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setScaleControlsEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enabledArg = args[0] as! Bool
        do {
          try api.setScaleControlsEnabled(enabled: enabledArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setScaleControlsEnabledChannel.setMessageHandler(nil)
    }
    let setRotateGesturesEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setRotateGesturesEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setRotateGesturesEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enabledArg = args[0] as! Bool
        do {
          try api.setRotateGesturesEnabled(enabled: enabledArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setRotateGesturesEnabledChannel.setMessageHandler(nil)
    }
    let setScrollGesturesEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setScrollGesturesEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setScrollGesturesEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enabledArg = args[0] as! Bool
        do {
          try api.setScrollGesturesEnabled(enabled: enabledArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setScrollGesturesEnabledChannel.setMessageHandler(nil)
    }
    let setZoomGesturesEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setZoomGesturesEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setZoomGesturesEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enabledArg = args[0] as! Bool
        do {
          try api.setZoomGesturesEnabled(enabled: enabledArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setZoomGesturesEnabledChannel.setMessageHandler(nil)
    }
    let setTiltGesturesEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setTiltGesturesEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setTiltGesturesEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enabledArg = args[0] as! Bool
        do {
          try api.setTiltGesturesEnabled(enabled: enabledArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setTiltGesturesEnabledChannel.setMessageHandler(nil)
    }
    let setIndoorViewEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setIndoorViewEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setIndoorViewEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enabledArg = args[0] as! Bool
        do {
          try api.setIndoorViewEnabled(enabled: enabledArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setIndoorViewEnabledChannel.setMessageHandler(nil)
    }
    let setTrafficEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setTrafficEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setTrafficEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enabledArg = args[0] as! Bool
        do {
          try api.setTrafficEnabled(enabled: enabledArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setTrafficEnabledChannel.setMessageHandler(nil)
    }
    let setBuildingsEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setBuildingsEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setBuildingsEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enabledArg = args[0] as! Bool
        do {
          try api.setBuildingsEnabled(enabled: enabledArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setBuildingsEnabledChannel.setMessageHandler(nil)
    }
    let setMyLocationButtonEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setMyLocationButtonEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setMyLocationButtonEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enabledArg = args[0] as! Bool
        do {
          try api.setMyLocationButtonEnabled(enabled: enabledArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setMyLocationButtonEnabledChannel.setMessageHandler(nil)
    }
    let setMyLocationEnabledChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setMyLocationEnabled", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setMyLocationEnabledChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let enabledArg = args[0] as! Bool
        do {
          try api.setMyLocationEnabled(enabled: enabledArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setMyLocationEnabledChannel.setMessageHandler(nil)
    }
    let setUserLocationTypeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.setUserLocationType", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setUserLocationTypeChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let typeArg = UserLocationType(rawValue: args[0] as! Int)!
        do {
          try api.setUserLocationType(type: typeArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setUserLocationTypeChannel.setMessageHandler(nil)
    }
    let getUserLocationChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.getUserLocation", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getUserLocationChannel.setMessageHandler { _, reply in
        do {
          let result = try api.getUserLocation()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getUserLocationChannel.setMessageHandler(nil)
    }
    let moveCameraChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.moveCamera", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      moveCameraChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let positionArg = args[0] as! CameraPosition
        let durationArg = args[1] is Int64 ? args[1] as! Int64 : Int64(args[1] as! Int32)
        do {
          try api.moveCamera(position: positionArg, duration: durationArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      moveCameraChannel.setMessageHandler(nil)
    }
    let addMarkerChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.addMarker", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      addMarkerChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let optionsArg = args[0] as! MarkerOptions
        do {
          let result = try api.addMarker(options: optionsArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      addMarkerChannel.setMessageHandler(nil)
    }
    let addPolylineChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.addPolyline", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      addPolylineChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let optionsArg = args[0] as! PolylineOptions
        do {
          let result = try api.addPolyline(options: optionsArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      addPolylineChannel.setMessageHandler(nil)
    }
    let pauseChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.pause", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      pauseChannel.setMessageHandler { _, reply in
        do {
          try api.pause()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      pauseChannel.setMessageHandler(nil)
    }
    let resumeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.resume", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      resumeChannel.setMessageHandler { _, reply in
        do {
          try api.resume()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      resumeChannel.setMessageHandler(nil)
    }
    let stopChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.stop", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      stopChannel.setMessageHandler { _, reply in
        do {
          try api.stop()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      stopChannel.setMessageHandler(nil)
    }
    let startChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.start", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      startChannel.setMessageHandler { _, reply in
        do {
          try api.start()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      startChannel.setMessageHandler(nil)
    }
    let destroyChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapApi.destroy", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      destroyChannel.setMessageHandler { _, reply in
        do {
          try api.destroy()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      destroyChannel.setMessageHandler(nil)
    }
  }
}
private class MarkerApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return Bitmap.fromList(self.readValue() as! [Any?])
      case 129:
        return Position.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class MarkerApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? Bitmap {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? Position {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class MarkerApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return MarkerApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return MarkerApiCodecWriter(data: data)
  }
}

class MarkerApiCodec: FlutterStandardMessageCodec {
  static let shared = MarkerApiCodec(readerWriter: MarkerApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol MarkerApi {
  /// 移除标记点
  func remove(id: String) throws
  /// 更新标记点的旋转角度
  func setRotation(id: String, rotation: Double) throws
  /// 更新标记点的位置
  func setPosition(id: String, position: Position) throws
  /// 更新标记点的锚点
  func setAnchor(id: String, x: Double, y: Double) throws
  /// 更新标记点的Z轴显示顺序
  func setZIndex(id: String, zIndex: Int64) throws
  /// 更新标记点的透明度
  func setAlpha(id: String, alpha: Double) throws
  /// 更新标记点的图标
  func setIcon(id: String, icon: Bitmap) throws
  /// 更新标记点的是否可拖拽属性值
  func setDraggable(id: String, draggable: Bool) throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class MarkerApiSetup {
  /// The codec used by MarkerApi.
  static var codec: FlutterStandardMessageCodec { MarkerApiCodec.shared }
  /// Sets up an instance of `MarkerApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: MarkerApi?) {
    /// 移除标记点
    let removeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.MarkerApi.remove", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      removeChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        do {
          try api.remove(id: idArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      removeChannel.setMessageHandler(nil)
    }
    /// 更新标记点的旋转角度
    let setRotationChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.MarkerApi.setRotation", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setRotationChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let rotationArg = args[1] as! Double
        do {
          try api.setRotation(id: idArg, rotation: rotationArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setRotationChannel.setMessageHandler(nil)
    }
    /// 更新标记点的位置
    let setPositionChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.MarkerApi.setPosition", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setPositionChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let positionArg = args[1] as! Position
        do {
          try api.setPosition(id: idArg, position: positionArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setPositionChannel.setMessageHandler(nil)
    }
    /// 更新标记点的锚点
    let setAnchorChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.MarkerApi.setAnchor", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setAnchorChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let xArg = args[1] as! Double
        let yArg = args[2] as! Double
        do {
          try api.setAnchor(id: idArg, x: xArg, y: yArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setAnchorChannel.setMessageHandler(nil)
    }
    /// 更新标记点的Z轴显示顺序
    let setZIndexChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.MarkerApi.setZIndex", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setZIndexChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let zIndexArg = args[1] is Int64 ? args[1] as! Int64 : Int64(args[1] as! Int32)
        do {
          try api.setZIndex(id: idArg, zIndex: zIndexArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setZIndexChannel.setMessageHandler(nil)
    }
    /// 更新标记点的透明度
    let setAlphaChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.MarkerApi.setAlpha", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setAlphaChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let alphaArg = args[1] as! Double
        do {
          try api.setAlpha(id: idArg, alpha: alphaArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setAlphaChannel.setMessageHandler(nil)
    }
    /// 更新标记点的图标
    let setIconChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.MarkerApi.setIcon", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setIconChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let iconArg = args[1] as! Bitmap
        do {
          try api.setIcon(id: idArg, icon: iconArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setIconChannel.setMessageHandler(nil)
    }
    /// 更新标记点的是否可拖拽属性值
    let setDraggableChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.MarkerApi.setDraggable", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setDraggableChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let draggableArg = args[1] as! Bool
        do {
          try api.setDraggable(id: idArg, draggable: draggableArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setDraggableChannel.setMessageHandler(nil)
    }
  }
}
private class TencentMapHandlerCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return CameraPosition.fromList(self.readValue() as! [Any?])
      case 129:
        return Location.fromList(self.readValue() as! [Any?])
      case 130:
        return MapPoi.fromList(self.readValue() as! [Any?])
      case 131:
        return Position.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class TencentMapHandlerCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? CameraPosition {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? Location {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? MapPoi {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? Position {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class TencentMapHandlerCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return TencentMapHandlerCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return TencentMapHandlerCodecWriter(data: data)
  }
}

class TencentMapHandlerCodec: FlutterStandardMessageCodec {
  static let shared = TencentMapHandlerCodec(readerWriter: TencentMapHandlerCodecReaderWriter())
}

/// Generated class from Pigeon that represents Flutter messages that can be called from Swift.
class TencentMapHandler {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger){
    self.binaryMessenger = binaryMessenger
  }
  var codec: FlutterStandardMessageCodec {
    return TencentMapHandlerCodec.shared
  }
  /// 当点击地图上任意地点时会触发该回调，方法会传入点击的坐标点，事件可能被上层覆盖物拦截
  func onPress(position positionArg: Position, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapHandler.onPress", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([positionArg] as [Any?]) { _ in
      completion()
    }
  }
  /// 当地图上任意地点进行长按点击时会触发该回调，事件可能被上层覆盖物拦截（Android Only）
  func onLongPress(position positionArg: Position, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapHandler.onLongPress", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([positionArg] as [Any?]) { _ in
      completion()
    }
  }
  /// 当点击地图上任意的POI时调用，方法会传入点击的POI信息
  func onTapPoi(poi poiArg: MapPoi, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapHandler.onTapPoi", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([poiArg] as [Any?]) { _ in
      completion()
    }
  }
  /// 当地图视野即将改变时会触发该回调（iOS Only）
  func onCameraMoveStart(cameraPosition cameraPositionArg: CameraPosition, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapHandler.onCameraMoveStart", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([cameraPositionArg] as [Any?]) { _ in
      completion()
    }
  }
  /// 当地图视野发生变化时触发该回调。视野持续变化时本回调可能会被频繁多次调用, 请不要做耗时或复杂的事情
  func onCameraMove(cameraPosition cameraPositionArg: CameraPosition, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapHandler.onCameraMove", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([cameraPositionArg] as [Any?]) { _ in
      completion()
    }
  }
  /// 当地图视野变化完成时触发该回调，需注意当前地图状态有可能并不是稳定状态
  func onCameraMoveEnd(cameraPosition cameraPositionArg: CameraPosition, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapHandler.onCameraMoveEnd", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([cameraPositionArg] as [Any?]) { _ in
      completion()
    }
  }
  /// 当点击点标记时触发该回调（Android Only）
  func onTapMarker(markerId markerIdArg: String, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapHandler.onTapMarker", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([markerIdArg] as [Any?]) { _ in
      completion()
    }
  }
  /// 当开始拖动点标记时触发该回调（Android Only）
  func onMarkerDragStart(markerId markerIdArg: String, position positionArg: Position, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapHandler.onMarkerDragStart", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([markerIdArg, positionArg] as [Any?]) { _ in
      completion()
    }
  }
  /// 当拖动点标记时触发该回调（Android Only）
  func onMarkerDrag(markerId markerIdArg: String, position positionArg: Position, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapHandler.onMarkerDrag", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([markerIdArg, positionArg] as [Any?]) { _ in
      completion()
    }
  }
  /// 当拖动点标记完成时触发该回调（Android Only）
  func onMarkerDragEnd(markerId markerIdArg: String, position positionArg: Position, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapHandler.onMarkerDragEnd", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([markerIdArg, positionArg] as [Any?]) { _ in
      completion()
    }
  }
  /// 当前位置改变时触发该回调（Android Only）
  func onLocation(location locationArg: Location, completion: @escaping () -> Void) {
    let channel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.tencent_map.TencentMapHandler.onLocation", binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([locationArg] as [Any?]) { _ in
      completion()
    }
  }
}
