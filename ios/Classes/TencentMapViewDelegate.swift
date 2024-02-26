//
//  TencentMapViewDelegate.swift
//  tencent_map_flutter
//
//  Created by Wenqi Li on 2023/8/22.
//

import Foundation
import Flutter
import QMapKit

class TencentMapViewDelegate: NSObject, QMapViewDelegate {
  let registrar: FlutterPluginRegistrar
  let mapView: QMapView
  let controller: TencentMapController

  init(_ registrar: FlutterPluginRegistrar, mapView: QMapView, controller: TencentMapController) {
    self.registrar = registrar
    self.mapView = mapView
    self.controller = controller
  }

  func mapView(_ mapView: QMapView!, scaleViewChanged scale: CGFloat) {
    controller.onScaleViewChanged(scale: scale)
  }

  func mapView(_ mapView: QMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    controller.onPress(position: coordinate.position)
  }

  func mapView(_ mapView: QMapView!, didTapPoi poi: QPoiInfo!) {
    controller.onTapPoi(poi: poi.poi)
  }

  func mapView(_ mapView: QMapView!, regionWillChangeAnimated animated: Bool, gesture bGesture: Bool) {
    controller.onCameraMoveStart(cameraPosition: mapView.cameraPosition)
  }

  func mapViewRegionChange(_ mapView: QMapView!) {
    controller.onCameraMove(cameraPosition: mapView.cameraPosition)
  }

  func mapView(_ mapView: QMapView!, regionDidChangeAnimated animated: Bool, gesture bGesture: Bool) {
    controller.onCameraMoveEnd(cameraPosition: mapView.cameraPosition)
  }

  func mapView(_ mapView: QMapView!, didUpdate userLocation: QUserLocation!, fromHeading: Bool) {
      controller.onLocation(location: userLocation.toLocation)
    }

  func mapView(_ mapView: QMapView!, didTapMyLocation location: CLLocationCoordinate2D) {
    controller.onUserLocationClick(position: location.position)
  }

  func mapView(_ mapView: QMapView!, annotationView view: QAnnotationView!, didChange newState: QAnnotationViewDragState, fromOldState oldState: QAnnotationViewDragState) {
    if let annotation = view.annotation as? QPointAnnotation {
      let position = annotation.coordinate.position
      if let userData = annotation.userData as? [String: Any?] {
        if let markerId = userData["id"] as? String {
          if(newState == QAnnotationViewDragStateStarting) {
            controller.onMarkerDragStart(markerId: markerId, position: position)
          } else if(newState == QAnnotationViewDragStateDragging) {
            controller.onMarkerDrag(markerId: markerId, position: position)
          } else if(newState == QAnnotationViewDragStateEnding) {
            controller.onMarkerDragEnd(markerId: markerId, position: position)
          }
        }
      }
    }
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
