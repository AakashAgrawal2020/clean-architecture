import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/config/secrets.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/domain/repositories/map/map_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'directions_event.dart';
part 'directions_state.dart';

class DirectionsBloc extends Bloc<DirectionsEvent, DirectionsState> {
  MapRepository mapRepository;

  DirectionsBloc({required this.mapRepository})
      : super(const DirectionsState()) {
    on<FetchDirectionsEvent>(_onFetchDirectionsEvent);
    on<FetchLocationNamesEvent>(_onFetchLocationNamesEvent);
    on<SetMarkersEvent>(_onSetMarkersEvent);
  }

  void _onFetchDirectionsEvent(
      FetchDirectionsEvent event, Emitter<DirectionsState> emit) async {
    final queryParams = {
      'origin': '${event.source.latitude},${event.source.longitude}',
      'destination': '${event.dest.latitude},${event.dest.longitude}',
      'key': Secrets.GOOGLE_MAP_API_KEY
    };

    try {
      emit(state.copyWith(directionsApiStatus: ApiStatus.loading));
      final polylinePoints =
          await mapRepository.fetchDirections(queryParams: queryParams);
      emit(state.copyWith(
          polylinePoints: polylinePoints,
          directionsApiStatus: ApiStatus.completed));
    } catch (error) {
      if (error is DioException &&
          error.type == DioExceptionType.connectionError) {
        emit(state.copyWith(
            directionsApiStatus: ApiStatus.noInternet,
            message: 'No Internet Connection'));
      } else {
        emit(state.copyWith(directionsApiStatus: ApiStatus.error));
      }
    }
  }


  void _onFetchLocationNamesEvent(
      FetchLocationNamesEvent event, Emitter<DirectionsState> emit) async {
    try {
      emit(state.copyWith(geocodeApiStatus: ApiStatus.loading));
      String sourceName = await mapRepository.getPlaceName(queryParams: {
        'latlng': '${event.source.latitude},${event.source.longitude}',
        'key': Secrets.GOOGLE_MAP_API_KEY
      });
      String destName = await mapRepository.getPlaceName(queryParams: {
        'latlng': '${event.dest.latitude},${event.dest.longitude}',
        'key': Secrets.GOOGLE_MAP_API_KEY
      });
      emit(state.copyWith(
          sourceName: sourceName,
          destName: destName,
          geocodeApiStatus: ApiStatus.completed));
    } catch (error) {
      emit(state.copyWith(geocodeApiStatus: ApiStatus.error));
    }
  }



  void _onSetMarkersEvent(
      SetMarkersEvent event, Emitter<DirectionsState> emit) async {
    try {
      emit(state.copyWith(markers: {}));
      Set<Marker> markers = {
        Marker(
            markerId: const MarkerId('source'),
            position: event.source,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure)),
        Marker(
            markerId: const MarkerId('dest'),
            position: event.dest,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet))
      };
      emit(state.copyWith(markers: markers));
    } catch (error) {
      emit(state.copyWith(markers: {}));
    }
  }
}
