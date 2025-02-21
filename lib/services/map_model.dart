import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapModel extends ChangeNotifier {
  GoogleMapController? mapController;
  LatLng _initialPosition = LatLng(0, 0);
  bool _loading = true;

  LatLng get initialPosition => _initialPosition;
  bool get loading => _loading;

  void setMapController(GoogleMapController controller) {
    mapController = controller;
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return Future.error('Location services are disabled.');
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permissionGranted == PermissionStatus.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    locationData = await location.getLocation();
    _initialPosition = LatLng(locationData.latitude!, locationData.longitude!);
    _loading = false;
    notifyListeners();
  }
}
