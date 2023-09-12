package com.morbit.tencent_map

import com.tencent.map.geolocation.TencentLocationManager
import com.tencent.tencentmap.mapsdk.maps.TencentMapInitializer

class _TencentMapSdkApi : TencentMapSdkApi {
  override fun agreePrivacy(agreePrivacy: Boolean) {
    TencentMapInitializer.setAgreePrivacy(agreePrivacy)
    TencentLocationManager.setUserAgreePrivacy(agreePrivacy)
  }
}
