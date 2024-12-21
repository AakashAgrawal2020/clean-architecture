
import 'package:clean_architecture/presentation/routes/routes.dart';
import 'package:clean_architecture/presentation/screens/product_listing/product_listing_screen.dart';
import 'package:clean_architecture/presentation/screens/views.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SplashScreen());

      // case Routes.loginScreen:
      //   return PageRouteBuilder(
      //       pageBuilder: (context, animation, secondaryAnimation) =>
      //           const LoginScreen());

      case Routes.productListingScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ProductListingScreen());

      default:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const Scaffold(
                    body: Center(child: Text('Unable to find this route'))));
    }
  }
}
