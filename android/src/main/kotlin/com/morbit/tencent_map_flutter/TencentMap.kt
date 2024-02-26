package com.morbit.tencent_map_flutter

import android.content.Context
import com.tencent.tencentmap.mapsdk.maps.BaseMapView
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.TextureMapView
import com.tencent.tencentmap.mapsdk.maps.model.Marker
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.platform.PlatformView

class TencentMap(
  context: Context,
  viewId: Int,
  val binding: FlutterPlugin.FlutterPluginBinding,
  args: HashMap<*, *>
) : PlatformView {
  private val mapView: BaseMapView
  private val locationSource = TencentLocationSource(context)
  val controller: TencentMapController
  val markers = mutableMapOf<String, Marker>()
  val tencentMapMarkerIdToDartMarkerId = mutableMapOf<String, String>()

  override fun getView(): BaseMapView {
    return mapView
  }

  override fun dispose() {}

  init {
    mapView = if (args["texture"] as Boolean) {
      TextureMapView(context)
    } else {
      MapView(context)
    }
    controller = TencentMapController(viewId, binding, TencentMapApi(this));
    mapView.onResume()
    mapView.map.setLocationSource(locationSource)
    setTencentMapListener()
  }

  private fun setTencentMapListener() {
    val mapListener = TencentMapListener(this)
    mapView.map.setOnScaleViewChangedListener(mapListener)
    mapView.map.setOnMapClickListener(mapListener)
    mapView.map.setOnMapLongClickListener(mapListener)
    mapView.map.setOnMapPoiClickListener(mapListener)
    mapView.map.setOnMyLocationChangeListener(mapListener)
    mapView.map.setMyLocationClickListener(mapListener)
    mapView.map.setOnCameraChangeListener(mapListener)
    mapView.map.setOnMarkerClickListener(mapListener)
    mapView.map.setOnMarkerDragListener(mapListener)
  }
}
