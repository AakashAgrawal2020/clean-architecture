import 'dart:async';

import 'package:clean_architecture/core/utils/location_permission_handler.dart';
import 'package:clean_architecture/presentation/routes/routes.dart';
import 'package:flutter/cupertino.dart';

class SplashServices {
  Future<void> redirectToProductListing(BuildContext context) async {
    await requestLocationPermission().then((value) {
      Timer(const Duration(seconds: 1), () {
        Navigator.of(context).pushReplacementNamed(Routes.productListingScreen);
      });
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
