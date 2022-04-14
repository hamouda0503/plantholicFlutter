import '../utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


const GPS_DISABLE = 1;
const LOCATION_PERMISSION_DENIED = 2;
const LOCATION_PERMISSION_DENIED_FOREVER = 3;

class Location {
   double latitude;
   double longitude;

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      showSnackMessage(context, GPS_DISABLE);
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        showSnackMessage(context, LOCATION_PERMISSION_DENIED);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      showSnackMessage(context, LOCATION_PERMISSION_DENIED_FOREVER);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
        .then((value) => {
              latitude = value.latitude,
              longitude = value.longitude,
            });
  }

  void showSnackMessage(BuildContext context, int type) {
    String text = "";
    if (type == GPS_DISABLE) {
      text = "Please enable your GPS.";
    } else if (type == LOCATION_PERMISSION_DENIED) {
      text = "You need to give location permission to use the application.";
    } else if (type == LOCATION_PERMISSION_DENIED_FOREVER) {
      text = "You need to give location permission to use the application. Please give Location permission in application settings.";
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: kSubHeadlinePrimaryTextStyle,
      ),
      duration: const Duration(seconds: 5),
    ));
  }
}
