import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_listing_event.dart';

part 'product_listing_state.dart';

class ProductListingBloc
    extends Bloc<ProductListingEvent, ProductListingState> {
  ProductListingBloc() : super(ProductListingInitial()) {
    on<ProductListingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
