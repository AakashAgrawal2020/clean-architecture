import 'package:clean_architecture/core/components/primary_button.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/lotties.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SomethingWentWrong extends StatefulWidget {
  final String? message;
  final double? lottieHeight;
  final double? lottieWidth;
  final VoidCallback onTap;

  const SomethingWentWrong(
      {super.key,
      required this.onTap,
      this.message,
      this.lottieHeight,
      this.lottieWidth});

  @override
  State<SomethingWentWrong> createState() => _SomethingWentWrongState();
}

class _SomethingWentWrongState extends State<SomethingWentWrong>
    with StyleExtension {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Lottie.asset(Lotties.loadingProducts,
                width: widget.lottieWidth, height: widget.lottieHeight)),
        widget.message != null
            ? Padding(
                padding: const EdgeInsets.only(
                    left: Dimens.dm20,
                    right: Dimens.dm20,
                    bottom: Dimens.dm100),
                child: Text(widget.message!,
                    textAlign: TextAlign.center,
                    style: textStyles(context).asgardTextStyle2))
            : Dimens.dm100.verticalSpace,
        PrimaryButton(
            onTap: widget.onTap,
            status: ApiStatus.initial,
            text: Strings.tryAgain)
      ],
    );
  }
}
