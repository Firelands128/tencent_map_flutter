import Flutter
import QMapKit

class TencentMap: NSObject, FlutterPlatformView {
  let mapView: QMapView
  let mapViewDelegate: TencentMapViewDelegate
  var markers = [String: QPointAnnotation]()

  init(_ registrar: FlutterPluginRegistrar, args: [String: Any?]?) {
    mapView = QMapView()
    mapViewDelegate = TencentMapViewDelegate(registrar, mapView: mapView)
    super.init()
    mapView.delegate = mapViewDelegate
    mapView.showsUserLocation = true
    TencentMapApiSetup.setUp(binaryMessenger: registrar.messenger(), api: _TencentMapApi(self))
  }

  func view() -> UIView {
    mapView
  }
}
