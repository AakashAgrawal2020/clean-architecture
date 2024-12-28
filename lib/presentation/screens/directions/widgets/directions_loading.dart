import 'dart:ui';

import 'package:clean_architecture/core/components/circular_loader.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';

class DirectionsLoading extends StatelessWidget with StyleExtension {
  const DirectionsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: Dimens.dm2, sigmaY: Dimens.dm2),
        child: Container(
            height: context.contextHeight,
            width: context.contextWidth,
            color: Colours.white.withOpacity(0.5),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const CircularLoader(
                  height: Dimens.dm40,
                  width: Dimens.dm40,
                  color: Colours.purple),
              Dimens.dm20.verticalSpace,
              Text(Strings.identifyingRoute,
                  style:
                      textStyles(context).asgardTextStyle2?.copyWith(shadows: [
                    Shadow(
                        blurRadius: Dimens.dm10,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(Dimens.dm2, Dimens.dm2))
                  ]))
            ])));
  }
}
