
import 'package:clean_architecture/presentation/routes/routes.dart';
import 'package:clean_architecture/presentation/screens/animation/animation_screen.dart';
import 'package:clean_architecture/presentation/screens/views.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SplashScreen());
      case Routes.animationScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const AnimationScreen());
      case Routes.homeScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const HomeScreen());
      case Routes.loginScreen:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const LoginScreen());
      default:
        // return MaterialPageRoute(builder: (context) => const SplashScreen());
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const Scaffold(
                    body: Center(child: Text('Unable to find this route'))));
    }
  }
}
