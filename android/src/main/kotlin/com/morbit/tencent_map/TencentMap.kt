package com.morbit.tencent_map

import android.content.Context
import com.tencent.tencentmap.mapsdk.maps.BaseMapView
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import com.tencent.tencentmap.mapsdk.maps.TextureMapView
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import com.tencent.tencentmap.mapsdk.maps.model.Marker
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.platform.PlatformView

class TencentMap(val binding: FlutterPlugin.FlutterPluginBinding, context: Context, args: HashMap<*, *>) :
  PlatformView {
  private val mapHandler = TencentMapHandler(binding.binaryMessenger)
  private val mapView: BaseMapView
  private val locationSource = TencentLocationSource(context, mapHandler)
  val markers = mutableMapOf<String, Marker>()

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
    MarkerApi.setUp(binding.binaryMessenger, _MarkerApi(this))
    mapView.onResume()
    mapView.map.setLocationSource(locationSource)
    mapView.map.setOnMapClickListener { mapHandler.onPress(it.toPosition()) {} }
    mapView.map.setOnMapLongClickListener { mapHandler.onLongPress(it.toPosition()) {} }
    mapView.map.setOnMapPoiClickListener { mapHandler.onTapPoi(it.toMapPoi()) {} }
    mapView.map.setOnMyLocationChangeListener {
      val pigeonLocation = Location(
        Position(it.latitude, it.longitude),
        it.bearing.toDouble(),
        it.accuracy.toDouble()
      )
      mapHandler.onLocation(pigeonLocation) {}
    }
    mapView.map.setOnCameraChangeListener(object : TencentMap.OnCameraChangeListener {
      override fun onCameraChange(position: CameraPosition) {
        mapHandler.onCameraMove(position.toCameraPosition()) {}
      }

      override fun onCameraChangeFinished(position: CameraPosition) {
        mapHandler.onCameraMoveEnd(position.toCameraPosition()) {}
      }
    })
    mapView.map.setOnMarkerClickListener {
      mapHandler.onTapMarker(it.id) {}
      true
    }
    mapView.map.setOnMarkerDragListener(object : TencentMap.OnMarkerDragListener {
      override fun onMarkerDragStart(marker: Marker) {
        mapHandler.onMarkerDragStart(marker.id, marker.position.toPosition()) {}
      }

      override fun onMarkerDrag(marker: Marker) {
        mapHandler.onMarkerDrag(marker.id, marker.position.toPosition()) {}
      }

      override fun onMarkerDragEnd(marker: Marker) {
        mapHandler.onMarkerDragEnd(marker.id, marker.position.toPosition()) {}
      }
    })
  }
}
