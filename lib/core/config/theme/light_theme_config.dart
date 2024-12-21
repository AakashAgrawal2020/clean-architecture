import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/fonts.dart';
import 'package:flutter/material.dart';

import 'asgard_colors.dart';
import 'asgard_textstyles.dart';

final lightTheme = ThemeData().copyWith(extensions: <ThemeExtension<dynamic>>[
  const AsgardTextStyles(
      asgardTextStyle1: TextStyle(
          fontSize: Fonts.fs24,
          fontWeight: Fonts.fw600,
          color: Colours.black,
          fontStyle: Fonts.normal)),
  const AsgardColours(backgroundColor: Colours.white)
]);
