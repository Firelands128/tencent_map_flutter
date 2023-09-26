import QMapKit
import Flutter

extension FlutterError: Error { }

extension Position {
  var coordinate: CLLocationCoordinate2D {
    return CLLocationCoordinate2DMake(latitude, longitude)
  }
}

extension CLLocationCoordinate2D {
  var position: Position {
    return Position(latitude: latitude, longitude: longitude)
  }
}

extension Region {
  var region: QCoordinateRegion {
    return QCoordinateRegionMake(
      CLLocationCoordinate2DMake((north + south) / 2, (east + west) / 2),
      QCoordinateSpanMake(north - south, east - west)
    )
  }
}

extension EdgePadding {
  var padding: UIEdgeInsets {
    return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
  }
}

extension RestrictRegionMode {
  var restrictMode: QMapLimitRectFitMode {
    switch(self) {
    case .fitWidth:
      return QMapLimitRectFitMode.width
    case .fitHeight:
      return QMapLimitRectFitMode.height
    }
  }
}

extension UIControlAnchor {
  var anchor: QMapLogoAnchor {
    switch(self) {
    case .bottomLeft:
      return QMapLogoAnchor.leftBottom
    case .bottomRight:
      return QMapLogoAnchor.rightBottom
    case .topLeft:
      return QMapLogoAnchor.leftTop
    case .topRight:
      return QMapLogoAnchor.rightTop
    }
  }
}

extension UIControlOffset {
  var offset: CGPoint {
    return CGPoint(x: x, y: y)
  }
}

extension Marker {
  func update(_ options: MarkerUpdateOptions) -> Marker {
    return Marker(
      id: self.id,
      position: options.position ?? self.position,
      alpha: options.alpha ?? self.alpha,
      rotation: options.rotation ?? self.rotation,
      zIndex: options.zIndex ?? self.zIndex,
      draggable: options.draggable ?? self.draggable,
      icon: options.icon ?? self.icon,
      anchor: options.anchor ?? self.anchor
    )
  }
  var annotation: QPointAnnotation {
    let annotation = QPointAnnotation()
    annotation.coordinate = position.coordinate
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

extension QPointAnnotation {
  func marker(markerId: String) -> Marker {
    let position = coordinate.position
    var alpha: Double? = nil
    var rotation: Double? = nil
    var zIndex: Int64? = nil
    var draggable: Bool? = nil
    var icon: Bitmap? = nil
    var anchor: Anchor? = nil
    if let userData = userData as? [String: Any?] {
      alpha = userData["alpha"] as? Double
      if let orientation = userData["orientation"] as? UIImage.Orientation {
        switch orientation {
        case UIImage.Orientation.up:
          rotation = 0
          break
        case UIImage.Orientation.right:
          rotation = 90
          break
        case UIImage.Orientation.down:
          rotation = 180
          break
        case UIImage.Orientation.left:
          rotation = 270
          break
        default:
          rotation = 0
        }
      }
      if let z = userData["zIndex"] as? Int32 {
        zIndex = Int64(z)
      }
      draggable = userData["draggable"] as? Bool
      icon = userData["icon"] as? Bitmap
      if let point = userData["anchor"] as? CGPoint {
        if let orientation = userData["orientation"] as? UIImage.Orientation {
          switch orientation {
          case UIImage.Orientation.up:
            anchor = Anchor(x: point.x, y: point.y)
            break
          case UIImage.Orientation.right:
            anchor = Anchor(x: point.y, y: 1 - point.x)
            break
          case UIImage.Orientation.down:
            anchor = Anchor(x: 1 - point.x, y: 1 - point.y)
            break
          case UIImage.Orientation.left:
            anchor = Anchor(x: 1 - point.y, y: point.x)
            break
          default:
            anchor = Anchor(x: 0.5, y: 0.5)
          }
        }
      }
    }
    return Marker(
      id: markerId,
      position: position,
      alpha: alpha,
      rotation: rotation,
      zIndex: zIndex,
      draggable: draggable,
      icon: icon,
      anchor: anchor
    )
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
      position: centerCoordinate.position,
      heading: rotation,
      skew: overlooking,
      zoom: zoomLevel
    )
  }
}

extension QPoiInfo {
  var poi: Poi {
    return Poi(
      name: name,
      position: coordinate.position
    )
  }
}

extension QUserLocation {
  var toLocation: Location {
    return Location(
      position: location.coordinate.position,
      heading: heading?.trueHeading ?? location.course,
      accuracy: max(location.horizontalAccuracy, location.verticalAccuracy)
    )
  }
}

extension UserLocationType {
  var trackingMode: QUserTrackingMode? {
    switch (self) {
    case .trackingLocationRotate:
      return QUserTrackingMode.followWithHeading
    case .trackingLocation:
      return QUserTrackingMode.follow
    case .noTracking:
      return QUserTrackingMode.none
    default:
      return nil
    }
  }
}
