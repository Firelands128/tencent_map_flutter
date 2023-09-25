package com.morbit.tencent_map

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

/**
 * 定位模式
 *
 * 在地图的各种应用场景中，用户对定位点展示时也希望地图能跟随定位点旋转、移动等多种行为
 */
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

/**
 * UI控件位置
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
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

/**
 * UI控件位置偏移
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
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

/**
 * 点标记图标锚点
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
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

/**
 * 位置
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
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

/**
 * 定位点
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
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

/**
 * 地图兴趣点
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
data class MapPoi(
  /** 兴趣点的名称 */
  val name: String,
  /** 兴趣点的位置 */
  val position: Position

) {
  companion object {
    fun fromList(list: List<Any?>): MapPoi {
      val name = list[0] as String
      val position = Position.fromList(list[1] as List<Any?>)
      return MapPoi(name, position)
    }
  }

  fun toList(): List<Any?> {
    return listOf(
      name,
      position.toList(),
    )
  }
}

/**
 * 地图视野
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
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

/**
 * 地图区域
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
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

/**
 * 视野边缘宽度
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
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

/**
 * 标记点配置属性
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
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

/** Generated class from Pigeon that represents data sent in messages. */
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

/**
 * 图片信息
 *
 * Generated class from Pigeon that represents data sent in messages.
 */
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