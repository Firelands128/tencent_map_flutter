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

  fun updateMapConfig(config: MapConfig) {
    config.mapType?.let {
      mapView.map.mapType = when (it) {
        MapType.NORMAL -> MAP_TYPE_NORMAL
        MapType.SATELLITE -> MAP_TYPE_SATELLITE
        MapType.DARK -> MAP_TYPE_DARK
      }
    }
    config.mapStyle?.let {
      mapView.map.mapStyle = it.toInt()
    }
    config.logoScale?.let { mapView.map.uiSettings.setLogoScale(it.toFloat()) }
    config.logoPosition?.let {
      mapView.map.uiSettings.setLogoPosition(
        it.anchor.toAnchor(),
        intArrayOf(it.offset.y.toInt(), it.offset.x.toInt())
      )
    }
    config.scalePosition?.let {
      mapView.map.uiSettings.setScaleViewPositionWithMargin(
        it.anchor.toAnchor(),
        it.offset.y.toInt(),
        it.offset.y.toInt(),
        it.offset.x.toInt(),
        it.offset.x.toInt()
      )
    }
    config.compassOffset?.let {
      mapView.map.uiSettings.setCompassExtraPadding(
        it.x.toInt(),
        it.y.toInt()
      )
    }
    config.compassEnabled?.let { mapView.map.uiSettings.isCompassEnabled = it }
    config.scaleEnabled?.let { mapView.map.uiSettings.isScaleViewEnabled = it }
    config.scaleFadeEnabled?.let { mapView.map.uiSettings.setScaleViewFadeEnable(it) }
    config.skewGesturesEnabled?.let { mapView.map.uiSettings.isTiltGesturesEnabled = it }
    config.scrollGesturesEnabled?.let { mapView.map.uiSettings.isScrollGesturesEnabled = it }
    config.rotateGesturesEnabled?.let { mapView.map.uiSettings.isRotateGesturesEnabled = it }
    config.zoomGesturesEnabled?.let { mapView.map.uiSettings.isZoomGesturesEnabled = it }
    config.trafficEnabled?.let { mapView.map.isTrafficEnabled = it }
    config.indoorViewEnabled?.let { mapView.map.setIndoorEnabled(it) }
    config.indoorPickerEnabled?.let { mapView.map.uiSettings.isIndoorLevelPickerEnabled = it }
    config.buildingsEnabled?.let { mapView.map.showBuilding(it) }
    config.buildings3dEnabled?.let { mapView.map.setBuilding3dEffectEnable(it) }
    config.myLocationEnabled?.let { mapView.map.isMyLocationEnabled = it }
    config.userLocationType?.let {
      if (mapView.map.isMyLocationEnabled) {
        mapView.map.setMyLocationStyle(it.toMyLocationStyle())
      }
    }
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

  fun getUserLocation(): Location {
    return mapView.map.myLocation.toLocation()
  }

  fun start() {
    mapView.onStart()
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

  fun destroy() {
    mapView.onDestroy()
  }
}
