import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/helpers/textstyles.dart';
import 'package:clean_architecture/core/services/splash/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SplashServices().isLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Strings.splashScreen, style: TextStyles.textStyle1),
          ],
        ),
      ),
    );
  }
}
