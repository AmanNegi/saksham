import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swaraksha/globals.dart';

class LocationHelper {
  static Future<LatLng?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool res = await Geolocator.openLocationSettings();
      showToast("Location services are disabled.");
      if (!res) return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToast("Location permissions are denied");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      String errorMessage =
          "Location permissions are permanently denied, we cannot request permissions.";
      showToast(errorMessage);
      return null;
    }

    try {
      final pos = await Geolocator.getCurrentPosition();
      final currentLatLng = LatLng(pos.latitude, pos.longitude);
      return currentLatLng;
    } catch (e) {
      return null;
    }
  }
}
