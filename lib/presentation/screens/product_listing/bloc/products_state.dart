part of 'products_bloc.dart';

class ProductsState extends Equatable {
  List<ProductModel> products;
  final String message;
  final ApiStatus status;

  ProductsState({
    this.products = const [],
    this.message = '',
    this.status = ApiStatus.initial,
  });

  @override
  List<Object> get props => [products, message, status];

  ProductsState copyWith(
      {List<ProductModel>? products, String? message, ApiStatus? status}) {
    return ProductsState(
        products: products ?? this.products,
        message: message ?? this.message,
        status: status ?? this.status);
  }
}
