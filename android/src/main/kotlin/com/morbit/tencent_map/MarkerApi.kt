package com.morbit.tencent_map

class _MarkerApi(tencentMap: TencentMap) : MarkerApi {
  private val binding = tencentMap.binding
  private val markers = tencentMap.markers

  override fun remove(id: String) {
    val marker = markers[id]
    if (marker != null) {
      marker.remove()
      markers.remove(id)
    }
  }

  override fun setPosition(id: String, position: Position) {
    markers[id]?.position = position.toPosition()
  }

  override fun setZIndex(id: String, zIndex: Long) {
    markers[id]?.zIndex = zIndex.toInt()
  }

  override fun setAnchor(id: String, anchor: Anchor) {
    markers[id]?.setAnchor(anchor.x.toFloat(), anchor.y.toFloat())
  }

  override fun setIcon(id: String, icon: Bitmap) {
    icon.toBitmapDescriptor(binding)?.let { markers[id]?.setIcon(it) }
  }

  override fun setDraggable(id: String, draggable: Boolean) {
    markers[id]?.isDraggable = draggable
  }

  override fun setAlpha(id: String, alpha: Double) {
    markers[id]?.alpha = alpha.toFloat()
  }

  override fun setRotation(id: String, rotation: Double) {
    markers[id]?.rotation = rotation.toFloat()
  }
}