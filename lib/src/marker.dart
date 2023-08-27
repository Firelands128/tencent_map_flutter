import 'pigeon.g.dart';

final _api = MarkerApi();

/// 标记点对象
class Marker {
  const Marker(this.id);

  /// 标记点ID
  final String id;

  /// 移除标记点
  void remove() => _api.remove(id);

  /// 更新标记点的位置
  void setPosition(Position position) => _api.setPosition(id, position);

  /// 更新标记点的图标
  void setIcon(Bitmap icon) => _api.setIcon(id, icon);

  /// 更新标记点的锚点
  void setAnchor(double x, double y) => _api.setAnchor(id, x, y);

  /// 更新标记点的透明度
  void setAlpha(double alpha) => _api.setAlpha(id, alpha);

  /// 更新标记点的旋转角度
  void setRotation(double rotation) => _api.setRotation(id, rotation);

  /// 更新标记点的Z轴显示顺序
  void setZIndex(int zIndex) => _api.setZIndex(id, zIndex);

  /// 更新标记点的是否可拖拽属性值
  void setDraggable(bool draggable) => _api.setDraggable(id, draggable);
}
