import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/pngs.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/services/splash/splash_services.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with StyleExtension {
  @override
  void initState() {
    super.initState();
    SplashServices().redirectToLocationListing(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colours(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Pngs.asgardLogo,
                height: Dimens.dm100, width: Dimens.dm100),
            Dimens.dm10.verticalSpace,
            Text(Strings.appName, style: textStyles(context).asgardTextStyle1)
          ],
        ),
      ),
    );
  }
}
