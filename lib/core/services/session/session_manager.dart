import 'package:clean_architecture/core/utils/storage/local_storage/secured_local_storage.dart';
import 'package:flutter/cupertino.dart';

class SessionManager {
  late String? token;
  late bool isLogin;
  static final SessionManager _singleton = SessionManager._internal();

  factory SessionManager() {
    return _singleton;
  }

  SessionManager._internal() {
    isLogin = false;
  }

  Future<void> setSessionToken({required String token}) async {
    if (token.isNotEmpty) {
      await SecuredLocalStorage().setValue('token', token);
      await SecuredLocalStorage().setValue('isLogin', 'true');
    }
  }

  Future<void> getSessionToken() async {
    try {
      String? token = await SecuredLocalStorage().getValue('token');
      String? isLogin = await SecuredLocalStorage().getValue('isLogin');

      if (token != null && token.isNotEmpty) {
        SessionManager().token = token;
      }
      SessionManager().isLogin =
          isLogin != null && isLogin == 'true' ? true : false;
    } catch (e) {
      debugPrint('getSessionToken() => $e');
    }
  }

  void clearSession() {
    SecuredLocalStorage().clearAll();
  }
}
