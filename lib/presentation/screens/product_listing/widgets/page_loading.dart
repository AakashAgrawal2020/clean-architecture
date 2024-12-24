import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget with StyleExtension {
  final String? message;
  final String lottiePath;
  final double? lottieHeight;
  final double? lottieWidth;
  final AnimationController animationController;

  const Loading({super.key,
    required this.message,
    required this.lottiePath,
      required this.animationController,
      this.lottieHeight,
      this.lottieWidth});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: animationController.drive(CurveTween(curve: Curves.ease)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
              child: Lottie.asset(lottiePath,
                  width: lottieWidth, height: lottieHeight)),
          message != null
              ? Padding(
                  padding: const EdgeInsets.only(
                      left: Dimens.dm20,
                      right: Dimens.dm20,
                      bottom: Dimens.dm100),
                  child: Text(message!,
                      textAlign: TextAlign.center,
                      style: textStyles(context).asgardTextStyle2))
              : Dimens.dm100.verticalSpace
        ]));
  }
}
