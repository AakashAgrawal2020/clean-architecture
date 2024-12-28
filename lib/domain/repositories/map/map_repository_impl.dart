import 'package:clean_architecture/core/config/urls.dart';
import 'package:clean_architecture/core/network/network_services.dart';
import 'package:clean_architecture/core/utils/maps_util.dart';
import 'package:clean_architecture/domain/repositories/map/map_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRepositoryImpl extends MapRepository {
  final NetworkServices networkServices;

  MapRepositoryImpl({required this.networkServices});

  @override
  Future<List<LatLng>> fetchDirections(Map<String, dynamic> queryParams) async {
    try {
      final response = await networkServices.getAPI(
          path: Urls.googleMapDirectionUrl, queryParams: queryParams);
      if (response != null) {
        return MapsUtil.decodePolyline(
            response['routes'][0]['overview_polyline']['points']);
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      rethrow;
    }
  }
}
