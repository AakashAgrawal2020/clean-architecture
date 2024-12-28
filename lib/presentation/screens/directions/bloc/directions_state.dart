part of 'directions_bloc.dart';

class DirectionsState extends Equatable {
  final String sourceName;
  final String destName;
  final Set<Marker> markers;
  final List<LatLng> polylinePoints;
  final String message;
  final ApiStatus apiStatus;
  final FutureStatus futureStatus;

  const DirectionsState(
      {this.sourceName = '',
      this.destName = '',
      this.markers = const {},
      this.polylinePoints = const [],
      this.message = '',
      this.apiStatus = ApiStatus.initial,
      this.futureStatus = FutureStatus.initial});

  @override
  List<Object> get props => [
        sourceName,
        destName,
        markers,
        polylinePoints,
        message,
        apiStatus,
        futureStatus
      ];

  DirectionsState copyWith(
      {List<LatLng>? polylinePoints,
      String? sourceName,
      String? destName,
      Set<Marker>? markers,
      String? message,
      ApiStatus? apiStatus,
      FutureStatus? futureStatus}) {
    return DirectionsState(
        sourceName: sourceName ?? this.sourceName,
        destName: destName ?? this.destName,
        markers: markers ?? this.markers,
        polylinePoints: polylinePoints ?? this.polylinePoints,
        message: message ?? this.message,
        apiStatus: apiStatus ?? this.apiStatus,
        futureStatus: futureStatus ?? this.futureStatus);
  }
}
