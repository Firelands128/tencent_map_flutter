package com.morbit.tencent_map

import android.content.Context
import com.tencent.tencentmap.mapsdk.maps.BaseMapView
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.TextureMapView
import com.tencent.tencentmap.mapsdk.maps.model.Marker
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.platform.PlatformView

class TencentMap(val binding: FlutterPlugin.FlutterPluginBinding, context: Context, args: HashMap<*, *>) :
  PlatformView {
  val mapHandler = TencentMapHandler(binding.binaryMessenger)
  private val mapView: BaseMapView
  private val locationSource = TencentLocationSource(context, mapHandler)
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
    val mapApi = _TencentMapApi(this)
    TencentMapApi.setUp(binding.binaryMessenger, mapApi)
    mapView.onResume()
    mapView.map.setLocationSource(locationSource)
    setTencentMapListener()
  }

  private fun setTencentMapListener() {
    val mapController = TencentMapController(this)
    mapView.map.setOnScaleViewChangedListener(mapController)
    mapView.map.setOnMapClickListener(mapController)
    mapView.map.setOnMapLongClickListener(mapController)
    mapView.map.setOnMapPoiClickListener(mapController)
    mapView.map.setOnMyLocationChangeListener(mapController)
    mapView.map.setMyLocationClickListener(mapController)
    mapView.map.setOnCameraChangeListener(mapController)
    mapView.map.setOnMarkerClickListener(mapController)
    mapView.map.setOnMarkerDragListener(mapController)
  }
}
