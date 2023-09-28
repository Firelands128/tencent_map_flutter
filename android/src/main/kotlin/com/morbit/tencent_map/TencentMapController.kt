package com.morbit.tencent_map

import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.common.StandardMethodCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

class TencentMapController(viewId: Int, binding: FlutterPluginBinding, private val api: TencentMapApi) {
  private val channel: MethodChannel

  init {
    channel = MethodChannel(
      binding.binaryMessenger,
      "plugins.flutter.dev/tencent_map_$viewId",
      StandardMethodCodec(TencentMapApiCodec),
    )
    channel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
      this.onMethodCall(call, result)
    }
  }

  private fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "updateMapConfig" -> {
        val config = call.argument<MapConfig>("config")!!
        api.updateMapConfig(config)
        result.success(null)
      }

      "getUserLocation" -> {
        result.success(api.getUserLocation())
      }

      "moveCamera" -> {
        val position = call.argument<CameraPosition>("position")!!
        val duration = call.argument<Long>("duration")!!
        api.moveCamera(position, duration)
        result.success(null)
      }

      "moveCameraToRegion" -> {
        val region = call.argument<Region>("region")!!
        val padding = call.argument<EdgePadding>("padding")!!
        val duration = call.argument<Long>("duration")!!
        api.moveCameraToRegion(region, padding, duration)
        result.success(null)
      }

      "moveCameraToRegionWithPosition" -> {
        val positions = call.argument<List<Position?>>("positions")!!
        val padding = call.argument<EdgePadding>("padding")!!
        val duration = call.argument<Long>("duration")!!
        api.moveCameraToRegionWithPosition(positions, padding, duration)
        result.success(null)
      }

      "setRestrictRegion" -> {
        val region = call.argument<Region>("region")!!
        val mode = RestrictRegionMode.ofRaw(call.argument<Int>("mode")!!)!!
        api.setRestrictRegion(region, mode)
        result.success(null)
      }

      "addMarker" -> {
        val marker = call.argument<Marker>("marker")!!
        api.addMarker(marker)
        result.success(null)
      }

      "removeMarker" -> {
        val id = call.argument<String>("id")!!
        api.removeMarker(id)
        result.success(null)
      }

      "updateMarker" -> {
        val id = call.argument<String>("markerId")!!
        val options = call.argument<MarkerUpdateOptions>("options")!!
        api.updateMarker(id, options)
        result.success(null)
      }

      "start" -> {
        api.start()
        result.success(null)
      }

      "pause" -> {
        api.pause()
        result.success(null)
      }

      "resume" -> {
        api.resume()
        result.success(null)
      }

      "stop" -> {
        api.stop()
        result.success(null)
      }

      "destroy" -> {
        api.destroy()
        result.success(null)
      }
    }
  }

  /// 当地图比例尺变化时触发该回调，方法会传入单位长度信息，单位为米
  fun onScaleViewChanged(scale: Double) {
    channel.invokeMethod(
      "onScaleViewChanged",
      mapOf(
        "scale" to scale,
      ),
    )
  }

  /// 当点击地图上任意地点时会触发该回调，方法会传入点击的坐标点，事件可能被上层覆盖物拦截
  fun onPress(position: Position) {
    channel.invokeMethod(
      "onPress",
      mapOf(
        "position" to position,
      ),
    )
  }

  /// 当地图上任意地点进行长按点击时会触发该回调，事件可能被上层覆盖物拦截（Android Only）
  fun onLongPress(position: Position) {
    channel.invokeMethod(
      "onLongPress",
      mapOf(
        "position" to position,
      ),
    )
  }

  /// 当点击地图上任意的POI时调用，方法会传入点击的POI信息
  fun onTapPoi(poi: Poi) {
    channel.invokeMethod(
      "onTapPoi",
      mapOf(
        "poi" to poi,
      ),
    )
  }

  /// 当地图视野即将改变时会触发该回调（iOS Only）
  fun onCameraMoveStart(cameraPosition: CameraPosition) {
    channel.invokeMethod(
      "onCameraMoveStart",
      mapOf(
        "position" to cameraPosition,
      ),
    )
  }

  /// 当地图视野发生变化时触发该回调。视野持续变化时本回调可能会被频繁多次调用, 请不要做耗时或复杂的事情
  fun onCameraMove(cameraPosition: CameraPosition) {
    channel.invokeMethod(
      "onCameraMove",
      mapOf(
        "position" to cameraPosition,
      ),
    )
  }

  /// 当地图视野变化完成时触发该回调，需注意当前地图状态有可能并不是稳定状态
  fun onCameraMoveEnd(cameraPosition: CameraPosition) {
    channel.invokeMethod(
      "onCameraMoveEnd",
      mapOf(
        "position" to cameraPosition,
      ),
    )
  }

  /// 当点击点标记时触发该回调（Android Only）
  fun onTapMarker(markerId: String) {
    channel.invokeMethod(
      "onTapMarker",
      mapOf(
        "markerId" to markerId,
      ),
    )
  }

  /// 当开始拖动点标记时触发该回调（Android Only）
  fun onMarkerDragStart(markerId: String, position: Position) {
    channel.invokeMethod(
      "onMarkerDragStart",
      mapOf(
        "markerId" to markerId,
        "position" to position,
      ),
    )
  }

  /// 当拖动点标记时触发该回调（Android Only）
  fun onMarkerDrag(markerId: String, position: Position) {
    channel.invokeMethod(
      "onMarkerDrag",
      mapOf(
        "markerId" to markerId,
        "position" to position,
      ),
    )
  }

  /// 当拖动点标记完成时触发该回调（Android Only）
  fun onMarkerDragEnd(markerId: String, position: Position) {
    channel.invokeMethod(
      "onMarkerDragEnd",
      mapOf(
        "markerId" to markerId,
        "position" to position,
      ),
    )
  }

  /// 当前位置改变时触发该回调（Android Only）
  fun onLocation(location: Location) {
    channel.invokeMethod(
      "onLocation",
      mapOf(
        "location" to location,
      ),
    )
  }

  /// 当点击地图上的定位标会触发该回调
  fun onUserLocationClick(position: Position) {
    channel.invokeMethod(
      "onUserLocationClick",
      mapOf(
        "position" to position,
      ),
    )
  }
}

private object TencentMapApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? Int)?.let {
          MapType.ofRaw(it)
        }
      }

      129.toByte() -> {
        return (readValue(buffer) as? Int)?.let {
          RestrictRegionMode.ofRaw(it)
        }
      }

      130.toByte() -> {
        return (readValue(buffer) as? Int)?.let {
          UIControlAnchor.ofRaw(it)
        }
      }

      131.toByte() -> {
        return (readValue(buffer) as? Int)?.let {
          UserLocationType.ofRaw(it)
        }
      }

      132.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          Anchor.fromList(it)
        }
      }

      133.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          Bitmap.fromList(it)
        }
      }

      134.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          CameraPosition.fromList(it)
        }
      }

      135.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          EdgePadding.fromList(it)
        }
      }

      136.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          Location.fromList(it)
        }
      }

      137.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MapConfig.fromList(it)
        }
      }

      138.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          Marker.fromList(it)
        }
      }

      139.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MarkerUpdateOptions.fromList(it)
        }
      }

      140.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          Poi.fromList(it)
        }
      }

      141.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          Position.fromList(it)
        }
      }

      142.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          Region.fromList(it)
        }
      }

      143.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          UIControlOffset.fromList(it)
        }
      }

      144.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          UIControlPosition.fromList(it)
        }
      }

      else -> super.readValueOfType(type, buffer)
    }
  }

  override fun writeValue(stream: ByteArrayOutputStream, value: Any?) {
    when (value) {
      is MapType -> {
        stream.write(128)
        writeValue(stream, value.raw)
      }

      is RestrictRegionMode -> {
        stream.write(129)
        writeValue(stream, value.raw)
      }

      is UIControlAnchor -> {
        stream.write(130)
        writeValue(stream, value.raw)
      }

      is UserLocationType -> {
        stream.write(131)
        writeValue(stream, value.raw)
      }

      is Anchor -> {
        stream.write(132)
        writeValue(stream, value.toList())
      }

      is Bitmap -> {
        stream.write(133)
        writeValue(stream, value.toList())
      }

      is CameraPosition -> {
        stream.write(134)
        writeValue(stream, value.toList())
      }

      is EdgePadding -> {
        stream.write(135)
        writeValue(stream, value.toList())
      }

      is Location -> {
        stream.write(136)
        writeValue(stream, value.toList())
      }

      is MapConfig -> {
        stream.write(137)
        writeValue(stream, value.toList())
      }

      is Marker -> {
        stream.write(138)
        writeValue(stream, value.toList())
      }

      is MarkerUpdateOptions -> {
        stream.write(139)
        writeValue(stream, value.toList())
      }

      is Poi -> {
        stream.write(140)
        writeValue(stream, value.toList())
      }

      is Position -> {
        stream.write(141)
        writeValue(stream, value.toList())
      }

      is Region -> {
        stream.write(142)
        writeValue(stream, value.toList())
      }

      is UIControlOffset -> {
        stream.write(143)
        writeValue(stream, value.toList())
      }

      is UIControlPosition -> {
        stream.write(144)
        writeValue(stream, value.toList())
      }

      else -> super.writeValue(stream, value)
    }
  }
}