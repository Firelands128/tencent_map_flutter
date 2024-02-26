package com.morbit.tencent_map_flutter

import android.location.Location
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent.tencentmap.mapsdk.maps.model.MapPoi
import com.tencent.tencentmap.mapsdk.maps.model.Marker

class TencentMapListener(private val tencentMap: TencentMap) : TencentMapListenerInterface {
  override fun onScaleViewChanged(scale: Float) {
    tencentMap.controller.onScaleViewChanged(scale.toDouble())
  }

  override fun onMapClick(latLng: LatLng) {
    tencentMap.controller.onPress(latLng.toPosition())
  }

  override fun onMapLongClick(latLng: LatLng) {
    tencentMap.controller.onLongPress(latLng.toPosition())
  }

  override fun onClicked(poi: MapPoi) {
    tencentMap.controller.onTapPoi(poi.toPoi())
  }

  override fun onMyLocationChange(location: Location) {
    tencentMap.controller.onLocation(location.toLocation())
  }

  override fun onMyLocationClicked(latLng: LatLng): Boolean {
    tencentMap.controller.onUserLocationClick(latLng.toPosition())
    return true
  }

  override fun onCameraChange(position: CameraPosition) {
    tencentMap.controller.onCameraMove(position.toCameraPosition())
  }

  override fun onCameraChangeFinished(position: CameraPosition) {
    tencentMap.controller.onCameraMoveEnd(position.toCameraPosition())
  }

  override fun onMarkerClick(marker: Marker): Boolean {
    val markerId: String = tencentMap.tencentMapMarkerIdToDartMarkerId[marker.id] ?: return false
    tencentMap.controller.onTapMarker(markerId)
    return true
  }

  override fun onMarkerDragStart(marker: Marker) {
    val markerId: String = tencentMap.tencentMapMarkerIdToDartMarkerId[marker.id] ?: return
    tencentMap.controller.onMarkerDragStart(markerId, marker.position.toPosition())
  }

  override fun onMarkerDrag(marker: Marker) {
    val markerId: String = tencentMap.tencentMapMarkerIdToDartMarkerId[marker.id] ?: return
    tencentMap.controller.onMarkerDrag(markerId, marker.position.toPosition())
  }

  override fun onMarkerDragEnd(marker: Marker) {
    val markerId: String = tencentMap.tencentMapMarkerIdToDartMarkerId[marker.id] ?: return
    tencentMap.controller.onMarkerDragEnd(markerId, marker.position.toPosition())
  }
}

internal interface TencentMapListenerInterface :
  com.tencent.tencentmap.mapsdk.maps.TencentMap.OnScaleViewChangedListener,
  com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMapClickListener,
  com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMapLongClickListener,
  com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMapPoiClickListener,
  com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMyLocationChangeListener,
  com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMyLocationClickListener,
  com.tencent.tencentmap.mapsdk.maps.TencentMap.OnCameraChangeListener,
  com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMarkerClickListener,
  com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMarkerDragListener