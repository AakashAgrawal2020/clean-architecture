import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/lotties.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageLoadingPlaceHolder extends StatelessWidget with StyleExtension {
  final String? message;
  final double? lottieHeight;
  final double? lottieWidth;

  const PageLoadingPlaceHolder(
      {super.key, required this.message, this.lottieHeight, this.lottieWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Lottie.asset(Lotties.loading,
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
      ],
    );
  }
}
