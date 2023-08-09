import QMapKit

class _TencentMapSdkApi: NSObject, TencentMapSdkApi {
    func initSdk(iosApiKey: String?, agreePrivacy: Bool) throws {
        if iosApiKey != nil {
            QMapServices.shared().apiKey = iosApiKey!
        }
      QMapServices.shared().setPrivacyAgreement(agreePrivacy)
    }
}

