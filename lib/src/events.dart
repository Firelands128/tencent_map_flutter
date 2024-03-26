part of '../tencent_map_flutter.dart';

/// Generic event used as a base class for all events that might be triggered from map.
abstract class MapEvent<T> {
  MapEvent(this.mapId, this.value);

  /// The ID of the Map this event is associated to.
  final int mapId;

  /// The value wrapped by this event
  final T value;
}

/// A `MapEvent` associated to a `position`.
class _PositionedMapEvent<T> extends MapEvent<T> {
  _PositionedMapEvent(int mapId, this.position, T value) : super(mapId, value);

  /// The position where this event happened.
  final Position position;
}

/// Event that scale view changed
class ScaleViewChangedEvent extends MapEvent<double> {
  ScaleViewChangedEvent(int mapId, double scale) : super(mapId, scale);
}

/// Event that pressed on map
class MapPressEvent extends _PositionedMapEvent<void> {
  MapPressEvent(int mapId, Position position) : super(mapId, position, null);
}

/// Event that long pressed on map
class MapLongPressEvent extends _PositionedMapEvent<void> {
  MapLongPressEvent(int mapId, Position position)
      : super(mapId, position, null);
}

/// Event that pressed on poi
class PoiTapEvent extends MapEvent<Poi> {
  PoiTapEvent(int mapId, Poi poi) : super(mapId, poi);
}

/// Event that camera move started
class CameraMoveStartEvent extends MapEvent<CameraPosition> {
  CameraMoveStartEvent(int mapId, CameraPosition position)
      : super(mapId, position);
}

/// Event that camera is moving
class CameraMoveEvent extends MapEvent<CameraPosition> {
  CameraMoveEvent(int mapId, CameraPosition position) : super(mapId, position);
}

/// Event that camera move ended
class CameraMoveEndEvent extends MapEvent<CameraPosition> {
  CameraMoveEndEvent(int mapId, CameraPosition position)
      : super(mapId, position);
}

/// Event that pressed on marker
class TapMarkerEvent extends MapEvent<String> {
  TapMarkerEvent(int mapId, String markerId) : super(mapId, markerId);
}

/// Event that marker drag started
class MarkerDragStartEvent extends _PositionedMapEvent<String> {
  MarkerDragStartEvent(int mapId, Position position, String markerId)
      : super(mapId, position, markerId);
}

/// Event that marker is dragging
class MarkerDragEvent extends _PositionedMapEvent<String> {
  MarkerDragEvent(int mapId, Position position, String markerId)
      : super(mapId, position, markerId);
}

/// Event that marker drag ended
class MarkerDragEndEvent extends _PositionedMapEvent<String> {
  MarkerDragEndEvent(int mapId, Position position, String markerId)
      : super(mapId, position, markerId);
}

/// Event that location changed
class LocationChangedEvent extends MapEvent<Location> {
  LocationChangedEvent(int mapId, Location location) : super(mapId, location);
}

/// Event that pressed on user location
class UserLocationClickEvent extends _PositionedMapEvent<void> {
  UserLocationClickEvent(int mapId, Position position)
      : super(mapId, position, null);
}
