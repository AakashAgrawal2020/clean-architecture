import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/lotties.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ZeroProducts extends StatelessWidget with StyleExtension {
  const ZeroProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.dm50),
          child: Lottie.asset(Lotties.zeroProducts,
              width: context.contextWidth / 2)),
      Dimens.dm40.verticalSpace,
      Padding(
          padding: const EdgeInsets.only(
              left: Dimens.dm20, right: Dimens.dm20,
                    bottom: Dimens.dm100),
          child: Text(Strings.zeroProductsMessage,
              textAlign: TextAlign.center,
              style: textStyles(context).asgardTextStyle2))
    ]);
  }
}
