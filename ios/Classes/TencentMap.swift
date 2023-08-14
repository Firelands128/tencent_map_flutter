import Flutter
import QMapKit

class TencentMap: NSObject, FlutterPlatformView, QMapViewDelegate {
  let mapView: QMapView

  init(_ registrar: FlutterPluginRegistrar) {
    mapView = QMapView()
    super.init()
    mapView.delegate = self
    TencentMapApiSetup.setUp(binaryMessenger: registrar.messenger(), api: _TencentMapApi(self))
  }

  func view() -> UIView {
    mapView
  }
}
