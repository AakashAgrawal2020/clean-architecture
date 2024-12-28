import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapRepository {
  Future<List<LatLng>> fetchDirections(Map<String, dynamic> queryParams);
}
