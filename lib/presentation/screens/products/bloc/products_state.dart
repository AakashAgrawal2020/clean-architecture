part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final List<ProductModel> products;
  final ProductModel? selectedProduct;
  final Set<Marker> markers;
  final double mapHeight;
  final String message;
  final ApiStatus status;

  const ProductsState(
      {this.selectedProduct,
      this.products = const [],
      this.markers = const {},
      this.message = '',
      this.mapHeight = Dimens.dm100,
      this.status = ApiStatus.initial});

  @override
  List<Object?> get props =>
      [products, selectedProduct, markers, mapHeight, message, status];

  ProductsState copyWith(
      {List<ProductModel>? products,
      ProductModel? selectedProduct,
      Set<Marker>? markers,
      double? mapHeight,
      String? message,
      ApiStatus? status}) {
    return ProductsState(
        products: products ?? this.products,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        mapHeight: mapHeight ?? this.mapHeight,
        markers: markers ?? this.markers,
        message: message ?? this.message,
        status: status ?? this.status);
  }
}
