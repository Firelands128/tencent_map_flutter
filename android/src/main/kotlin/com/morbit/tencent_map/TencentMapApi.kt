package com.morbit.tencent_map

import com.tencent.tencentmap.mapsdk.maps.CameraUpdateFactory
import com.tencent.tencentmap.mapsdk.maps.TencentMap.MAP_TYPE_DARK
import com.tencent.tencentmap.mapsdk.maps.TencentMap.MAP_TYPE_NORMAL
import com.tencent.tencentmap.mapsdk.maps.TencentMap.MAP_TYPE_SATELLITE
import com.tencent.tencentmap.mapsdk.maps.model.LatLngBounds

class _TencentMapApi(private val tencentMap: TencentMap) : TencentMapApi {
  private val mapView = tencentMap.view

  override fun setMapType(type: MapType) {
    mapView.map.mapType = when (type) {
      MapType.NORMAL -> MAP_TYPE_NORMAL
      MapType.SATELLITE -> MAP_TYPE_SATELLITE
      MapType.DARK -> MAP_TYPE_DARK
    }
  }

  override fun setMapStyle(index: Long) {
    mapView.map.mapStyle = index.toInt()
  }

  override fun setLogoScale(scale: Double) {
    mapView.map.uiSettings.setLogoScale(scale.toFloat())
  }

  override fun setLogoPosition(anchor: UIControlAnchor, offset: UIControlOffset) {
    mapView.map.uiSettings.setLogoPosition(
      anchor.toAnchor(),
      intArrayOf(offset.y.toInt(), offset.x.toInt())
    )
  }

  override fun setScalePosition(anchor: UIControlAnchor, offset: UIControlOffset) {
    mapView.map.uiSettings.setScaleViewPositionWithMargin(
      anchor.toAnchor(),
      offset.y.toInt(),
      offset.y.toInt(),
      offset.x.toInt(),
      offset.x.toInt()
    )
  }

  override fun setCompassOffset(offset: UIControlOffset) {
    mapView.map.uiSettings.setCompassExtraPadding(
      offset.x.toInt(),
      offset.y.toInt()
    )
  }

  override fun pause() {
    mapView.onPause()
  }

  override fun resume() {
    mapView.onResume()
  }

  override fun stop() {
    mapView.onStop()
  }

  override fun start() {
    mapView.onStart()
  }

  override fun destroy() {
    mapView.onDestroy()
  }

  override fun setCompassEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isCompassEnabled = enabled
  }

  override fun setRotateGesturesEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isRotateGesturesEnabled = enabled
  }

  override fun setScrollGesturesEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isScrollGesturesEnabled = enabled
  }

  override fun setZoomGesturesEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isZoomGesturesEnabled = enabled
  }

  override fun setSkewGesturesEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isTiltGesturesEnabled = enabled
  }

  override fun setIndoorViewEnabled(enabled: Boolean) {
    mapView.map.setIndoorEnabled(enabled)
  }

  override fun setIndoorPickerEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isIndoorLevelPickerEnabled = enabled
  }

  override fun setTrafficEnabled(enabled: Boolean) {
    mapView.map.isTrafficEnabled = enabled
  }

  override fun setBuildingsEnabled(enabled: Boolean) {
    mapView.map.showBuilding(enabled)
  }

  override fun setBuildings3dEnabled(enabled: Boolean) {
    mapView.map.setBuilding3dEffectEnable(enabled)
  }

  override fun setScaleEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isScaleViewEnabled = enabled
  }

  override fun setScaleFadeEnabled(enabled: Boolean) {
    mapView.map.uiSettings.setScaleViewFadeEnable(enabled)
  }

  override fun setMyLocationEnabled(enabled: Boolean) {
    mapView.map.isMyLocationEnabled = enabled
  }

  override fun setUserLocationType(type: UserLocationType) {
    if (mapView.map.isMyLocationEnabled) {
      mapView.map.setMyLocationStyle(type.toMyLocationStyle())
    }
  }

  override fun getUserLocation(): Location {
    if (!mapView.map.isMyLocationEnabled) {
      throw FlutterError(code = "400", message = "Location feature is not enabled.")
    }
    if (mapView.map.myLocation == null) {
      throw FlutterError(code = "500", message = "Failed to get my location.")
    } else {
      return mapView.map.myLocation.toLocation()
    }
  }

  override fun moveCamera(position: CameraPosition, duration: Long) {
    val cameraPosition = position.toCameraPosition(mapView.map.cameraPosition)
    val cameraUpdate = CameraUpdateFactory.newCameraPosition(cameraPosition)
    if (duration > 0) {
      mapView.map.stopAnimation()
      mapView.map.animateCamera(cameraUpdate, duration, null)
    } else {
      mapView.map.moveCamera(cameraUpdate)
    }
  }

  override fun moveCameraToRegion(region: Region, padding: EdgePadding, duration: Long) {
    val latLngBounds = region.toLatLngBounds()
    val cameraUpdate = CameraUpdateFactory.newLatLngBoundsRect(
      latLngBounds,
      padding.left.toInt(),
      padding.right.toInt(),
      padding.top.toInt(),
      padding.bottom.toInt(),
    )
    if (duration > 0) {
      mapView.map.stopAnimation()
      mapView.map.animateCamera(cameraUpdate, duration, null)
    } else {
      mapView.map.moveCamera(cameraUpdate)
    }
  }

  override fun moveCameraToRegionWithPosition(positions: List<Position?>, padding: EdgePadding, duration: Long) {
    val latLngBounds = LatLngBounds.Builder().include(positions.filterNotNull().map { it.toPosition() }).build()
    val cameraUpdate = CameraUpdateFactory.newLatLngBoundsRect(
      latLngBounds,
      padding.left.toInt(),
      padding.right.toInt(),
      padding.top.toInt(),
      padding.bottom.toInt(),
    )
    if (duration > 0) {
      mapView.map.stopAnimation()
      mapView.map.animateCamera(cameraUpdate, duration, null)
    } else {
      mapView.map.moveCamera(cameraUpdate)
    }
  }

  override fun setRestrictRegion(region: Region, mode: RestrictRegionMode) {
    mapView.map.setRestrictBounds(
      region.toLatLngBounds(),
      mode.toRestrictMode()
    )
  }

  override fun addMarker(options: MarkerOptions): String {
    val marker = mapView.map.addMarker(options.toMarkerOptions(tencentMap.binding))
    tencentMap.markers[marker.id] = marker
    return marker.id
  }
}
