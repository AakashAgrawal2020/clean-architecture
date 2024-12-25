import 'dart:typed_data';
import 'dart:ui';

import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:flutter/cupertino.dart';
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
}
