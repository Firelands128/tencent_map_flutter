import QMapKit
import Flutter

class _TencentMapApi: NSObject {
  let mapView: QMapView
  var markers = [String: QPointAnnotation]()

  init(mapView: QMapView) {
    self.mapView = mapView
  }

  func updateMapConfig(config: MapConfig) {
    if let type = config.mapType {
      mapView.mapType = [
        MapType.dark: QMapType.dark,
        MapType.normal: QMapType.standard,
        MapType.satellite: QMapType.satellite,
      ][type] ?? QMapType.standard
    }
    if let index = config.mapStyle {
      mapView.setMapStyle(Int32(index))
    }
    if let scale = config.logoScale {
      mapView.setLogoScale(scale)
    }
    if let position = config.logoPosition {
      mapView.setLogoMargin(position.offset.offset, anchor: position.anchor.anchor)
    }
    if let position = config.scalePosition {
      mapView.setScaleOffset(CGPointMake(position.offset.x, -position.offset.y))
    }
    if let offset = config.compassOffset {
      mapView.setCompassOffset(offset.offset)
    }
    if let enabled = config.compassEnabled {
      mapView.showsCompass = enabled
    }
    if let enabled = config.scaleEnabled {
      mapView.showsScale = enabled
    }
    if let enabled = config.scaleFadeEnabled {
      mapView.setScaleFadeEnable(enabled)
    }
    if let enabled = config.rotateGesturesEnabled {
      mapView.isRotateEnabled = enabled
    }
    if let enabled = config.scrollGesturesEnabled {
      mapView.isScrollEnabled = enabled
    }
    if let enabled = config.zoomGesturesEnabled {
      mapView.isZoomEnabled = enabled
    }
    if let enabled = config.skewGesturesEnabled {
      mapView.isOverlookingEnabled = enabled
    }
    if let enabled = config.indoorViewEnabled {
      mapView.setIndoorEnabled(enabled)
    }
    if let enabled = config.indoorPickerEnabled {
      mapView.indoorPicker = enabled
    }
    if let enabled = config.trafficEnabled {
      mapView.showsTraffic = enabled
    }
    if let enabled = config.buildingsEnabled {
      mapView.showsBuildings = enabled
    }
    if let enabled = config.buildings3dEnabled {
      mapView.shows3DBuildings = enabled
    }
    if let enabled = config.myLocationEnabled {
      mapView.showsUserLocation = enabled
    }
  }

  func moveCamera(position: CameraPosition, duration: Int64) {
    let animated = duration > 0
    if let it = position.position?.coordinate { mapView.setCenter(it, animated: animated) }
    if let it = position.zoom { mapView.setZoomLevel(CGFloat(it), animated: animated) }
    if let it = position.skew { mapView.setOverlooking(CGFloat(it), animated: animated) }
    if let it = position.heading { mapView.setRotation(CGFloat(it), animated: animated) }
  }

  func moveCameraToRegion(region: Region, padding: EdgePadding, duration: Int64) {
    mapView.setRegion(region.region, edgePadding: padding.padding, animated: duration > 0)
  }

  func moveCameraToRegionWithPosition(positions: [Position?], padding: EdgePadding, duration: Int64) {
    let coordinates = positions.filter { position in position != nil }.map { position in position!.coordinate }
    let coordinatesPointer = UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(capacity: coordinates.count)
    coordinatesPointer.initialize(from: coordinates, count: coordinates.count)
    let region = QBoundingCoordinateRegionWithCoordinates(coordinatesPointer, UInt(coordinates.count))
    mapView.setRegion(region, animated: duration > 0)
  }

  func setRestrictRegion(region: Region, mode: RestrictRegionMode) {
    mapView.setLimitMapRect(QMapRectForCoordinateRegion(region.region), mode: mode.restrictMode)
  }

  func removeRestrictRegion() {
    mapView.setLimitMapRect(QMapRect(), mode: QMapLimitRectFitMode.width)
  }

  func addMarker(marker: Marker) {
    let annotation = marker.annotation
    markers[marker.id] = annotation
    mapView.addAnnotation(annotation)
  }

  func removeMarker(id: String) {
    if let annotation = markers[id] {
      mapView.removeAnnotation(annotation)
      markers.removeValue(forKey: id)
    }
  }

  func updateMarker(markerId: String, options: MarkerUpdateOptions) {
    if var annotation = markers[markerId] {
      mapView.removeAnnotation(annotation)
      var marker = annotation.marker(markerId: markerId)
      marker = marker.update(options)
      annotation = marker.annotation
      mapView.addAnnotation(annotation)
    }
  }

  func getUserLocation() -> Location {
    return mapView.userLocation.toLocation
  }

  func start() { }

  func pause() { }

  func resume() { }

  func stop() { }

  func destroy() { }
}
