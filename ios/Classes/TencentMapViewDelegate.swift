//
//  TencentMapViewDelegate.swift
//  tencent_map
//
//  Created by Wenqi Li on 2023/8/22.
//

import Foundation
import Flutter
import QMapKit

class TencentMapViewDelegate: NSObject, QMapViewDelegate {
  let registrar: FlutterPluginRegistrar
  let mapView: QMapView
  let mapHandler: TencentMapHandler

  init(_ registrar: FlutterPluginRegistrar, mapView: QMapView) {
    self.registrar = registrar
    self.mapView = mapView
    mapHandler = TencentMapHandler(binaryMessenger: registrar.messenger())
  }

  func mapView(_ mapView: QMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    mapHandler.onTap(latLng: coordinate.latLng, completion: { })
  }

  func mapView(_ mapView: QMapView!, viewFor annotation: QAnnotation!) -> QAnnotationView! {
    if(annotation is QPointAnnotation) {
      let point = annotation as! QPointAnnotation
      let annotationIdentifier = "pointAnnotation"
      var pinView = self.mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
      if (pinView == nil) {
        pinView = QPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        if let userData = point.userData as? Dictionary<String, AnyObject> {
          var image: UIImage?
          if let bitmap = userData["icon"] as? Bitmap {
            if let asset = bitmap.asset {
              let key = registrar.lookupKey(forAsset: asset)
              if let path = Bundle.main.path(forResource: key, ofType: nil) {
                image = UIImage(contentsOfFile: path)
              }
            }
            if let bytes = bitmap.bytes {
              image = UIImage(data: bytes.data)
            }
          } else {
            image = pinView?.image
          }
          if let cgImage = image?.cgImage {
            let orientation = userData["orientation"] as? UIImage.Orientation ?? UIImage.Orientation.up
            image = UIImage(cgImage: cgImage, scale: 4, orientation: orientation)
          }
          if let alpha = userData["alpha"] as? Double {
            image = image?.withAlpha(alpha)
          }
          pinView?.image = image
          if let anchor = userData["anchor"] as? CGPoint {
            if #available(iOS 16.0, *) {
              pinView?.anchorPoint = anchor
            }
          }
          if let zIndex = userData["zIndex"] as? Int32 {
            pinView?.zIndex = zIndex
          }
          if let draggable = userData["draggable"] as? Bool {
            pinView?.isDraggable = draggable
          }
        }
      }
      return pinView
    }
    return nil
  }
}