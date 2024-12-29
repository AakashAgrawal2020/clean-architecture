part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final List<ProductModel> products;
  final ProductModel? selectedProduct;
  final double mapHeight;
  final String message;
  final ApiStatus status;

  const ProductsState(
      {this.selectedProduct,
      this.products = const [],
      this.message = '',
      required this.mapHeight,
      this.status = ApiStatus.initial});

  @override
  List<Object?> get props =>
      [products, selectedProduct, mapHeight, message, status];

  ProductsState copyWith(
      {List<ProductModel>? products,
      ProductModel? selectedProduct,
      double? mapHeight,
      String? message,
      ApiStatus? status}) {
    return ProductsState(
        products: products ?? this.products,
        selectedProduct: selectedProduct ?? this.selectedProduct,
        mapHeight: mapHeight ?? this.mapHeight,
        message: message ?? this.message,
        status: status ?? this.status);
  }
}
