import Flutter
import QMapKit

class TencentMapFactory: NSObject, FlutterPlatformViewFactory {
  let registrar: FlutterPluginRegistrar

  init(registrar: FlutterPluginRegistrar) {
    self.registrar = registrar
  }

  func create(withFrame _: CGRect, viewIdentifier _: Int64, arguments _: Any?) -> FlutterPlatformView {
    TencentMap(registrar)
  }
}

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
