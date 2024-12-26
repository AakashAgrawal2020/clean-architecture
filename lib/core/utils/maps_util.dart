import 'dart:typed_data';
import 'dart:ui';

import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsUtil {
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

  static Future<String> getPlaceName(
      {required double latitude, required double longitude}) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placeMarks[0];
      return '${place.name}, ${place.locality}, ${place.country}';
    } catch (e) {
      return 'Unable to fetch location name';
    }
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
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }
}
