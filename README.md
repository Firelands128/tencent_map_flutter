# Tencent Map for Flutter

<?code-excerpt path-base="example/lib"?>

[![pub package](https://img.shields.io/pub/v/tencent_map_flutter.svg)](https://pub.dev/packages/tencent_map_flutter)

A Flutter plugin that provides a [Tencent Map](https://lbs.qq.com/map/) widget.

|             | Android | iOS     |
|-------------|---------|---------|
| **Support** | SDK 21+ | iOS 12+ |

## Usage

To use this plugin, add `tencent_map_flutter` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/platform-integration/platform-channels).

## Getting Started

Log in to the Tencent Map Services console to get an API key at <https://lbs.qq.com/dev/console/application/mine>;
* Go to [Tencent Map Service Console](https://lbs.qq.com/dev/console/home), expand the Application Management menu and select My Apps;
* Click Create Application on the right, if you have already created an application, you can directly select Add Key;
* Check the Map SDK feature in the panel, and optionally enter the authorization package name in the input box below (the key can only be used by the app corresponding to the package name);

### Android

1. Set the `minSdkVersion` in `example/android/app/build.gradle`:

```groovy
android {
    defaultConfig {
        minSdkVersion 21
    }
}
```

This means that app will only be available for users that run Android SDK 21 or higher.

2. Specify your API key in the application manifest `example/android/app/src/main/AndroidManifest.xml`:

```xml
<manifest ...>
  <application ...>
    <meta-data
      android:name="TencentMapSDK"
      android:value="YOUR KEY HERE"/>
```

### iOS

To set up, specify your API key in the application delegate `ios/Runner/AppDelegate.m`:

```objectivec
#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <QMapKit/QMapKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [QMapServices sharedServices].APIKey = @"YOUR KEY HERE";
    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
```

Or in your swift code, specify your API key in the application delegate `ios/Runner/AppDelegate.swift`:

```swift
import UIKit
import Flutter
import QMapKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    QMapServices.shared().apiKey = "YOUR KEY HERE"
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### All

* You can now add a `TencentMap` widget to your widget tree. The `TencentMap` widget should be used within a widget with a bounded size. Using it in an unbounded widget will cause the application to throw a Flutter exception.
* Note: You have to agree privacy before build TencentMap by calling ```TencentMap.agreePrivacy()```.



### Sample Usage

<?code-excerpt "readme_sample.dart (MapSample)"?>
```dart
class MapTypesPage extends StatefulWidget {
  const MapTypesPage({Key? key}) : super(key: key);

  static const title = 'tecenc_map_example';

  @override
  State<MapTypesPage> createState() => _MapTypesPageState();
}

class _MapTypesPageState extends State<MapTypesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MapTypesPage.title),
      ),
      body: TencentMap(),
    );
  }
}
```

See the `example` directory for a complete sample app.