
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
            transitionDuration: const Duration(milliseconds: 700),
            reverseTransitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (context, animation, secondaryAnimation) =>
                DirectionsScreen(
                    product: args['product'],
                    currentLocation: args['currentLocation']),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, 0.0);
              var end = Offset.zero;
              var tween = Tween(begin: begin, end: end)
                  .chain(CurveTween(curve: Curves.ease));
              return SlideTransition(
                  position: animation.drive(tween), child: child);
            });

      default:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const Scaffold(
                    body: Center(child: Text('Unable to find this route'))));
    }
  }
}
