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
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        myLocationStyle: MyLocationStyle(
          myLocationType: MyLocationType.followNoCenter,
        ),
        onLocation: (location) =>
            // ignore: avoid_print
            print('${location.latitude}, ${location.longitude}'),
        onMapCreated: (controller) async {
          controller.moveCamera(
            CameraPosition(
              target: LatLng(latitude: 39.909, longitude: 116.397),
            ),
          );
          controller.setMyLocation(
            Location(latitude: 39.909, longitude: 116.397, accuracy: 1000),
          );
        },
      ),
    );
  }
}
