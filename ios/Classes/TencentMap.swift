import Flutter
import QMapKit

class TencentMap: NSObject, FlutterPlatformView {
  let mapView: QMapView
  let mapViewDelegate: TencentMapViewDelegate
  var markers = [UUID: QPointAnnotation]()

  init(_ registrar: FlutterPluginRegistrar, args: [String: Any?]?) {
    mapView = QMapView()
    mapViewDelegate = TencentMapViewDelegate(registrar, mapView: mapView)
    super.init()
    mapView.delegate = mapViewDelegate
    mapView.showsUserLocation = true
    TencentMapApiSetup.setUp(binaryMessenger: registrar.messenger(), api: _TencentMapApi(self))
    MarkerApiSetup.setUp(binaryMessenger: registrar.messenger(), api: _MarkerApi(self))
  }

  func view() -> UIView {
    mapView
  }

  func hasKeyInMarkers(key: UUID) -> Bool {
    return markers[key] != nil
  }
}
