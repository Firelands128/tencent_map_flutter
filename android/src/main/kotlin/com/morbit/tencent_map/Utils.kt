package com.morbit.tencent_map

import android.graphics.BitmapFactory
import com.tencent.tencentmap.mapsdk.maps.model.BitmapDescriptor
import com.tencent.tencentmap.mapsdk.maps.model.BitmapDescriptorFactory
import com.tencent.tencentmap.mapsdk.maps.model.MapPoi as TencentMapPoi
import com.tencent.tencentmap.mapsdk.maps.model.MarkerOptions as TencentMarkerOptions
import com.tencent.tencentmap.mapsdk.maps.model.LatLng as TencentLatLng
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition as TencentCameraPosition
import android.location.Location as AndroidLocation
import com.tencent.tencentmap.mapsdk.maps.model.MyLocationStyle as TencentMyLocationStyle
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding

fun Position.toPosition(): TencentLatLng {
    return TencentLatLng(latitude ?: 0.0, longitude ?: 0.0)
}

fun TencentLatLng.toPosition(): Position {
    return Position(latitude, longitude)
}

fun TencentMapPoi.toMapPoi(): MapPoi {
    return MapPoi(name, position.toPosition())
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
        builder.target(target?.toPosition() ?: cameraPosition.target)
        builder.tilt(tilt?.toFloat() ?: cameraPosition.tilt)
        builder.zoom(zoom?.toFloat() ?: cameraPosition.zoom)
        builder.bearing(bearing?.toFloat() ?: cameraPosition.bearing)
        builder.build()
    }
}

fun Location.toLocation(): AndroidLocation {
    return AndroidLocation("tencent_map").let { location ->
	      position.let { location.latitude = it.latitude; location.longitude = it.longitude }
        accuracy?.let { location.accuracy = it.toFloat() }
        bearing?.let { location.bearing = it.toFloat() }
        location
    }
}

fun MyLocationStyle.toMyLocationStyle(): TencentMyLocationStyle {
    return TencentMyLocationStyle().let { style ->
        myLocationType?.let {
            style.myLocationType(
                when (it) {
                    MyLocationType.FOLLOWNOCENTER -> TencentMyLocationStyle.LOCATION_TYPE_FOLLOW_NO_CENTER
                    MyLocationType.LOCATIONROTATE -> TencentMyLocationStyle.LOCATION_TYPE_LOCATION_ROTATE
                    MyLocationType.LOCATIONROTATENOCENTER -> TencentMyLocationStyle.LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER
                    MyLocationType.MAPROTATENOCENTER -> TencentMyLocationStyle.LOCATION_TYPE_MAP_ROTATE_NO_CENTER
                }
            )
        }
        style
    }
}

fun MarkerOptions.toMarkerOptions(binding: FlutterPluginBinding): TencentMarkerOptions {
    return TencentMarkerOptions(position.toPosition()).let { options ->
        icon?.toBitmapDescriptor(binding)?.let { options.icon(it) }
        rotation?.toFloat()?.let { options.rotation(it) }
        alpha?.toFloat()?.let { options.alpha(it) }
        flat?.let { options.flat(it) }
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