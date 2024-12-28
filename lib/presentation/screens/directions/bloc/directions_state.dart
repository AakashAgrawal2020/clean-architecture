part of 'directions_bloc.dart';

class DirectionsState extends Equatable {
  final List<LatLng> polylinePoints;
  final String message;
  final ApiStatus status;

  const DirectionsState({
    this.polylinePoints = const [],
    this.message = '',
    this.status = ApiStatus.initial,
  });

  @override
  List<Object> get props => [polylinePoints, message, status];

  DirectionsState copyWith(
      {List<LatLng>? polylinePoints, String? message, ApiStatus? status}) {
    return DirectionsState(
        polylinePoints: polylinePoints ?? this.polylinePoints,
        message: message ?? this.message,
        status: status ?? this.status);
  }
}
