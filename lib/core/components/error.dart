import 'package:clean_architecture/core/components/primary_button.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/lotties.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Error extends StatefulWidget {
  final VoidCallback onTap;

  const Error({super.key, required this.onTap});

  @override
  State<Error> createState() => _ErrorState();
}

class _ErrorState extends State<Error> with StyleExtension {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(Lotties.error, width: context.contextWidth / 2),
        Dimens.dm40.verticalSpace,
        Padding(
            padding: const EdgeInsets.only(
                left: Dimens.dm20, right: Dimens.dm20, bottom: Dimens.dm40),
            child: Text(Strings.somethingWentWrongOnProductsMessage,
                textAlign: TextAlign.center,
                style: textStyles(context).asgardTextStyle2)),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.dm50),
            child: PrimaryButton(
                onTap: widget.onTap,
                status: ApiStatus.initial,
                text: Strings.tryAgain))
      ],
    );
  }
}
