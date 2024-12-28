import 'package:geolocator/geolocator.dart';

Position? currentLocation;

Future<Position?> requestLocationPermission({bool openSettings = false}) async {
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

  if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
    try {
      currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {}
  }

  return currentLocation;
}