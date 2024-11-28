import 'dart:async';

import 'package:clean_architecture/core/services/session/session_manager.dart';
import 'package:clean_architecture/presentation/routes/routes.dart';
import 'package:flutter/cupertino.dart';

class SplashServices {
  SplashServices._internal();

  static final SplashServices instance = SplashServices._internal();

  factory SplashServices() {
    return instance;
  }

  Future<void> isLogin(BuildContext context) async {
    await SessionManager().getSessionToken().whenComplete(() {
      if (SessionManager().isLogin == true) {
        Timer(
            const Duration(seconds: 2),
            () => Navigator.pushNamedAndRemoveUntil(
                context, Routes.homeScreen, (route) => false));
      } else {
        Timer(
            const Duration(seconds: 2),
            () => Navigator.pushNamedAndRemoveUntil(
                context, Routes.loginScreen, (route) => false));
      }
    }).onError((error, stackTrace) => Timer(
        const Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(
            context, Routes.loginScreen, (route) => false)));
  }
}
