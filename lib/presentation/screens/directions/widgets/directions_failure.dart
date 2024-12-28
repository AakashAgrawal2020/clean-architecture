import 'dart:ui';

import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/strings.dart';
import 'package:clean_architecture/core/utils/extensions/general_extensions.dart';
import 'package:clean_architecture/core/utils/extensions/style_extensions.dart';
import 'package:flutter/material.dart';

class DirectionsError extends StatelessWidget with StyleExtension {
  const DirectionsError({super.key});

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
              const Icon(Icons.explore_off,
                  size: Dimens.dm50, color: Colours.red),
              Dimens.dm20.verticalSpace,
              Text(Strings.identifyingRouteError,
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
