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
    on<FetchDirectionsEvent>(_onFetchProductsEvent);
  }

  void _onFetchProductsEvent(
      FetchDirectionsEvent event, Emitter<DirectionsState> emit) async {
    final queryParam = {
      'origin': '${event.source.latitude},${event.source.longitude}',
      'destination': '${event.dest.latitude},${event.dest.longitude}',
      'key': Secrets.GOOGLE_MAP_API_KEY
    };

    try {
      emit(state.copyWith(status: ApiStatus.loading));
      final polylinePoints = await mapRepository.fetchDirections(queryParam);
      emit(state.copyWith(
          polylinePoints: polylinePoints, status: ApiStatus.completed));
    } catch (error) {
      if (error is DioException &&
          error.type == DioExceptionType.connectionError) {
        emit(state.copyWith(
            status: ApiStatus.noInternet, message: 'No Internet Connection'));
      } else {
        emit(state.copyWith(status: ApiStatus.error));
      }
    }
  }
}
