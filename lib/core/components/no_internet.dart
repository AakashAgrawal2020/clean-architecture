import 'package:clean_architecture/core/components/primary_button.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/lotties.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatefulWidget {
  final VoidCallback tryAgain;

  const NoInternet({super.key, required this.tryAgain});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> with StyleExtension {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
          child: Lottie.asset(Lotties.noInternet,
              width: context.contextWidth / 2)),
      Padding(
          padding: const EdgeInsets.all(Dimens.dm20),
          child: Text(Strings.notInternetMessage,
              textAlign: TextAlign.center,
              style: textStyles(context).asgardTextStyle2)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: Dimens.dm20,
                      bottom: Dimens.dm60,
                      left: Dimens.dm20,
                      right: Dimens.dm10),
                  child: PrimaryButton(
                      onTap: widget.tryAgain, text: Strings.tryAgain))),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: Dimens.dm20,
                      bottom: Dimens.dm60,
                      right: Dimens.dm20,
                      left: Dimens.dm10),
                  child: PrimaryButton(
                      onTap: () {}, text: Strings.networkSettings))),
        ],
      )
    ]);
  }
}
