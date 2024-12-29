part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductsEvent {}

class UpdateSelectedProductEvent extends ProductsEvent {
  final ProductModel? selectedProduct;

  const UpdateSelectedProductEvent({this.selectedProduct});

  @override
  List<Object?> get props => [selectedProduct];
}

class ToggleMapHeightEvent extends ProductsEvent {
  final double mapHeight;

  const ToggleMapHeightEvent({required this.mapHeight});

  @override
  List<Object?> get props => [mapHeight];
}

class SetMarkersEvent extends ProductsEvent {
  final Set<Marker> markers;

  const SetMarkersEvent({required this.markers});

  @override
  List<Object?> get props => [markers];
}
