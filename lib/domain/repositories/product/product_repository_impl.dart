import 'package:clean_architecture/core/config/urls.dart';
import 'package:clean_architecture/core/network/network_services.dart';
import 'package:clean_architecture/data/model/product/product_model.dart';
import 'package:clean_architecture/domain/repositories/product/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final NetworkServices networkServices;

  ProductRepositoryImpl({required this.networkServices});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response =
          await networkServices.getAPI(path: Urls.productListRemotePath);
      if (response != null && response is List<dynamic>) {
        return response
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      rethrow;
    }
  }
}
