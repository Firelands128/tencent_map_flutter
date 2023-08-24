//
//  MarkerApi.swift
//  tencent_map
//
//  Created by Wenqi Li on 2023/8/23.
//

import Foundation
import Flutter
import QMapKit

class _MarkerApi: NSObject, MarkerApi {
  let tencentMap: TencentMap

  init(_ tencentMap: TencentMap) {
    self.tencentMap = tencentMap
  }

  func remove(id: String) throws {
    if let uuid = UUID(uuidString: id) {
      let annotation = tencentMap.markers[uuid]
      if (annotation != nil) {
        tencentMap.mapView.removeAnnotation(annotation)
        tencentMap.markers.removeValue(forKey: uuid)
      }
    }
  }

  func setRotation(id: String, rotation: Double) throws {
    throw FlutterError(code: "505", message: "Not supported on iOS platform.", details: nil)
  }

  func setPosition(id: String, position: LatLng) throws {
    throw FlutterError(code: "505", message: "Not supported on iOS platform.", details: nil)
  }

  func setAnchor(id: String, x: Double, y: Double) throws {
    throw FlutterError(code: "505", message: "Not supported on iOS platform.", details: nil)
  }

  func setZIndex(id: String, zIndex: Int64) throws {
    throw FlutterError(code: "505", message: "Not supported on iOS platform.", details: nil)
  }

  func setAlpha(id: String, alpha: Double) throws {
    throw FlutterError(code: "505", message: "Not supported on iOS platform.", details: nil)
  }

  func setIcon(id: String, icon: Bitmap) throws {
    throw FlutterError(code: "505", message: "Not supported on iOS platform.", details: nil)
  }

  func setDraggable(id: String, draggable: Bool) throws {
    throw FlutterError(code: "505", message: "Not supported on iOS platform.", details: nil)
  }
}
