package com.morbit.tencent_map

import android.location.Location
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent.tencentmap.mapsdk.maps.model.MapPoi
import com.tencent.tencentmap.mapsdk.maps.model.Marker

class TencentMapController(private val tencentMap: TencentMap) : TencentMapListener {
  override fun onScaleViewChanged(scale: Float) {
    tencentMap.mapHandler.onScaleViewChanged(scale.toDouble()) {}
  }

  override fun onMapClick(latLng: LatLng) {
    tencentMap.mapHandler.onPress(latLng.toPosition()) {}
  }

  override fun onMapLongClick(latLng: LatLng) {
    tencentMap.mapHandler.onLongPress(latLng.toPosition()) {}
  }

  override fun onClicked(poi: MapPoi) {
    tencentMap.mapHandler.onTapPoi(poi.toMapPoi()) {}
  }

  override fun onMyLocationChange(location: Location) {
    tencentMap.mapHandler.onLocation(location.toLocation()) {}
  }

  override fun onMyLocationClicked(latLng: LatLng): Boolean {
    tencentMap.mapHandler.onUserLocationClick(latLng.toPosition()) {}
    return true
  }

  override fun onCameraChange(position: CameraPosition) {
    tencentMap.mapHandler.onCameraMove(position.toCameraPosition()) {}
  }

  override fun onCameraChangeFinished(position: CameraPosition) {
    tencentMap.mapHandler.onCameraMoveEnd(position.toCameraPosition()) {}
  }

  override fun onMarkerClick(marker: Marker): Boolean {
    val markerId: String = tencentMap.tencentMapMarkerIdToDartMarkerId[marker.id] ?: return false
    tencentMap.mapHandler.onTapMarker(markerId) {}
    return true
  }

  override fun onMarkerDragStart(marker: Marker) {
    val markerId: String = tencentMap.tencentMapMarkerIdToDartMarkerId[marker.id] ?: return
    tencentMap.mapHandler.onMarkerDragStart(markerId, marker.position.toPosition()) {}
  }

  override fun onMarkerDrag(marker: Marker) {
    val markerId: String = tencentMap.tencentMapMarkerIdToDartMarkerId[marker.id] ?: return
    tencentMap.mapHandler.onMarkerDrag(markerId, marker.position.toPosition()) {}
  }

  override fun onMarkerDragEnd(marker: Marker) {
    val markerId: String = tencentMap.tencentMapMarkerIdToDartMarkerId[marker.id] ?: return
    tencentMap.mapHandler.onMarkerDragEnd(markerId, marker.position.toPosition()) {}
  }
}