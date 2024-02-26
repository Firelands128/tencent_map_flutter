import Flutter
import QMapKit

class TencentMapController: NSObject {
  let api: _TencentMapApi
  let channel: FlutterMethodChannel

  init(viewId: Int64, registrar: FlutterPluginRegistrar, api: _TencentMapApi) {
    self.api = api
    channel = FlutterMethodChannel(
      name: "plugins.flutter.dev/tencent_map_flutter_\(viewId)",
      binaryMessenger: registrar.messenger(),
      codec: TencentMapCodec.shared
    )
    super.init()
    channel.setMethodCallHandler { [weak self] (call, result) in
      self?.onMethodCall(call: call, result: result)
    }
  }

  func onMethodCall(call: FlutterMethodCall, result: FlutterResult) {
    if(call.method == "updateMapConfig") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let config = arguments["config"] as! MapConfig
      api.updateMapConfig(config: config)
      result(nil)
    }
    else if(call.method == "getUserLocation") {
      result(api.getUserLocation())
    }
    else if(call.method == "moveCamera") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let position = arguments["position"] as! CameraPosition
      let duration = arguments["duration"] as! Int64
      api.moveCamera(position: position, duration: duration)
      result(nil)
    }
    else if(call.method == "moveCameraToRegion") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let region = arguments["region"] as! Region
      let padding = arguments["padding"] as! EdgePadding
      let duration = arguments["duration"] as! Int64
      api.moveCameraToRegion(region: region, padding: padding, duration: duration)
      result(nil)
    }
    else if(call.method == "moveCameraToRegionWithPosition") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let positions = (arguments["positions"] as! [Any?]).map({ position in position as! Position })
      let padding = arguments["padding"] as! EdgePadding
      let duration = arguments["duration"] as! Int64
      api.moveCameraToRegionWithPosition(positions: positions, padding: padding, duration: duration)
      result(nil)
    }
    else if(call.method == "setRestrictRegion") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let region = arguments["region"] as! Region
      let mode = RestrictRegionMode(rawValue: arguments["mode"] as! Int)!
      api.setRestrictRegion(region: region, mode: mode)
      result(nil)
    }
    else if(call.method == "removeRestrictRegion") {
      api.removeRestrictRegion()
      result(nil)
    }
    else if(call.method == "addMarker") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let marker = arguments["marker"] as! Marker
      api.addMarker(marker: marker)
      result(nil)
    }
    else if(call.method == "removeMarker") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let id = arguments["id"] as! String
      api.removeMarker(id: id)
      result(nil)
    }
    else if(call.method == "updateMarker") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let markerId = arguments["markerId"] as! String
      let options = arguments["options"] as! MarkerUpdateOptions
      api.updateMarker(markerId: markerId, options: options)
      result(nil)
    }
    else if(call.method == "start") {
      api.start()
      result(nil)
    }
    else if(call.method == "pause") {
      api.pause()
      result(nil)
    }
    else if(call.method == "resume") {
      api.resume()
      result(nil)
    }
    else if(call.method == "stop") {
      api.stop()
      result(nil)
    }
    else if(call.method == "destroy") {
      api.destroy()
      result(nil)
    }
  }

  /// 当地图比例尺变化时触发该回调，方法会传入单位长度信息，单位为米
  func onScaleViewChanged(scale: Double) {
    channel.invokeMethod("onScaleViewChanged", arguments: [
      "scale": scale,
    ] as [String: Any])
  }

  /// 当点击地图上任意地点时会触发该回调，方法会传入点击的坐标点，事件可能被上层覆盖物拦截
  func onPress(position: Position) {
    channel.invokeMethod("onPress", arguments: [
      "position": position,
    ] as [String: Any])
  }

  /// 当地图上任意地点进行长按点击时会触发该回调，事件可能被上层覆盖物拦截（Android Only）
  func onLongPress(position: Position) {
    channel.invokeMethod("onLongPress", arguments: [
      "position": position,
    ] as [String: Any])
  }

  /// 当点击地图上任意的POI时调用，方法会传入点击的POI信息
  func onTapPoi(poi: Poi) {
    channel.invokeMethod("onTapPoi", arguments: [
      "poi": poi,
    ] as [String: Any])
  }

  /// 当地图视野即将改变时会触发该回调（iOS Only）
  func onCameraMoveStart(cameraPosition: CameraPosition) {
    channel.invokeMethod("onCameraMoveStart", arguments: [
      "position": cameraPosition,
    ] as [String: Any])
  }

  /// 当地图视野发生变化时触发该回调。视野持续变化时本回调可能会被频繁多次调用, 请不要做耗时或复杂的事情
  func onCameraMove(cameraPosition: CameraPosition) {
    channel.invokeMethod("onCameraMove", arguments: [
      "position": cameraPosition,
    ] as [String: Any])
  }

  /// 当地图视野变化完成时触发该回调，需注意当前地图状态有可能并不是稳定状态
  func onCameraMoveEnd(cameraPosition: CameraPosition) {
    channel.invokeMethod("onCameraMoveEnd", arguments: [
      "position": cameraPosition,
    ] as [String: Any])
  }

  /// 当点击点标记时触发该回调（Android Only）
  func onTapMarker(markerId: String) {
    channel.invokeMethod("onTapMarker", arguments: [
      "markerId": markerId,
    ] as [String: Any])
  }

  /// 当开始拖动点标记时触发该回调（Android Only）
  func onMarkerDragStart(markerId: String, position: Position) {
    channel.invokeMethod("onMarkerDragStart", arguments: [
      "markerId": markerId,
      "position": position,
    ] as [String: Any])
  }

  /// 当拖动点标记时触发该回调（Android Only）
  func onMarkerDrag(markerId: String, position: Position) {
    channel.invokeMethod("onMarkerDrag", arguments: [
      "markerId": markerId,
      "position": position,
    ] as [String: Any])
  }

  /// 当拖动点标记完成时触发该回调（Android Only）
  func onMarkerDragEnd(markerId: String, position: Position) {
    channel.invokeMethod("onMarkerDragEnd", arguments: [
      "markerId": markerId,
      "position": position,
    ] as [String: Any])
  }

  /// 当前位置改变时触发该回调（Android Only）
  func onLocation(location: Location) {
    channel.invokeMethod("onLocation", arguments: [
      "location": location,
    ] as [String: Any])
  }

  /// 当点击地图上的定位标会触发该回调
  func onUserLocationClick(position: Position) {
    channel.invokeMethod("onUserLocationClick", arguments: [
      "position": position,
    ] as [String: Any])
  }

  private class TencentMapCodecReader: FlutterStandardReader {
    override func readValue(ofType type: UInt8) -> Any? {
      switch type {
      case 128:
        return MapType(rawValue: self.readValue() as! Int)
      case 129:
        return RestrictRegionMode(rawValue: self.readValue() as! Int)
      case 130:
        return UIControlAnchor(rawValue: self.readValue() as! Int)
      case 131:
        return UserLocationType(rawValue: self.readValue() as! Int)
      case 132:
        return Anchor.fromList(self.readValue() as! [Any?])
      case 133:
        return Bitmap.fromList(self.readValue() as! [Any?])
      case 134:
        return CameraPosition.fromList(self.readValue() as! [Any?])
      case 135:
        return EdgePadding.fromList(self.readValue() as! [Any?])
      case 136:
        return Location.fromList(self.readValue() as! [Any?])
      case 137:
        return MapConfig.fromList(self.readValue() as! [Any?])
      case 138:
        return Marker.fromList(self.readValue() as! [Any?])
      case 139:
        return MarkerUpdateOptions.fromList(self.readValue() as! [Any?])
      case 140:
        return Poi.fromList(self.readValue() as! [Any?])
      case 141:
        return Position.fromList(self.readValue() as! [Any?])
      case 142:
        return Region.fromList(self.readValue() as! [Any?])
      case 143:
        return UIControlOffset.fromList(self.readValue() as! [Any?])
      case 144:
        return UIControlPosition.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
      }
    }
  }

  private class TencentMapCodecWriter: FlutterStandardWriter {
    override func writeValue(_ value: Any) {
      if let value = value as? MapType {
        super.writeValue(128)
        super.writeValue(value.rawValue)
      }
      else if let value = value as? RestrictRegionMode {
        super.writeValue(129)
        super.writeValue(value.rawValue)
      }
      else if let value = value as? UIControlAnchor {
        super.writeValue(130)
        super.writeValue(value.rawValue)
      }
      else if let value = value as? UserLocationType {
        super.writeValue(131)
        super.writeValue(value.rawValue)
      }
      else if let value = value as? Anchor {
        super.writeByte(132)
        super.writeValue(value.toList())
      } else if let value = value as? Bitmap {
        super.writeByte(133)
        super.writeValue(value.toList())
      } else if let value = value as? CameraPosition {
        super.writeByte(134)
        super.writeValue(value.toList())
      } else if let value = value as? EdgePadding {
        super.writeByte(135)
        super.writeValue(value.toList())
      } else if let value = value as? Location {
        super.writeByte(136)
        super.writeValue(value.toList())
      } else if let value = value as? MapConfig {
        super.writeByte(137)
        super.writeValue(value.toList())
      } else if let value = value as? Marker {
        super.writeByte(138)
        super.writeValue(value.toList())
      } else if let value = value as? MarkerUpdateOptions {
        super.writeByte(139)
        super.writeValue(value.toList())
      } else if let value = value as? Poi {
        super.writeByte(140)
        super.writeValue(value.toList())
      } else if let value = value as? Position {
        super.writeByte(141)
        super.writeValue(value.toList())
      } else if let value = value as? Region {
        super.writeByte(142)
        super.writeValue(value.toList())
      } else if let value = value as? UIControlOffset {
        super.writeByte(143)
        super.writeValue(value.toList())
      } else if let value = value as? UIControlPosition {
        super.writeByte(144)
        super.writeValue(value.toList())
      } else {
        super.writeValue(value)
      }
    }
  }

  private class TencentMapCodecReaderWriter: FlutterStandardReaderWriter {
    override func reader(with data: Data) -> FlutterStandardReader {
      return TencentMapCodecReader(data: data)
    }

    override func writer(with data: NSMutableData) -> FlutterStandardWriter {
      return TencentMapCodecWriter(data: data)
    }
  }

  private class TencentMapCodec: FlutterStandardMethodCodec {
    static let shared = TencentMapCodec(readerWriter: TencentMapCodecReaderWriter())
  }
}
