import 'package:clean_architecture/core/components/flush_bar/flushbar_route.dart';
import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/dimens.dart';
import 'package:clean_architecture/core/helpers/fonts.dart';
import 'package:clean_architecture/core/utils/enums.dart';
import 'package:flutter/material.dart';

import 'flushbar.dart';

class Toast {
  static void showToastMessage(
      {required BuildContext context,
      required String message,
      required ApiStatus status}) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
            margin: const EdgeInsets.symmetric(horizontal: Dimens.dm20),
            reverseAnimationCurve: Curves.bounceIn,
            borderRadius: BorderRadius.circular(Dimens.dm10),
            duration: const Duration(seconds: 2),
            messageText: Text(
              message,
              style: const TextStyle(
                  color: Colours.white,
                  fontSize: Dimens.dm16,
                  fontWeight: Fonts.fw600),
            ),
            shouldIconPulse: true,
            leftBarIndicatorColor: status.name.toLowerCase() == 'success'
                ? Colours.green
                : Colours.red,
            backgroundColor: Colours.black)
          ..show(context));
  }
}
