import 'package:flutter/material.dart';
import 'package:tencent_map/tencent_map.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late TencentMapController controller;

  @override
  void initState() {
    super.initState();
    Permission.location.request();
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('定位')),
      body: TencentMap(
        mapType: context.isDark ? MapType.dark : MapType.normal,
        androidTexture: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        myLocationStyle: MyLocationStyle(
          myLocationType: MyLocationType.followNoCenter,
        ),
        onLocation: (location) {
          controller.moveCamera(
            CameraPosition(
              target: location.position,
              bearing: location.bearing,
              tilt: null,
              zoom: null,
            ),
          );
        },
        onMapCreated: (controller) async {
          this.controller = controller;
          controller.moveCamera(
            CameraPosition(
              target: Position(latitude: 39.909, longitude: 116.397),
            ),
          );
          controller.setMyLocation(
            Location(
              position: Position(latitude: 39.909, longitude: 116.397),
              accuracy: 1000,
            ),
          );
        },
      ),
    );
  }
}
