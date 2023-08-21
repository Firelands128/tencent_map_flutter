import QMapKit
import Flutter

extension FlutterError: Error {}

extension LatLng {
  var latLng: CLLocationCoordinate2D? {
    if latitude != nil, longitude != nil {
      return CLLocationCoordinate2DMake(latitude!, longitude!)
    }
    return nil
  }
}
