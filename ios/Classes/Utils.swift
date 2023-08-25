import QMapKit
import Flutter

extension FlutterError: Error { }

extension LatLng {
  var latLng: CLLocationCoordinate2D? {
    if latitude != nil, longitude != nil {
      return CLLocationCoordinate2DMake(latitude!, longitude!)
    }
    return nil
  }
}

extension CLLocationCoordinate2D {
  var latLng: LatLng {
    return LatLng(latitude: latitude, longitude: longitude)
  }
}

extension MarkerOptions {
  var annotation: QPointAnnotation {
    let annotation = QPointAnnotation()
    if(position.latitude != nil && position.longitude != nil) {
      annotation.coordinate = CLLocationCoordinate2DMake(position.latitude!, position.longitude!)
    }
    let orientation = {
      switch rotation {
      case 0:
        return UIImage.Orientation.up
      case 90:
        return UIImage.Orientation.right
      case 180:
        return UIImage.Orientation.down
      case 270:
        return UIImage.Orientation.left
      default:
        return UIImage.Orientation.up
      }
    }()
    var anchorPoint: CGPoint?
    if let anchorList = anchor {
      let x: Double; let y: Double
      switch orientation {
      case UIImage.Orientation.up:
        x = anchorList[0] ?? 0.5
        y = anchorList[1] ?? 0.5
        break
      case UIImage.Orientation.right:
        x = 1 - (anchorList[1] ?? 0.5)
        y = anchorList[0] ?? 0.5
        break
      case UIImage.Orientation.down:
        x = 1 - (anchorList[0] ?? 0.5)
        y = 1 - (anchorList[1] ?? 0.5)
        break
      case UIImage.Orientation.left:
        x = anchorList[1] ?? 0.5
        y = 1 - (anchorList[0] ?? 0.5)
        break
      default:
        x = 0.5
        y = 0.5
      }
      anchorPoint = CGPoint(x: x, y: y)
    }
    annotation.userData = [
      "alpha": alpha,
      "orientation": orientation,
      "zIndex": zIndex != nil ? Int32(zIndex!) : nil,
      "draggable": draggable,
      "icon": icon,
      "anchor": anchorPoint,
    ] as [String: Any?]
    return annotation
  }
}

extension UIImage {
  func withAlpha(_ a: CGFloat) -> UIImage {
    return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
      draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
    }
  }
}

extension QMapView {
  var cameraPosition: CameraPosition {
    return CameraPosition(
      bearing: rotation,
      target: centerCoordinate.latLng,
      tilt: overlooking,
      zoom: zoomLevel
    )
  }
}

extension QPoiInfo {
  var poi: MapPoi {
    return MapPoi(
      name: name,
      position: coordinate.latLng
    )
  }
}
