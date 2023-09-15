package com.morbit.tencent_map

import com.tencent.tencentmap.mapsdk.maps.TencentMap.OnCameraChangeListener
import com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMapClickListener
import com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMapLongClickListener
import com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMapPoiClickListener
import com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMarkerClickListener
import com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMarkerDragListener
import com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMyLocationChangeListener
import com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMyLocationClickListener
import com.tencent.tencentmap.mapsdk.maps.TencentMap.OnScaleViewChangedListener

internal interface TencentMapListener :
  OnScaleViewChangedListener,
  OnMapClickListener,
  OnMapLongClickListener,
  OnMapPoiClickListener,
  OnMyLocationChangeListener,
  OnMyLocationClickListener,
  OnCameraChangeListener,
  OnMarkerClickListener,
  OnMarkerDragListener