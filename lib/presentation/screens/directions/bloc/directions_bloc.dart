import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/config/secrets.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/core/utils/maps_util.dart';
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
    final queryParam = {
      'origin': '${event.source.latitude},${event.source.longitude}',
      'destination': '${event.dest.latitude},${event.dest.longitude}',
      'key': Secrets.GOOGLE_MAP_API_KEY
    };

    try {
      emit(state.copyWith(apiStatus: ApiStatus.loading));
      final polylinePoints = await mapRepository.fetchDirections(queryParam);
      emit(state.copyWith(
          polylinePoints: polylinePoints, apiStatus: ApiStatus.completed));
    } catch (error) {
      if (error is DioException &&
          error.type == DioExceptionType.connectionError) {
        emit(state.copyWith(
            apiStatus: ApiStatus.noInternet,
            message: 'No Internet Connection'));
      } else {
        emit(state.copyWith(apiStatus: ApiStatus.error));
      }
    }
  }


  void _onFetchLocationNamesEvent(
      FetchLocationNamesEvent event, Emitter<DirectionsState> emit) async {
    try {
      emit(state.copyWith(futureStatus: FutureStatus.loading));
      String sourceName = await MapsUtil.getPlaceName(
          latitude: event.source.latitude, longitude: event.source.longitude);
      String destName = await MapsUtil.getPlaceName(
          latitude: event.dest.latitude, longitude: event.dest.longitude);
      emit(state.copyWith(
          sourceName: sourceName,
          destName: destName,
          futureStatus: FutureStatus.completed));
    } catch (error) {
      emit(state.copyWith(futureStatus: FutureStatus.error));
    }
  }



  void _onSetMarkersEvent(
      SetMarkersEvent event, Emitter<DirectionsState> emit) async {
    try {
      emit(state.copyWith(futureStatus: FutureStatus.loading));
      Set<Marker> markers = {
        Marker(
            markerId: const MarkerId('source'),
            position: event.source,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet)),
        Marker(
            markerId: const MarkerId('dest'),
            position: event.dest,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
      };
      emit(state.copyWith(
          markers: markers, futureStatus: FutureStatus.completed));
    } catch (error) {
      emit(state.copyWith(futureStatus: FutureStatus.error));
    }
  }
}
