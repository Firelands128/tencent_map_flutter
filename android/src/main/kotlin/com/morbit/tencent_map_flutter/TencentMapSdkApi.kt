package com.morbit.tencent_map_flutter

import com.tencent.map.geolocation.TencentLocationManager
import com.tencent.tencentmap.mapsdk.maps.TencentMapInitializer
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class TencentMapSdkApi {
  companion object {
    fun setup(binding: FlutterPluginBinding) {
      val initializerChannel = MethodChannel(binding.binaryMessenger, "plugins.flutter.dev/tencent_map_flutter_initializer")
      initializerChannel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
        if (call.method == "agreePrivacy") {
          val agree = call.argument<Boolean>("agree")!!
          agreePrivacy(agree)
          result.success(null)
        }
      }
    }

    private fun agreePrivacy(agreePrivacy: Boolean) {
      TencentMapInitializer.setAgreePrivacy(agreePrivacy)
      TencentLocationManager.setUserAgreePrivacy(agreePrivacy)
    }
  }
}
