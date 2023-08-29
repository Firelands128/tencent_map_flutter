import Flutter

class TencentMapFactory: NSObject, FlutterPlatformViewFactory {
  let registrar: FlutterPluginRegistrar

  init(registrar: FlutterPluginRegistrar) {
    self.registrar = registrar
  }

  func create(withFrame _: CGRect, viewIdentifier _: Int64, arguments: Any?) -> FlutterPlatformView {
    TencentMap(registrar, args: arguments as? [String: Any?])
  }

  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    return FlutterStandardMessageCodec.sharedInstance()
  }
}
