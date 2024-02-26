import QMapKit
import Flutter

class _TencentMapSdkApi: NSObject {
  static func setup(registrar: FlutterPluginRegistrar) {
    let initializerChannel = FlutterMethodChannel(name: "plugins.flutter.dev/tencent_map_flutter_initializer", binaryMessenger: registrar.messenger())
    initializerChannel.setMethodCallHandler({ (call: FlutterMethodCall, result: FlutterResult) -> Void in
      if(call.method == "agreePrivacy") {
        let arguments = call.arguments as! Dictionary<String, AnyObject>
        let agree = arguments["agree"] as! Bool
        _TencentMapSdkApi.agreePrivacy(agreePrivacy: agree)
        result(nil)
      }
    })
  }

  static func agreePrivacy(agreePrivacy: Bool) {
    QMapServices.shared().setPrivacyAgreement(agreePrivacy)
  }
}

