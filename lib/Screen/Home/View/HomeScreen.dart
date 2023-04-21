import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:n_location_app_map/Screen/Home/Controllor/HomeControllor.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeControllor homeControllor = Get.put(
    HomeControllor(),
  );

  @override
  void initState() {
    super.initState();
    AddPermissio();
  }

  Future<void> AddPermissio() async {
    var Status = await Permission.location.status;

    if (Status.isDenied) {
      await Permission.location.request();
    }
  }

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            Expanded(
              child: Obx(
                () => GoogleMap(
                  onMapCreated: (controller) {
                    _controller.complete(controller);
                  },
                  mapType: MapType.hybrid,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      homeControllor.lat.value,
                      homeControllor.lon.value,
                    ),
                    zoom: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        // fx
      ),
    );
  }
}
