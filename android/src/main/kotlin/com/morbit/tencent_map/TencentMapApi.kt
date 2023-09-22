package com.morbit.tencent_map

import com.tencent.map.geolocation.TencentLocationManager
import com.tencent.tencentmap.mapsdk.maps.CameraUpdateFactory
import com.tencent.tencentmap.mapsdk.maps.TencentMap.MAP_TYPE_DARK
import com.tencent.tencentmap.mapsdk.maps.TencentMap.MAP_TYPE_NORMAL
import com.tencent.tencentmap.mapsdk.maps.TencentMap.MAP_TYPE_SATELLITE
import com.tencent.tencentmap.mapsdk.maps.TencentMapInitializer
import com.tencent.tencentmap.mapsdk.maps.model.LatLngBounds

class TencentMapApi(private val tencentMap: TencentMap) {
  private val mapView = tencentMap.view

  fun agreePrivacy(agreePrivacy: Boolean) {
    TencentMapInitializer.setAgreePrivacy(agreePrivacy)
    TencentLocationManager.setUserAgreePrivacy(agreePrivacy)
  }

  fun setMapType(type: MapType) {
    mapView.map.mapType = when (type) {
      MapType.NORMAL -> MAP_TYPE_NORMAL
      MapType.SATELLITE -> MAP_TYPE_SATELLITE
      MapType.DARK -> MAP_TYPE_DARK
    }
  }

  fun setMapStyle(index: Long) {
    mapView.map.mapStyle = index.toInt()
  }

  fun setLogoScale(scale: Double) {
    mapView.map.uiSettings.setLogoScale(scale.toFloat())
  }

  fun setLogoPosition(position: UIControlPosition) {
    mapView.map.uiSettings.setLogoPosition(
      position.anchor.toAnchor(),
      intArrayOf(position.offset.y.toInt(), position.offset.x.toInt())
    )
  }

  fun setScalePosition(position: UIControlPosition) {
    mapView.map.uiSettings.setScaleViewPositionWithMargin(
      position.anchor.toAnchor(),
      position.offset.y.toInt(),
      position.offset.y.toInt(),
      position.offset.x.toInt(),
      position.offset.x.toInt()
    )
  }

  fun setCompassOffset(offset: UIControlOffset) {
    mapView.map.uiSettings.setCompassExtraPadding(
      offset.x.toInt(),
      offset.y.toInt()
    )
  }

  fun pause() {
    mapView.onPause()
  }

  fun resume() {
    mapView.onResume()
  }

  fun stop() {
    mapView.onStop()
  }

  fun start() {
    mapView.onStart()
  }

  fun destroy() {
    mapView.onDestroy()
  }

  fun setCompassEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isCompassEnabled = enabled
  }

  fun setRotateGesturesEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isRotateGesturesEnabled = enabled
  }

  fun setScrollGesturesEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isScrollGesturesEnabled = enabled
  }

  fun setZoomGesturesEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isZoomGesturesEnabled = enabled
  }

  fun setSkewGesturesEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isTiltGesturesEnabled = enabled
  }

  fun setIndoorViewEnabled(enabled: Boolean) {
    mapView.map.setIndoorEnabled(enabled)
  }

  fun setIndoorPickerEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isIndoorLevelPickerEnabled = enabled
  }

  fun setTrafficEnabled(enabled: Boolean) {
    mapView.map.isTrafficEnabled = enabled
  }

  fun setBuildingsEnabled(enabled: Boolean) {
    mapView.map.showBuilding(enabled)
  }

  fun setBuildings3dEnabled(enabled: Boolean) {
    mapView.map.setBuilding3dEffectEnable(enabled)
  }

  fun setScaleEnabled(enabled: Boolean) {
    mapView.map.uiSettings.isScaleViewEnabled = enabled
  }

  fun setScaleFadeEnabled(enabled: Boolean) {
    mapView.map.uiSettings.setScaleViewFadeEnable(enabled)
  }

  fun setMyLocationEnabled(enabled: Boolean) {
    mapView.map.isMyLocationEnabled = enabled
  }

  fun setUserLocationType(type: UserLocationType) {
    if (mapView.map.isMyLocationEnabled) {
      mapView.map.setMyLocationStyle(type.toMyLocationStyle())
    }
  }

  fun getUserLocation(): Location {
    return mapView.map.myLocation.toLocation()
  }

  fun moveCamera(position: CameraPosition, duration: Long) {
    val cameraPosition = position.toCameraPosition(mapView.map.cameraPosition)
    val cameraUpdate = CameraUpdateFactory.newCameraPosition(cameraPosition)
    if (duration > 0) {
      mapView.map.stopAnimation()
      mapView.map.animateCamera(cameraUpdate, duration, null)
    } else {
      mapView.map.moveCamera(cameraUpdate)
    }
  }

  fun moveCameraToRegion(region: Region, padding: EdgePadding, duration: Long) {
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

  fun moveCameraToRegionWithPosition(positions: List<Position?>, padding: EdgePadding, duration: Long) {
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

  fun setRestrictRegion(region: Region, mode: RestrictRegionMode) {
    mapView.map.setRestrictBounds(
      region.toLatLngBounds(),
      mode.toRestrictMode()
    )
  }

  fun addMarker(marker: Marker) {
    val tencentMarker = mapView.map.addMarker(marker.toMarkerOptions(tencentMap.binding))
    tencentMap.markers[marker.id] = tencentMarker
    tencentMap.tencentMapMarkerIdToDartMarkerId[tencentMarker.id] = marker.id
  }

  fun removeMarker(id: String) {
    val marker = tencentMap.markers[id]
    if (marker != null) {
      marker.remove()
      tencentMap.markers.remove(id)
      tencentMap.tencentMapMarkerIdToDartMarkerId.remove(marker.id)
    }
  }

  fun updateMarker(markerId: String, options: MarkerUpdateOptions) {
    if (options.position != null) {
      tencentMap.markers[markerId]?.position = options.position.toPosition()
    }
    if (options.alpha != null) {
      tencentMap.markers[markerId]?.alpha = options.alpha.toFloat()
    }
    if (options.rotation != null) {
      tencentMap.markers[markerId]?.rotation = options.rotation.toFloat()
    }
    if (options.zIndex != null) {
      tencentMap.markers[markerId]?.zIndex = options.zIndex.toInt()
    }
    if (options.draggable != null) {
      tencentMap.markers[markerId]?.isDraggable = options.draggable
    }
    if (options.icon != null) {
      options.icon.toBitmapDescriptor(tencentMap.binding)?.let { tencentMap.markers[markerId]?.setIcon(it) }
    }
    if (options.anchor != null) {
      tencentMap.markers[markerId]?.setAnchor(options.anchor.x.toFloat(), options.anchor.y.toFloat())
    }
  }
}
