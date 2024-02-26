package com.morbit.tencent_map_flutter

import android.content.Context
import android.location.Location
import android.widget.Toast
import com.tencent.map.geolocation.TencentLocation
import com.tencent.map.geolocation.TencentLocationListener
import com.tencent.map.geolocation.TencentLocationManager
import com.tencent.map.geolocation.TencentLocationRequest
import com.tencent.tencentmap.mapsdk.maps.LocationSource

class TencentLocationSource(private val context: Context) : LocationSource, TencentLocationListener {
  private var locationChangedListener: LocationSource.OnLocationChangedListener? = null
  private var locationManager: TencentLocationManager?
  private var locationRequest: TencentLocationRequest?

  /**
   * 定位的一些初始化设置
   */
  init {
    /// 用于访问腾讯定位服务的类, 周期性向客户端提供位置更新
    locationManager = TencentLocationManager.getInstance(context)
    /// 创建定位请求
    locationRequest = TencentLocationRequest.create()
  }

  override fun activate(onLocationChangedListener: LocationSource.OnLocationChangedListener?) {
    /// 这里我们将地图返回的位置监听保存为当前 Activity 的成员变量
    locationChangedListener = onLocationChangedListener
    /// 开启定位
    val err = locationManager?.requestLocationUpdates(locationRequest, this)
    when (err) {
      1 -> Toast.makeText(
        context,
        "设备缺少使用腾讯定位服务需要的基本条件",
        Toast.LENGTH_SHORT
      ).show()

      2 -> Toast.makeText(
        context,
        "manifest 中配置的 key 不正确", Toast.LENGTH_SHORT
      ).show()

      3 -> Toast.makeText(
        context,
        "自动加载libtencentloc.so失败", Toast.LENGTH_SHORT
      ).show()

      else -> {}
    }
  }

  override fun deactivate() {
    /// 当不需要展示定位点时，需要停止定位并释放相关资源
    locationManager?.removeUpdates(this)
    locationManager = null
    locationRequest = null
    locationChangedListener = null
  }

  /**
   * 腾讯定位SDK位置变化回调
   */
  override fun onLocationChanged(tencentLocation: TencentLocation, i: Int, s: String?) {
    if (tencentLocation.latitude == 0.0 && tencentLocation.longitude == 0.0) return

    /// 其中 locationChangeListener 为 LocationSource.active 返回给用户的位置监听器
    /// 用户通过这个监听器就可以设置地图的定位点位置
    if (i == TencentLocation.ERROR_OK && locationChangedListener != null) {
      val location = Location(tencentLocation.provider)
      /// 设置经纬度
      location.latitude = tencentLocation.latitude
      location.longitude = tencentLocation.longitude
      /// 设置精度，这个值会被设置为定位点上表示精度的圆形半径
      location.accuracy = tencentLocation.accuracy
      /// 设置定位标的旋转角度，注意 tencentLocation.getBearing() 只有在 gps 时才有可能获取
      /// location.setBearing((float) tencentLocation.getBearing());
      /// 设置定位标的旋转角度，注意 tencentLocation.getDirection() 返回的方向，仅来自传感器方向，如果是gps，则直接获取gps方向
      location.bearing = tencentLocation.direction.toFloat()
      /// 将位置信息返回给地图
      locationChangedListener?.onLocationChanged(location)
    }
  }

  override fun onStatusUpdate(p0: String?, p1: Int, p2: String?) {}
}