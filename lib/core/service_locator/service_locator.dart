import 'package:clean_architecture/core/network/dio_client.dart';
import 'package:clean_architecture/core/network/network_services.dart';
import 'package:clean_architecture/domain/repositories/auth/login_repository.dart';
import 'package:clean_architecture/domain/repositories/auth/login_repository_dio.dart';
import 'package:clean_architecture/domain/repositories/map/map_repository.dart';
import 'package:clean_architecture/domain/repositories/map/map_repository_impl.dart';
import 'package:clean_architecture/domain/repositories/product/product_repository.dart';
import 'package:clean_architecture/domain/repositories/product/product_repository_impl.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  GetIt getIt = GetIt.instance;

  void initServiceLocators() {
    getIt.registerLazySingleton<NetworkServices>(() => DioClient());

    getIt.registerLazySingleton<MapRepository>(
            () => MapRepositoryImpl(networkServices: getIt()));

    getIt.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryDio(networkServices: getIt()));

    getIt.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(networkServices: getIt()));
  }
}
