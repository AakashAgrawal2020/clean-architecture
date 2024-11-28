import 'package:clean_architecture/data/model/user/user_model.dart';

abstract class LoginRepository {
  Future<UserModel> userLogin(dynamic data);
}
