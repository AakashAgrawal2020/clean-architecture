
import 'package:clean_architecture/presentation/routes/routes.dart';
import 'package:clean_architecture/presentation/screens/views.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map args = (settings.arguments ?? {}) as Map;
    switch (settings.name) {
      case Routes.splashScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SplashScreen());

      case Routes.productListingScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const ProductListingScreen());

      case Routes.directionScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DirectionsScreen(
                    product: args['product'],
                    currentLocation: args['currentLocation']));
      default:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const Scaffold(
                    body: Center(child: Text('Unable to find this route'))));
    }
  }
}
