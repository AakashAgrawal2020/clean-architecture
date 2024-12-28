import 'package:clean_architecture/core/network/network_services.dart';
import 'package:clean_architecture/data/model/user/user_model.dart';
import 'package:clean_architecture/domain/repositories/auth/login_repository.dart';

class LoginRepositoryDio implements LoginRepository {
  final NetworkServices networkServices;

  LoginRepositoryDio({required this.networkServices});

  @override
  Future<UserModel> userLogin(dynamic data) async {
    dynamic response =
        await networkServices.postAPI(path: 'api/login', data: data);
    return UserModel.fromJson(response);
  }
}
