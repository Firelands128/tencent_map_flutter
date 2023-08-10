import Flutter
import QMapKit

class TencentMapFactory: NSObject, FlutterPlatformViewFactory {
    let registrar: FlutterPluginRegistrar

    init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }

    func create(withFrame _: CGRect, viewIdentifier _: Int64, arguments _: Any?) -> FlutterPlatformView {
        MapView(registrar)
    }
}

class MapView: NSObject, FlutterPlatformView, QMapViewDelegate {
    let mapView: QMapView
    let api: _TencentMapApi

    init(_ registrar: FlutterPluginRegistrar) {
        mapView = QMapView()
        api = _TencentMapApi(mapView)
        TencentMapApiSetup.setUp(binaryMessenger: registrar.messenger(), api: api)
        super.init()
        mapView.delegate = self
    }

    func view() -> UIView {
        mapView
    }
}
