import 'dart:convert';

import 'package:clean_architecture/core/config/urls.dart';
import 'package:clean_architecture/core/network/network_services.dart';
import 'package:clean_architecture/data/model/product/product_model.dart';
import 'package:clean_architecture/domain/repositories/product/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final NetworkServices networkServices;

  ProductRepositoryImpl({required this.networkServices});

  @override
  Future<List<ProductModel>> fetchProducts(dynamic data) async {
    dynamic response = await networkServices.getAPI(Urls.productListRemotePath);
    final List<dynamic> parsedJson = json.decode(response);
    return parsedJson.map((item) => ProductModel.fromJson(item)).toList();
  }
}
