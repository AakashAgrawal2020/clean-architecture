part of 'directions_bloc.dart';

abstract class DirectionsEvent extends Equatable {
  const DirectionsEvent();

  @override
  List<Object> get props => [];
}

class FetchDirectionsEvent extends DirectionsEvent {
  final LatLng source;
  final LatLng dest;

  const FetchDirectionsEvent({required this.source, required this.dest});

  @override
  List<Object> get props => [source, dest];
}

class FetchLocationNamesEvent extends DirectionsEvent {
  final LatLng source;
  final LatLng dest;

  const FetchLocationNamesEvent({required this.source, required this.dest});

  @override
  List<Object> get props => [source, dest];
}

class SetMarkersEvent extends DirectionsEvent {
  final LatLng source;
  final LatLng dest;

  const SetMarkersEvent({required this.source, required this.dest});

  @override
  List<Object> get props => [source, dest];
}
