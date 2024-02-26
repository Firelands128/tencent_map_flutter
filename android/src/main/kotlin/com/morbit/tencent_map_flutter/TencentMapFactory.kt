package com.morbit.tencent_map_flutter

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class TencentMapFactory(private val binding: FlutterPlugin.FlutterPluginBinding) :
  PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
    return TencentMap(context!!, viewId, binding, args as HashMap<*, *>)
  }
}
