import 'package:geolocator/geolocator.dart';

Position? currentLocation;

Future<LocationPermission> requestLocationPermission() async {
  // Check the current location permission
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return LocationPermission.denied;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return LocationPermission.deniedForever;
  }

  // If permissions are granted, fetch the current location
  if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
    try {
      currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {}
  }

  return permission;
}

int distanceInKms(startLat, startLong, endLat, endLong) {
  double distanceInMeters =
      Geolocator.distanceBetween(startLat, startLong, endLat, endLong);
  return (distanceInMeters / 1000).round();
}
