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

fun UserLocationType.toMyLocationStyle(): TencentMyLocationStyle {
    return TencentMyLocationStyle().also { style ->
        when (this) {
            UserLocationType.TRACKINGLOCATIONROTATE -> TencentMyLocationStyle.LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER
            UserLocationType.TRACKINGLOCATION -> TencentMyLocationStyle.LOCATION_TYPE_FOLLOW_NO_CENTER
            UserLocationType.TRACKINGLOCATIONROTATECENTER -> TencentMyLocationStyle.LOCATION_TYPE_LOCATION_ROTATE
            UserLocationType.TRACKINGROTATE -> TencentMyLocationStyle.LOCATION_TYPE_MAP_ROTATE_NO_CENTER
            else -> null
        }?.let { it ->
            style.myLocationType(it)
        }
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