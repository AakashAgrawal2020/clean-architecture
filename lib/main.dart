import 'package:clean_architecture/core/config/theme/light_theme_config.dart';
import 'package:clean_architecture/core/service_locator/service_locator.dart';
import 'package:clean_architecture/presentation/routes/route_generator.dart';
import 'package:clean_architecture/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() {
  ServiceLocator().initServiceLocators();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      initialRoute: Routes.animationScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
