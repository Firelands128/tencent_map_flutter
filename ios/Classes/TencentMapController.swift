import Flutter
import QMapKit

class TencentMapController: NSObject {
  let api: _TencentMapApi
  let channel: FlutterMethodChannel

  init(viewId: Int64, registrar: FlutterPluginRegistrar, api: _TencentMapApi) {
    self.api = api
    channel = FlutterMethodChannel(
      name: "plugins.flutter.dev/tencent_map_\(viewId)",
      binaryMessenger: registrar.messenger(),
      codec: TencentMapCodec.shared
    )
  }

  func setup() {
    channel.setMethodCallHandler({ (call: FlutterMethodCall, result: FlutterResult) -> Void in
      self.onMethodCall(call: call, result: result)
    })
  }

  func onMethodCall(call: FlutterMethodCall, result: FlutterResult) {
    if(call.method == "setMapType") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let type = MapType(rawValue: arguments["type"] as! Int)!
      api.setMapType(type: type)
      result(nil)
    }
    else if(call.method == "setMapStyle") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let index = arguments["index"] as! Int64
      api.setMapStyle(index: index)
      result(nil)
    }
    else if(call.method == "setLogoScale") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let scale = arguments["scale"] as! Double
      api.setLogoScale(scale: scale)
      result(nil)
    }
    else if(call.method == "setLogoPosition") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let position = arguments["position"] as! UIControlPosition
      api.setLogoPosition(position: position)
      result(nil)
    }
    else if(call.method == "setScalePosition") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let position = arguments["position"] as! UIControlPosition
      api.setScalePosition(position: position)
      result(nil)
    }
    else if(call.method == "setCompassOffset") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let offset = arguments["offset"] as! UIControlOffset
      api.setCompassOffset(offset: offset)
      result(nil)
    }
    else if(call.method == "setCompassEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setCompassEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setScaleEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setScaleEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setScaleFadeEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setScaleFadeEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setRotateGesturesEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setRotateGesturesEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setScrollGesturesEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setScrollGesturesEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setZoomGesturesEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setZoomGesturesEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setSkewGesturesEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setSkewGesturesEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setIndoorViewEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setIndoorViewEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setIndoorPickerEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setIndoorPickerEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setTrafficEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setTrafficEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setBuildingsEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setBuildingsEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setBuildings3dEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setBuildings3dEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setMyLocationEnabled") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let enabled = arguments["enabled"] as! Bool
      api.setMyLocationEnabled(enabled: enabled)
      result(nil)
    }
    else if(call.method == "setUserLocationType") {
      let arguments = call.arguments as! Dictionary<String, AnyObject>
      let type = UserLocationType(rawValue: arguments["type"] as! Int)!
      api.setUserLocationType(type: type)
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
  func onTapPoi(poi: MapPoi) {
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
        return Anchor.fromList(self.readValue() as! [Any?])
      case 129:
        return Bitmap.fromList(self.readValue() as! [Any?])
      case 130:
        return CameraPosition.fromList(self.readValue() as! [Any?])
      case 131:
        return EdgePadding.fromList(self.readValue() as! [Any?])
      case 132:
        return Location.fromList(self.readValue() as! [Any?])
      case 133:
        return Marker.fromList(self.readValue() as! [Any?])
      case 134:
        return MarkerUpdateOptions.fromList(self.readValue() as! [Any?])
			case 135:
				return MapPoi.fromList(self.readValue() as! [Any?])
      case 136:
        return Position.fromList(self.readValue() as! [Any?])
      case 137:
        return Region.fromList(self.readValue() as! [Any?])
      case 138:
        return UIControlOffset.fromList(self.readValue() as! [Any?])
      case 139:
        return UIControlPosition.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
      }
    }
  }

  private class TencentMapCodecWriter: FlutterStandardWriter {
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
      } else if let value = value as? EdgePadding {
        super.writeByte(131)
        super.writeValue(value.toList())
      } else if let value = value as? Location {
        super.writeByte(132)
        super.writeValue(value.toList())
      } else if let value = value as? Marker {
        super.writeByte(133)
        super.writeValue(value.toList())
      } else if let value = value as? MarkerUpdateOptions {
        super.writeByte(134)
        super.writeValue(value.toList())
			} else if let value = value as? MapPoi {
				super.writeByte(135)
				super.writeValue(value.toList())
      } else if let value = value as? Position {
        super.writeByte(136)
        super.writeValue(value.toList())
      } else if let value = value as? Region {
        super.writeByte(137)
        super.writeValue(value.toList())
      } else if let value = value as? UIControlOffset {
        super.writeByte(138)
        super.writeValue(value.toList())
      } else if let value = value as? UIControlPosition {
        super.writeByte(139)
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
