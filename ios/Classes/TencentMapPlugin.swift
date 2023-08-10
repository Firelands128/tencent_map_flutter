import Flutter
import UIKit

public class TencentMapPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    registrar.register(TencentMapFactory(registrar: registrar), withId: "tencent_map")
    TencentMapSdkApiSetup.setUp(binaryMessenger: registrar.messenger(), api: _TencentMapSdkApi())
  }
}
