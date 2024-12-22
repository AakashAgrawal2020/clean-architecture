import 'package:clean_architecture/data/model/product/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> fetchProducts();
}
