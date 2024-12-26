import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'directions_event.dart';
part 'directions_state.dart';

class DirectionsBloc extends Bloc<DirectionsEvent, DirectionsState> {
  DirectionsBloc() : super(DirectionsInitial()) {
    on<DirectionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
