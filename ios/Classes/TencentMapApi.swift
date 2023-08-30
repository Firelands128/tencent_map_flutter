import QMapKit
import Flutter

class _TencentMapApi: NSObject, TencentMapApi {
  let tencentMap: TencentMap
  let mapView: QMapView

  init(_ tencentMap: TencentMap) {
    self.tencentMap = tencentMap
    self.mapView = tencentMap.mapView
  }

  func setMapType(type: MapType) throws {
    mapView.mapType = [
      MapType.dark: QMapType.dark,
      MapType.normal: QMapType.standard,
      MapType.satellite: QMapType.satellite,
    ][type] ?? QMapType.standard
  }

  func setMapStyle(index: Int64) throws {
    mapView.setMapStyle(Int32(index))
  }
  
  func setLogoScale(scale: Double) throws {
    mapView.setLogoScale(scale)
  }

  func setCompassEnabled(enabled: Bool) throws {
    mapView.showsCompass = enabled
  }

  func setScaleEnabled(enabled: Bool) throws {
    mapView.showsScale = enabled
  }
  
  func setScaleFadeEnabled(enabled: Bool) throws {
    mapView.setScaleFadeEnable(enabled)
  }

  func setRotateGesturesEnabled(enabled: Bool) throws {
    mapView.isRotateEnabled = enabled
  }

  func setScrollGesturesEnabled(enabled: Bool) throws {
    mapView.isScrollEnabled = enabled
  }

  func setZoomGesturesEnabled(enabled: Bool) throws {
    mapView.isZoomEnabled = enabled
  }

  func setSkewGesturesEnabled(enabled: Bool) throws {
    mapView.isOverlookingEnabled = enabled
  }

  func setIndoorViewEnabled(enabled: Bool) throws {
    mapView.setIndoorEnabled(enabled)
  }

  func setIndoorPickerEnabled(enabled: Bool) throws {
    mapView.indoorPicker = enabled
  }

  func setTrafficEnabled(enabled: Bool) throws {
    mapView.showsTraffic = enabled
  }

  func setBuildingsEnabled(enabled: Bool) throws {
    mapView.showsBuildings = enabled
  }

  func setBuildings3dEnabled(enabled: Bool) throws {
    mapView.shows3DBuildings = enabled
  }

  func setMyLocationEnabled(enabled: Bool) throws {
    mapView.showsUserLocation = enabled
  }

  func setUserLocationType(type: UserLocationType) throws {
    if(mapView.showsUserLocation) {
      if let trackingMode = type.trackingMode {
        mapView.setUserTrackingMode(trackingMode, animated: false)
      }
    }
  }

  func getUserLocation() throws -> Location {
    if(!mapView.showsUserLocation) {
      throw FlutterError(code: "400", message: "Location feature is not enabled.", details: nil)
    }
    if (mapView.userLocation == nil) {
      throw FlutterError(code: "500", message: "Failed to get user location.", details: nil)
    } else {
      return mapView.userLocation.toLocation
    }
  }

  func moveCamera(position: CameraPosition, duration: Int64) throws {
    let animated = duration > 0
    if let it = position.position?.coordinate { mapView.setCenter(it, animated: animated) }
    if let it = position.zoom { mapView.setZoomLevel(CGFloat(it), animated: animated) }
    if let it = position.skew { mapView.setOverlooking(CGFloat(it), animated: animated) }
    if let it = position.heading { mapView.setRotation(CGFloat(it), animated: animated) }
  }

  func moveCameraToRegion(region: Region, padding: EdgePadding, duration: Int64) throws {
    mapView.setRegion(region.region, edgePadding: padding.padding, animated: duration > 0)
  }

  func moveCameraToRegionWithPosition(positions: [Position?], padding: EdgePadding, duration: Int64) throws {
    let coordinates = positions.filter { position in position != nil }.map { position in position!.coordinate }
    let coordinatesPointer = UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(capacity: coordinates.count)
    coordinatesPointer.initialize(from: coordinates, count: coordinates.count)
    let region = QBoundingCoordinateRegionWithCoordinates(coordinatesPointer, UInt(coordinates.count))
    mapView.setRegion(region, animated: duration > 0)
  }
  
  func setRestrictRegion(region: Region, mode: RestrictRegionMode) throws {
    mapView.setLimitMapRect(QMapRectForCoordinateRegion(region.region), mode: mode.restrictMode)
  }
  

  func addMarker(options: MarkerOptions) throws -> String {
    var id = UUID()
    while(tencentMap.hasKeyInMarkers(key: id)) {
      id = UUID()
    }
    let annotation = options.annotation
    tencentMap.markers[id] = annotation
    mapView.addAnnotation(annotation)
    return id.uuidString
  }

  func addPolyline(options: PolylineOptions) throws -> String {
    return ""
  }

  func pause() throws { }

  func resume() throws { }

  func stop() throws { }

  func start() throws { }

  func destroy() throws { }
}
