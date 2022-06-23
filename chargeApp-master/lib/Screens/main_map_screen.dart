import 'dart:async';

import 'package:charging_app/Screens/qr_sacn_screen.dart';
import 'package:charging_app/assistants/assistant_methods.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Charge_map_screen extends StatefulWidget {
  const Charge_map_screen({Key? key}) : super(key: key);

  @override
  _Charge_map_screenState createState() => _Charge_map_screenState();
}

class _Charge_map_screenState extends State<Charge_map_screen> {
  LatLng temp = const LatLng(28.7041, 77.1025);
  String address = "";
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late Position userCurrentPosition;
  LocationPermission? _locationPermission;
  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  GoogleMapController? newGoogleMapController;
  locateUserPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition = cPosition;

    LatLng latLngPosition =
        LatLng(userCurrentPosition.latitude, userCurrentPosition.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);

    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String humanReadableAddress =
        await AssistantMethods.searchAddressForGeographicCoOrdinates(
            userCurrentPosition, context);

    setState(() {
      address = humanReadableAddress;
    });

    print("this is your address = " + humanReadableAddress);
  }

  @override
  void initState() {
    super.initState();
    locateUserPosition();
    checkIfLocationPermissionAllowed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(target: temp, zoom: .0),
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
            },
          ),
          Positioned(
            top: 10,
            left: 40,
            right: 40,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        address.isEmpty
                            ? "Not Getting address"
                            : address.substring(0, 40) + "..",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: MediaQuery.of(context).size.width / 3,
            child: Container(
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(),
                child: Text("goto scan page"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Qr_scan_screen(),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    newGoogleMapController = controller;
  }
}
