import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/data/model/product/product_model.dart';
import 'package:clean_architecture/domain/repositories/product/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductRepository productRepository;

  ProductsBloc({required this.productRepository})
      : super(const ProductsState()) {
    on<FetchProductsEvent>(_onFetchProductsEvent);
  }

  void _onFetchProductsEvent(
      FetchProductsEvent event, Emitter<ProductsState> emit) async {
    try {
      emit(state.copyWith(status: ApiStatus.loading));
      final products = await productRepository.fetchProducts();
      emit(state.copyWith(products: products, status: ApiStatus.completed));
    } catch (error) {
      if (error is DioException &&
          error.type == DioExceptionType.connectionError) {
        emit(state.copyWith(
          status: ApiStatus.noInternet,
          message: 'No Internet Connection',
        ));
      } else {
        emit(state.copyWith(
          status: ApiStatus.error,
          message: 'An unexpected error occurred: ${error.toString()}',
        ));
      }
    }
  }
}
