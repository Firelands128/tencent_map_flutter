import Flutter
import QMapKit

class TencentMap: NSObject, FlutterPlatformView {
  let mapView: QMapView
  let mapViewDelegate: TencentMapViewDelegate

  init(frame: CGRect, viewId: Int64, registrar: FlutterPluginRegistrar, args: [String: Any?]?) {
    mapView = QMapView()
    let api = _TencentMapApi(mapView: mapView)
    let controller = TencentMapController(viewId: viewId, registrar: registrar, api: api)
    mapViewDelegate = TencentMapViewDelegate(registrar, mapView: mapView, controller: controller)
    super.init()
    mapView.delegate = mapViewDelegate
    mapView.showsUserLocation = true
  }

  func view() -> UIView {
    mapView
  }
}
