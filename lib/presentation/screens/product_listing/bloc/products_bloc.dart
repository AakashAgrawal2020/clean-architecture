import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/data/model/product/product_model.dart';
import 'package:clean_architecture/domain/repositories/product/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductRepository productRepository;

  ProductsBloc({required this.productRepository}) : super(ProductsState()) {
    on<FetchProductsEvent>(_onFetchProductsEvent);
  }

  void _onFetchProductsEvent(
      FetchProductsEvent event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ApiStatus.loading));
    await productRepository.fetchProducts().then((List<ProductModel> value) {
      emit(state.copyWith(products: value, status: ApiStatus.completed));
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: ApiStatus.error));
    });
  }
}
