package com.morbit.tencent_map_flutter

import android.graphics.BitmapFactory
import com.tencent.tencentmap.mapsdk.maps.model.BitmapDescriptor
import com.tencent.tencentmap.mapsdk.maps.model.BitmapDescriptorFactory
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent.tencentmap.mapsdk.maps.model.LatLngBounds
import com.tencent.tencentmap.mapsdk.maps.model.MapPoi
import com.tencent.tencentmap.mapsdk.maps.model.MarkerOptions
import com.tencent.tencentmap.mapsdk.maps.model.MyLocationStyle
import com.tencent.tencentmap.mapsdk.maps.model.RestrictBoundsFitMode
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import android.location.Location as AndroidLocation
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition as TencentCameraPosition

fun Position.toPosition(): LatLng {
  return LatLng(latitude, longitude)
}

fun LatLng.toPosition(): Position {
  return Position(latitude, longitude)
}

fun MapPoi.toPoi(): Poi {
  return Poi(name, position.toPosition())
}

fun TencentCameraPosition.toCameraPosition(): CameraPosition {
  return CameraPosition(
    target.toPosition(),
    bearing.toDouble(),
    tilt.toDouble(),
    zoom.toDouble(),
  )
}

fun CameraPosition.toCameraPosition(cameraPosition: TencentCameraPosition): TencentCameraPosition {
  return TencentCameraPosition.Builder().let { builder ->
    builder.target(position?.toPosition() ?: cameraPosition.target)
    builder.tilt(skew?.toFloat() ?: cameraPosition.tilt)
    builder.zoom(zoom?.toFloat() ?: cameraPosition.zoom)
    builder.bearing(heading?.toFloat() ?: cameraPosition.bearing)
    builder.build()
  }
}

fun AndroidLocation.toLocation(): Location {
  return Location(
    Position(latitude, longitude),
    bearing.toDouble(),
    accuracy.toDouble()
  )
}

fun UserLocationType.toMyLocationStyle(): MyLocationStyle {
  return MyLocationStyle().also { style ->
    when (this) {
      UserLocationType.TRACKINGLOCATIONROTATE -> MyLocationStyle.LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER
      UserLocationType.TRACKINGLOCATION -> MyLocationStyle.LOCATION_TYPE_FOLLOW_NO_CENTER
      UserLocationType.TRACKINGLOCATIONROTATECENTER -> MyLocationStyle.LOCATION_TYPE_LOCATION_ROTATE
      UserLocationType.TRACKINGROTATE -> MyLocationStyle.LOCATION_TYPE_MAP_ROTATE_NO_CENTER
      else -> null
    }?.let {
      style.myLocationType(it)
    }
  }
}

fun Region.toLatLngBounds(): LatLngBounds {
  return LatLngBounds(LatLng(north, east), LatLng(south, west))
}

fun RestrictRegionMode.toRestrictMode(): RestrictBoundsFitMode {
  return when (this) {
    RestrictRegionMode.FITWIDTH -> RestrictBoundsFitMode.FIT_WIDTH
    RestrictRegionMode.FITHEIGHT -> RestrictBoundsFitMode.FIT_HEIGHT
  }
}

fun UIControlAnchor.toAnchor(): Int {
  return when (this) {
    UIControlAnchor.BOTTOMLEFT -> 0
    UIControlAnchor.BOTTOMRIGHT -> 1
    UIControlAnchor.TOPLEFT -> 3
    UIControlAnchor.TOPRIGHT -> 2
  }
}

fun Marker.toMarkerOptions(binding: FlutterPluginBinding): MarkerOptions {
  return MarkerOptions(position.toPosition()).let { options ->
    icon?.toBitmapDescriptor(binding)?.let { options.icon(it) }
    rotation?.toFloat()?.let { options.rotation(it) }
    alpha?.toFloat()?.let { options.alpha(it) }
    anchor?.let { options.anchor(it.x.toFloat(), it.y.toFloat()) }
    draggable?.let { options.draggable(it) }
    zIndex?.let { options.zIndex(it.toFloat()) }
    options
  }
}

fun Bitmap.toBitmapDescriptor(binding: FlutterPluginBinding): BitmapDescriptor? {
  asset?.let {
    return BitmapDescriptorFactory.fromAsset(binding.flutterAssets.getAssetFilePathByName(it))
  }
  bytes?.let {
    return BitmapDescriptorFactory.fromBitmap(BitmapFactory.decodeByteArray(it, 0, it.size))
  }
  return null
}