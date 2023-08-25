import QMapKit
import Flutter

extension FlutterError: Error { }

extension LatLng {
  var latLng: CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(latitude, longitude)
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
    annotation.coordinate = position.latLng
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
    var point: CGPoint?
    if let anchor = anchor {
      switch orientation {
      case UIImage.Orientation.up:
        point = CGPoint(x: anchor.x, y: anchor.y)
        break
      case UIImage.Orientation.right:
        point = CGPoint(x: 1 - anchor.y, y: anchor.x)
        break
      case UIImage.Orientation.down:
        point = CGPoint(x: 1 - anchor.x, y: 1 - anchor.y)
        break
      case UIImage.Orientation.left:
        point = CGPoint(x: anchor.y, y: 1 - anchor.x)
        break
      default:
        point = CGPoint(x: 0.5, y: 0.5)
      }
    }
    annotation.userData = [
      "alpha": alpha,
      "orientation": orientation,
      "zIndex": zIndex != nil ? Int32(zIndex!) : nil,
      "draggable": draggable,
      "icon": icon,
      "anchor": point,
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
