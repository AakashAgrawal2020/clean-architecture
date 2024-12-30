import 'package:clean_architecture/core/config/urls.dart';
import 'package:clean_architecture/core/network/network_services.dart';
import 'package:clean_architecture/core/utils/google_map_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'google_map_repository.dart';

class GoogleMapRepositoryImpl extends GoogleMapRepository {
  final NetworkServices networkServices;

  GoogleMapRepositoryImpl({required this.networkServices});

  @override
  Future<List<LatLng>> fetchDirections(
      {required Map<String, dynamic> queryParams}) async {
    try {
      final response = await networkServices.getAPI(
          path: Urls.googleMapDirectionPath, queryParams: queryParams);
      if (response != null) {
        return GoogleMapUtil.decodePolyline(
            response['routes'][0]['overview_polyline']['points']);
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getPlaceName(
      {required Map<String, dynamic> queryParams}) async {
    try {
      final response = await networkServices.getAPI(
          path: Urls.googleMapGeocodePath, queryParams: queryParams);
      if (response != null) {
        return response['results'][0]['formatted_address'];
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      rethrow;
    }
  }
}
