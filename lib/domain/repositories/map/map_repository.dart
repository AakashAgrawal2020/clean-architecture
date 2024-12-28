import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapRepository {
  Future<List<LatLng>> fetchDirections({required Map<String, dynamic> queryParams});

  Future<String> getPlaceName({required Map<String, dynamic> queryParams});
}
