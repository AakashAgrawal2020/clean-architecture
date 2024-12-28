import 'package:geolocator/geolocator.dart';

Position? currentLocation;

Future<Position?> requestLocationPermission({bool openSettings = false}) async {
  // Check the current location permission
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return currentLocation;
    }
  }

  if (permission == LocationPermission.deniedForever && openSettings) {
    await Geolocator.openLocationSettings();
    return currentLocation;
  }

  // If permissions are granted, fetch the current location
  if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
    try {
      currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {}
  }

  return currentLocation;
}