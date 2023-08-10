import 'pigeon.g.dart';

final _api = MarkerApi();

class Marker {
  const Marker(this.id);

  final String id;

  void remove() => _api.remove(id);

  void setPosition(LatLng position) => _api.setPosition(id, position);

  void setAlpha(double alpha) => _api.setAlpha(id, alpha);

  void setRotation(double rotation) => _api.setRotation(id, rotation);

  void setIcon(Bitmap icon) => _api.setIcon(id, icon);

  void setAnchor(double x, double y) => _api.setAnchor(id, x, y);

  void setZIndex(int zIndex) => _api.setZIndex(id, zIndex);

  void setDraggable(bool draggable) => _api.setDraggable(id, draggable);
}
