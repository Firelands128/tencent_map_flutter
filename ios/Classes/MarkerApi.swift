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
    if let uuid = UUID(uuidString: id) {
      var annotation = tencentMap.markers[uuid]
      if (annotation != nil) {
        tencentMap.mapView.removeAnnotation(annotation)
        var marker = annotation?.marker
        marker?.rotation = rotation
        annotation = marker?.annotation
        tencentMap.mapView.addAnnotation(annotation)
      }
    }
  }

  func setPosition(id: String, position: LatLng) throws {
    if let uuid = UUID(uuidString: id) {
      let annotation = tencentMap.markers[uuid]
      if (annotation != nil) {
        tencentMap.mapView.removeAnnotation(annotation)
        annotation?.coordinate = position.coordinate
        tencentMap.mapView.addAnnotation(annotation)
      }
    }
  }

  func setAnchor(id: String, x: Double, y: Double) throws {
    if let uuid = UUID(uuidString: id) {
      var annotation = tencentMap.markers[uuid]
      if (annotation != nil) {
        tencentMap.mapView.removeAnnotation(annotation)
        var marker = annotation?.marker
        marker?.anchor = Anchor(x: x, y: y)
        annotation = marker?.annotation
        tencentMap.mapView.addAnnotation(annotation)
      }
    }
  }

  func setZIndex(id: String, zIndex: Int64) throws {
    if let uuid = UUID(uuidString: id) {
      var annotation = tencentMap.markers[uuid]
      if (annotation != nil) {
        tencentMap.mapView.removeAnnotation(annotation)
        var marker = annotation?.marker
        marker?.zIndex = zIndex
        annotation = marker?.annotation
        tencentMap.mapView.addAnnotation(annotation)
      }
    }
  }

  func setAlpha(id: String, alpha: Double) throws {
    if let uuid = UUID(uuidString: id) {
      var annotation = tencentMap.markers[uuid]
      if (annotation != nil) {
        tencentMap.mapView.removeAnnotation(annotation)
        var marker = annotation?.marker
        marker?.alpha = alpha
        annotation = marker?.annotation
        tencentMap.mapView.addAnnotation(annotation)
      }
    }
  }

  func setIcon(id: String, icon: Bitmap) throws {
    if let uuid = UUID(uuidString: id) {
      var annotation = tencentMap.markers[uuid]
      if (annotation != nil) {
        tencentMap.mapView.removeAnnotation(annotation)
        var marker = annotation?.marker
        marker?.icon = icon
        annotation = marker?.annotation
        tencentMap.mapView.addAnnotation(annotation)
      }
    }
  }

  func setDraggable(id: String, draggable: Bool) throws {
    if let uuid = UUID(uuidString: id) {
      var annotation = tencentMap.markers[uuid]
      if (annotation != nil) {
        tencentMap.mapView.removeAnnotation(annotation)
        var marker = annotation?.marker
        marker?.draggable = draggable
        annotation = marker?.annotation
        tencentMap.mapView.addAnnotation(annotation)
      }
    }
  }
}
