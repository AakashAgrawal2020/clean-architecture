import 'dart:async';

import 'package:clean_architecture/presentation/routes/routes.dart';
import 'package:flutter/cupertino.dart';

class SplashServices {
  SplashServices._internal();

  static final SplashServices singleton = SplashServices._internal();

  factory SplashServices() {
    return singleton;
  }

  void redirectToLocationListing(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(Routes.productListingScreen);
    });
  }

// Future<void> isLogin(BuildContext context) async {
//   await SessionManager().getSessionToken().whenComplete(() {
//     if (SessionManager().isLogin == true) {
//       Timer(
//           const Duration(seconds: 2),
//           () => Navigator.pushNamedAndRemoveUntil(
//               context, Routes.homeScreen, (route) => false));
//     } else {
//       Timer(
//           const Duration(seconds: 2),
//           () => Navigator.pushNamedAndRemoveUntil(
//               context, Routes.loginScreen, (route) => false));
//     }
//   }).onError((error, stackTrace) => Timer(
//       const Duration(seconds: 2),
//       () => Navigator.pushNamedAndRemoveUntil(
//           context, Routes.loginScreen, (route) => false)));
// }
}
