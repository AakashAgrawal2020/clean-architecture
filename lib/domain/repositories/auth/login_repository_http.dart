// import 'package:clean_architecture/core/config/urls.dart';
// import 'package:clean_architecture/core/network/network_services.dart';
// import 'package:clean_architecture/data/model/user/user_model.dart';
// import 'package:clean_architecture/domain/repositories/auth/login_repository.dart';
//
// class LoginRepositoryHttp implements LoginRepository {
//   final NetworkServices networkServicesHttp;
//
//   LoginRepositoryHttp({required this.networkServicesHttp});
//
//   @override
//   Future<UserModel> userLogin(dynamic data) async {
//     dynamic response = await networkServicesHttp.postAPI(Urls.loginApi, data);
//     return UserModel.fromJson(response);
//   }
// }
