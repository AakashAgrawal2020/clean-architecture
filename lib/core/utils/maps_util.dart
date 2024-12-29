import 'dart:ui';

import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/data/model/product/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsUtil {
  static const String lightTheme = 'assets/map_modes/light_mode.json';
  static const String darkTheme = 'assets/map_modes/dark_mode.json';

  static Future<BitmapDescriptor> createCustomMarker(String text) async {
    final textPainter = TextPainter(
        text: TextSpan(
            text: text,
            style: const TextStyle(color: Colours.black, fontSize: 24)),
        textDirection: TextDirection.ltr);
    textPainter.layout();

    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    textPainter.paint(canvas, const Offset(0, 0));

    final picture = recorder.endRecording();
    final img = await picture.toImage(
      textPainter.width.toInt(),
      textPainter.height.toInt(),
    );

    return BitmapDescriptor.bytes(
        (await img.toByteData(format: ImageByteFormat.png)) as Uint8List);
  }

  static void fitMarkersInView(
      {required Set<Marker> markers,
      required GoogleMapController googleMapController,
      double? padding}) {
    if (markers.isNotEmpty && markers.length == 2) {
      final markerPositions = markers.map((marker) => marker.position).toList();
      double south = markerPositions
          .map((e) => e.latitude)
          .reduce((a, b) => a < b ? a : b);
      double north = markerPositions
          .map((e) => e.latitude)
          .reduce((a, b) => a > b ? a : b);
      double west = markerPositions
          .map((e) => e.longitude)
          .reduce((a, b) => a < b ? a : b);
      double east = markerPositions
          .map((e) => e.longitude)
          .reduce((a, b) => a > b ? a : b);
      LatLngBounds bounds = LatLngBounds(
          southwest: LatLng(south, west), northeast: LatLng(north, east));
      googleMapController
          .animateCamera(CameraUpdate.newLatLngBounds(bounds, padding ?? 50.0));
    }
  }

  static List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dLat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dLng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dLng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  static Future<void> animateCameraOnMarkerTap(
      ProductModel product, GoogleMapController? googleMapController) async {
    if (googleMapController != null) {
      await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(product.coordinates[0], product.coordinates[1]),
              zoom: 10.0)));
    }
  }

  static int distanceInKms(startLat, startLong, endLat, endLong) {
    double distanceInMeters =
        Geolocator.distanceBetween(startLat, startLong, endLat, endLong);
    return (distanceInMeters / 1000).round();
  }

  static Future<String> setDarkMapStyle() async {
    return await rootBundle.loadString(darkTheme);
  }

  static Future<String> setLightMapStyle() async {
    return await rootBundle.loadString(lightTheme);
  }

}
