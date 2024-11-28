import 'package:clean_architecture/core/network/network_services.dart';
import 'package:clean_architecture/data/model/user/user_model.dart';
import 'package:clean_architecture/domain/repositories/auth/login_repository.dart';

class LoginRepositoryDio implements LoginRepository {
  final NetworkServices networkServicesDio;

  LoginRepositoryDio({required this.networkServicesDio});

  @override
  Future<UserModel> userLogin(dynamic data) async {
    dynamic response = await networkServicesDio.postAPI('api/login', data);
    return UserModel.fromJson(response);
  }
}
