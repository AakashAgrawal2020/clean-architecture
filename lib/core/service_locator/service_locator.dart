import 'package:clean_architecture/core/network/dio_client.dart';
import 'package:clean_architecture/core/network/network_services.dart';
import 'package:clean_architecture/domain/repositories/google_map/google_map_repository.dart';
import 'package:clean_architecture/domain/repositories/google_map/google_map_repository_impl.dart';
import 'package:clean_architecture/domain/repositories/product/product_repository.dart';
import 'package:clean_architecture/domain/repositories/product/product_repository_impl.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  GetIt getIt = GetIt.instance;

  void initServiceLocators() {
    getIt.registerLazySingleton<NetworkServices>(() => DioClient());

    getIt.registerLazySingleton<GoogleMapRepository>(
            () => GoogleMapRepositoryImpl(networkServices: getIt()));
    getIt.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(networkServices: getIt()));
  }
}
