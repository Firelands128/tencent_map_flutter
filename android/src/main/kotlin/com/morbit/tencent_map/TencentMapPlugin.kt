package com.morbit.tencent_map

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin

class TencentMapPlugin : FlutterPlugin {
  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    binding.platformViewRegistry.registerViewFactory("tencent_map", TencentMapFactory(binding))
    TencentMapSdkApi.setup(binding)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}
}
