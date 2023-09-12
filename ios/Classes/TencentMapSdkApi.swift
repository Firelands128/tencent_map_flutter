import QMapKit

class _TencentMapSdkApi: NSObject, TencentMapSdkApi {
  func agreePrivacy(agreePrivacy: Bool) throws {
    QMapServices.shared().setPrivacyAgreement(agreePrivacy)
  }
}

