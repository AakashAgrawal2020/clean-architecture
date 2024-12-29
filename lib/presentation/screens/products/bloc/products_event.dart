part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
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
