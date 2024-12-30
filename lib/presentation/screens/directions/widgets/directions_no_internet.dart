import 'dart:ui';

import 'package:clean_architecture/core/components/primary_button.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';

class DirectionsNoInternet extends StatelessWidget with StyleExtension {
  final VoidCallback onTryAgain;

  const DirectionsNoInternet({super.key, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: Dimens.dm2, sigmaY: Dimens.dm2),
        child: Container(
            height: context.contextHeight,
            width: context.contextWidth,
            color: colours(context).backgroundColor1.withOpacity(0.5),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.signal_wifi_connected_no_internet_4,
                  size: Dimens.dm60, color: Colours.red),
              Dimens.dm20.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.dm20),
                child: Text(Strings.notInternetMessage,
                    textAlign: TextAlign.center,
                    style: textStyles(context)
                        .asgardTextStyle2
                        ?.copyWith(shadows: [
                      Shadow(
                          blurRadius: Dimens.dm10,
                          color: colours(context).textShadow1,
                          offset: const Offset(Dimens.dm2, Dimens.dm2))
                    ])),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: Dimens.dm20,
                              bottom: Dimens.dm60,
                              left: Dimens.dm20,
                              right: Dimens.dm20),
                          child: PrimaryButton(
                              onTap: onTryAgain, text: Strings.tryAgain))),
                ],
              )
            ])));
  }
}
