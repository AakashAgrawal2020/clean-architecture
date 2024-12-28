part of 'directions_bloc.dart';

class DirectionsState extends Equatable {
  final String sourceName;
  final String destName;
  final Set<Marker> markers;
  final List<LatLng> polylinePoints;
  final String message;
  final ApiStatus directionsApiStatus;
  final ApiStatus geocodeApiStatus;

  const DirectionsState(
      {this.sourceName = '',
      this.destName = '',
      this.markers = const {},
      this.polylinePoints = const [],
      this.message = '',
      this.directionsApiStatus = ApiStatus.initial,
      this.geocodeApiStatus = ApiStatus.initial});

  @override
  List<Object> get props => [
        sourceName,
        destName,
        markers,
        polylinePoints,
        message,
        directionsApiStatus,
        geocodeApiStatus
      ];

  DirectionsState copyWith(
      {List<LatLng>? polylinePoints,
      String? sourceName,
      String? destName,
      Set<Marker>? markers,
      String? message,
      ApiStatus? directionsApiStatus,
      ApiStatus? geocodeApiStatus}) {
    return DirectionsState(
        sourceName: sourceName ?? this.sourceName,
        destName: destName ?? this.destName,
        markers: markers ?? this.markers,
        polylinePoints: polylinePoints ?? this.polylinePoints,
        message: message ?? this.message,
        geocodeApiStatus: geocodeApiStatus ?? this.geocodeApiStatus,
        directionsApiStatus: directionsApiStatus ?? this.directionsApiStatus);
  }
}
