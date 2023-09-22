import QMapKit
import Flutter

class _TencentMapApi: NSObject {
  let mapView: QMapView
  var markers: [String: QPointAnnotation]

  init(mapView: QMapView, markers: [String: QPointAnnotation]) {
    self.mapView = mapView
    self.markers = markers
  }

  func agreePrivacy(agreePrivacy: Bool) {
    QMapServices.shared().setPrivacyAgreement(agreePrivacy)
  }

  func setMapType(type: MapType) {
    mapView.mapType = [
      MapType.dark: QMapType.dark,
      MapType.normal: QMapType.standard,
      MapType.satellite: QMapType.satellite,
    ][type] ?? QMapType.standard
  }

  func setMapStyle(index: Int64) {
    mapView.setMapStyle(Int32(index))
  }

  func setLogoScale(scale: Double) {
    mapView.setLogoScale(scale)
  }

  func setLogoPosition(position: UIControlPosition) {
    mapView.setLogoMargin(position.offset.offset, anchor: position.anchor.anchor)
  }

  func setScalePosition(position: UIControlPosition) {
    mapView.setScaleOffset(CGPointMake(position.offset.x, -position.offset.y))
  }

  func setCompassOffset(offset: UIControlOffset) {
    mapView.setCompassOffset(offset.offset)
  }

  func setCompassEnabled(enabled: Bool) {
    mapView.showsCompass = enabled
  }

  func setScaleEnabled(enabled: Bool) {
    mapView.showsScale = enabled
  }

  func setScaleFadeEnabled(enabled: Bool) {
    mapView.setScaleFadeEnable(enabled)
  }

  func setRotateGesturesEnabled(enabled: Bool) {
    mapView.isRotateEnabled = enabled
  }

  func setScrollGesturesEnabled(enabled: Bool) {
    mapView.isScrollEnabled = enabled
  }

  func setZoomGesturesEnabled(enabled: Bool) {
    mapView.isZoomEnabled = enabled
  }

  func setSkewGesturesEnabled(enabled: Bool) {
    mapView.isOverlookingEnabled = enabled
  }

  func setIndoorViewEnabled(enabled: Bool) {
    mapView.setIndoorEnabled(enabled)
  }

  func setIndoorPickerEnabled(enabled: Bool) {
    mapView.indoorPicker = enabled
  }

  func setTrafficEnabled(enabled: Bool) {
    mapView.showsTraffic = enabled
  }

  func setBuildingsEnabled(enabled: Bool) {
    mapView.showsBuildings = enabled
  }

  func setBuildings3dEnabled(enabled: Bool) {
    mapView.shows3DBuildings = enabled
  }

  func setMyLocationEnabled(enabled: Bool) {
    mapView.showsUserLocation = enabled
  }

  func setUserLocationType(type: UserLocationType) {
    if(mapView.showsUserLocation) {
      if let trackingMode = type.trackingMode {
        mapView.setUserTrackingMode(trackingMode, animated: false)
      }
    }
  }

  func getUserLocation() -> Location {
    return mapView.userLocation.toLocation
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

  func start() { }

  func pause() { }

  func resume() { }

  func stop() { }

  func destroy() { }
}
