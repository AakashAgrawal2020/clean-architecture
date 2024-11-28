import 'package:clean_architecture/core/network/network_services.dart';
import 'package:clean_architecture/data/model/user/user_model.dart';
import 'package:clean_architecture/domain/repositories/auth/login_repository.dart';

class LoginMockRepository implements LoginRepository {
  final NetworkServices networkServicesApi;

  LoginMockRepository({required this.networkServicesApi});

  @override
  Future<UserModel> userLogin(dynamic data) async {
    await Future.delayed(const Duration(seconds: 2));
    dynamic response = {"token": "aakash"};
    return UserModel.fromJson(response);
  }
}
