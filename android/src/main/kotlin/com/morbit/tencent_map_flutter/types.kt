package com.morbit.tencent_map_flutter

/** 地图类型 */
enum class MapType(val raw: Int) {
  /** 常规地图 */
  NORMAL(0),

  /** 卫星地图 */
  SATELLITE(1),

  /** 暗色地图 */
  DARK(2);

  companion object {
    fun ofRaw(raw: Int): MapType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** 限制显示区域模式 */
enum class RestrictRegionMode(val raw: Int) {
  /** 适配宽度 */
  FITWIDTH(0),

  /** 适配高度 */
  FITHEIGHT(1);

  companion object {
    fun ofRaw(raw: Int): RestrictRegionMode? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** UI控件位置锚点 */
enum class UIControlAnchor(val raw: Int) {
  BOTTOMLEFT(0),
  BOTTOMRIGHT(1),
  TOPLEFT(2),
  TOPRIGHT(3);

  companion object {
    fun ofRaw(raw: Int): UIControlAnchor? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** 定位模式: 在地图的各种应用场景中，用户对定位点展示时也希望地图能跟随定位点旋转、移动等多种行为 */
enum class UserLocationType(val raw: Int) {
  /** 跟踪用户的位置与方向更新，默认是此种类型 */
  TRACKINGLOCATIONROTATE(0),

  /** 追踪用户的位置更新 */
  TRACKINGLOCATION(1),

  /** 跟踪用户的位置与方向更新，并移动到地图中心（Android only, Android default） */
  TRACKINGLOCATIONROTATECENTER(2),

  /** 不追踪用户的位置与方向更新（iOS only） */
  NOTRACKING(3),

  /** 跟踪用户的位置与方向更新，并地图依照用户方向旋转（Android only） */
  TRACKINGROTATE(4);

  companion object {
    fun ofRaw(raw: Int): UserLocationType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** 点标记图标锚点 */
data class Anchor(
  /** 点标记图标锚点的X坐标 */
  val x: Double,
  /** 点标记图标锚点的Y坐标 */
  val y: Double

) {
  companion object {
    fun fromList(list: List<Any?>): Anchor {
      val x = list[0] as Double
      val y = list[1] as Double
      return Anchor(x, y)
    }
  }

  fun toList(): List<Any?> {
    return listOf<Any?>(
      x,
      y,
    )
  }
}

/** 图片信息 */
data class Bitmap(
  /** 图片资源路径 */
  val asset: String? = null,
  /** 图片数据 */
  val bytes: ByteArray? = null

) {
  companion object {
    fun fromList(list: List<Any?>): Bitmap {
      val asset = list[0] as String?
      val bytes = list[1] as ByteArray?
      return Bitmap(asset, bytes)
    }
  }

  fun toList(): List<Any?> {
    return listOf(
      asset,
      bytes,
    )
  }

  override fun equals(other: Any?): Boolean {
    if (this === other) return true
    if (javaClass != other?.javaClass) return false

    other as Bitmap

    if (asset != other.asset) return false
    if (bytes != null) {
      if (other.bytes == null) return false
      if (!bytes.contentEquals(other.bytes)) return false
    } else if (other.bytes != null) return false

    return true
  }

  override fun hashCode(): Int {
    var result = asset?.hashCode() ?: 0
    result = 31 * result + (bytes?.contentHashCode() ?: 0)
    return result
  }
}

/** 地图视野 */
data class CameraPosition(
  /** 地图视野的位置 */
  val position: Position? = null,
  /** 地图视野的旋转角度 */
  val heading: Double? = null,
  /** 地图视野的倾斜角度 */
  val skew: Double? = null,
  /** 地图视野的缩放级别 */
  val zoom: Double? = null

) {
  companion object {
    fun fromList(list: List<Any?>): CameraPosition {
      val position: Position? = (list[0] as List<Any?>?)?.let {
        Position.fromList(it)
      }
      val heading = list[1] as Double?
      val skew = list[2] as Double?
      val zoom = list[3] as Double?
      return CameraPosition(position, heading, skew, zoom)
    }
  }

  fun toList(): List<Any?> {
    return listOf(
      position?.toList(),
      heading,
      skew,
      zoom,
    )
  }
}

/** 视野边缘宽度 */
data class EdgePadding(
  /** 上边缘宽度 */
  val top: Double,
  /** 右边缘宽度 */
  val right: Double,
  /** 下边缘宽度 */
  val bottom: Double,
  /** 左边缘宽度 */
  val left: Double

) {
  companion object {
    fun fromList(list: List<Any?>): EdgePadding {
      val top = list[0] as Double
      val right = list[1] as Double
      val bottom = list[2] as Double
      val left = list[3] as Double
      return EdgePadding(top, right, bottom, left)
    }
  }

  fun toList(): List<Any?> {
    return listOf(
      top,
      right,
      bottom,
      left,
    )
  }
}

/** 定位点 */
data class Location(
  /** 定位点的位置 */
  val position: Position,
  /** 定位点的方向 */
  val heading: Double? = null,
  /** 定位点的精确度 */
  val accuracy: Double? = null

) {
  companion object {
    fun fromList(list: List<Any?>): Location {
      val position = Position.fromList(list[0] as List<Any?>)
      val heading = list[1] as Double?
      val accuracy = list[2] as Double?
      return Location(position, heading, accuracy)
    }
  }

  fun toList(): List<Any?> {
    return listOf(
      position.toList(),
      heading,
      accuracy,
    )
  }
}

/** 地图属性配置 */
data class MapConfig(
  val mapType: MapType? = null,
  val mapStyle: Int? = null,
  val logoScale: Double? = null,
  val logoPosition: UIControlPosition? = null,
  val scalePosition: UIControlPosition? = null,
  val compassOffset: UIControlOffset? = null,
  val compassEnabled: Boolean? = null,
  val scaleEnabled: Boolean? = null,
  val scaleFadeEnabled: Boolean? = null,
  val skewGesturesEnabled: Boolean? = null,
  val scrollGesturesEnabled: Boolean? = null,
  val rotateGesturesEnabled: Boolean? = null,
  val zoomGesturesEnabled: Boolean? = null,
  val trafficEnabled: Boolean? = null,
  val indoorViewEnabled: Boolean? = null,
  val indoorPickerEnabled: Boolean? = null,
  val buildingsEnabled: Boolean? = null,
  val buildings3dEnabled: Boolean? = null,
  val myLocationEnabled: Boolean? = null,
  val userLocationType: UserLocationType? = null,
) {

  companion object {
    fun fromList(list: List<Any?>): MapConfig {
      val mapType = (list[0] as Int?)?.let { MapType.ofRaw(it) }
      val mapStyle = list[1] as Int?
      val logoScale = list[2] as Double?
      val logoPosition = (list[3] as List<Any?>?)?.let { UIControlPosition.fromList(it) }
      val scalePosition = (list[4] as List<Any?>?)?.let { UIControlPosition.fromList(it) }
      val compassOffset = (list[5] as List<Any?>?)?.let { UIControlOffset.fromList(it) }
      val compassEnabled = list[6] as Boolean?
      val scaleEnabled = list[7] as Boolean?
      val scaleFadeEnabled = list[8] as Boolean?
      val skewGesturesEnabled = list[9] as Boolean?
      val scrollGesturesEnabled = list[10] as Boolean?
      val rotateGesturesEnabled = list[11] as Boolean?
      val zoomGesturesEnabled = list[12] as Boolean?
      val trafficEnabled = list[13] as Boolean?
      val indoorViewEnabled = list[14] as Boolean?
      val indoorPickerEnabled = list[15] as Boolean?
      val buildingsEnabled = list[16] as Boolean?
      val buildings3dEnabled = list[17] as Boolean?
      val myLocationEnabled = list[18] as Boolean?
      val userLocationType = (list[19] as Int?)?.let { UserLocationType.ofRaw(it) }
      return MapConfig(
        mapType,
        mapStyle,
        logoScale,
        logoPosition,
        scalePosition,
        compassOffset,
        compassEnabled,
        scaleEnabled,
        scaleFadeEnabled,
        skewGesturesEnabled,
        scrollGesturesEnabled,
        rotateGesturesEnabled,
        zoomGesturesEnabled,
        trafficEnabled,
        indoorViewEnabled,
        indoorPickerEnabled,
        buildingsEnabled,
        buildings3dEnabled,
        myLocationEnabled,
        userLocationType
      )
    }
  }

  fun toList(): List<Any?> {
    return listOf(
      mapType?.raw,
      mapStyle,
      logoScale,
      logoPosition?.toList(),
      scalePosition?.toList(),
      compassOffset?.toList(),
      compassEnabled,
      scaleEnabled,
      scaleFadeEnabled,
      skewGesturesEnabled,
      scrollGesturesEnabled,
      rotateGesturesEnabled,
      zoomGesturesEnabled,
      trafficEnabled,
      indoorViewEnabled,
      indoorPickerEnabled,
      buildingsEnabled,
      buildings3dEnabled,
      myLocationEnabled,
      userLocationType?.raw,
    )
  }
}

/** 标记点配置属性 */
data class Marker(
  /** 标记点ID */
  val id: String,
  /** 标记点的位置 */
  val position: Position,
  /** 标记点的透明度 */
  val alpha: Double? = null,
  /** 标记点的旋转角度 */
  val rotation: Double? = null,
  /** 标记点的Z轴显示顺序 */
  val zIndex: Long? = null,
  /** 标记点是否支持拖动 */
  val draggable: Boolean? = null,
  /** 标记点的图标信息 */
  val icon: Bitmap? = null,
  /** 标记点的锚点 */
  val anchor: Anchor? = null

) {
  companion object {
    fun fromList(list: List<Any?>): Marker {
      val id = list[0] as String
      val position = Position.fromList(list[1] as List<Any?>)
      val alpha = list[2] as Double?
      val rotation = list[3] as Double?
      val zIndex = list[4].let { if (it is Int) it.toLong() else it as Long? }
      val draggable = list[5] as Boolean?
      val icon: Bitmap? = (list[6] as List<Any?>?)?.let {
        Bitmap.fromList(it)
      }
      val anchor: Anchor? = (list[7] as List<Any?>?)?.let {
        Anchor.fromList(it)
      }
      return Marker(id, position, alpha, rotation, zIndex, draggable, icon, anchor)
    }
  }

  fun toList(): List<Any?> {
    return listOf(
      id,
      position.toList(),
      alpha,
      rotation,
      zIndex,
      draggable,
      icon?.toList(),
      anchor?.toList(),
    )
  }
}

/** 标记点更新配置属性 */
data class MarkerUpdateOptions(
  /** 标记点的位置 */
  val position: Position? = null,
  /** 标记点的透明度 */
  val alpha: Double? = null,
  /** 标记点的旋转角度 */
  val rotation: Double? = null,
  /** 标记点的Z轴显示顺序 */
  val zIndex: Long? = null,
  /** 标记点是否支持拖动 */
  val draggable: Boolean? = null,
  /** 标记点的图标信息 */
  val icon: Bitmap? = null,
  /** 标记点的锚点 */
  val anchor: Anchor? = null

) {
  companion object {
    fun fromList(list: List<Any?>): MarkerUpdateOptions {
      val position: Position? = (list[0] as List<Any?>?)?.let {
        Position.fromList(it)
      }
      val alpha = list[1] as Double?
      val rotation = list[2] as Double?
      val zIndex = list[3].let { if (it is Int) it.toLong() else it as Long? }
      val draggable = list[4] as Boolean?
      val icon: Bitmap? = (list[5] as List<Any?>?)?.let {
        Bitmap.fromList(it)
      }
      val anchor: Anchor? = (list[6] as List<Any?>?)?.let {
        Anchor.fromList(it)
      }
      return MarkerUpdateOptions(position, alpha, rotation, zIndex, draggable, icon, anchor)
    }
  }

  fun toList(): List<Any?> {
    return listOf(
      position?.toList(),
      alpha,
      rotation,
      zIndex,
      draggable,
      icon?.toList(),
      anchor?.toList(),
    )
  }
}

/** 地图兴趣点 */
data class Poi(
  /** 兴趣点的名称 */
  val name: String,
  /** 兴趣点的位置 */
  val position: Position

) {
  companion object {
    fun fromList(list: List<Any?>): Poi {
      val name = list[0] as String
      val position = Position.fromList(list[1] as List<Any?>)
      return Poi(name, position)
    }
  }

  fun toList(): List<Any?> {
    return listOf(
      name,
      position.toList(),
    )
  }
}

/** 位置 */
data class Position(
  /** 位置的纬度 */
  val latitude: Double,
  /** 位置的经度 */
  val longitude: Double

) {
  companion object {
    fun fromList(list: List<Any?>): Position {
      val latitude = list[0] as Double
      val longitude = list[1] as Double
      return Position(latitude, longitude)
    }
  }

  fun toList(): List<Any?> {
    return listOf<Any?>(
      latitude,
      longitude,
    )
  }
}

/** 地图区域 */
data class Region(
  /** 最北的纬度 */
  val north: Double,
  /** 最东的经度 */
  val east: Double,
  /** 最南的纬度 */
  val south: Double,
  /** 最西的经度 */
  val west: Double

) {
  companion object {
    fun fromList(list: List<Any?>): Region {
      val north = list[0] as Double
      val east = list[1] as Double
      val south = list[2] as Double
      val west = list[3] as Double
      return Region(north, east, south, west)
    }
  }

  fun toList(): List<Any?> {
    return listOf(
      north,
      east,
      south,
      west,
    )
  }
}

/** UI控件位置偏移 */
data class UIControlOffset(
  /** X轴方向的位置偏移 */
  val x: Double,
  /** Y轴方向的位置偏移 */
  val y: Double

) {
  companion object {
    fun fromList(list: List<Any?>): UIControlOffset {
      val x = list[0] as Double
      val y = list[1] as Double
      return UIControlOffset(x, y)
    }
  }

  fun toList(): List<Any?> {
    return listOf<Any?>(
      x,
      y,
    )
  }
}

/** UI控件位置 */
data class UIControlPosition(
  /** UI控件位置锚点 */
  val anchor: UIControlAnchor,
  /** UI控件位置偏移 */
  val offset: UIControlOffset

) {
  companion object {
    fun fromList(list: List<Any?>): UIControlPosition {
      val anchor = UIControlAnchor.ofRaw(list[0] as Int)!!
      val offset = UIControlOffset.fromList(list[1] as List<Any?>)
      return UIControlPosition(anchor, offset)
    }
  }

  fun toList(): List<Any?> {
    return listOf<Any?>(
      anchor.raw,
      offset.toList(),
    )
  }
}
