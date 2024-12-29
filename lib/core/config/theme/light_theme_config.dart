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
          color: Colours.ng1000,
          fontStyle: Fonts.normal),
      asgardTextStyle2: TextStyle(
          fontSize: Fonts.fs22,
          fontWeight: Fonts.fw500,
          color: Colours.ng1000,
          fontStyle: Fonts.normal),
      asgardTextStyle3: TextStyle(
          fontSize: Fonts.fs20,
          fontWeight: Fonts.fw500,
          color: Colours.ng1000,
          fontStyle: Fonts.normal),
      asgardTextStyle4: TextStyle(
          fontSize: Fonts.fs20,
          fontWeight: Fonts.fw600,
          color: Colours.ng1000,
          fontStyle: Fonts.normal),
      asgardTextStyle5: TextStyle(
          fontSize: Fonts.fs20,
          fontWeight: Fonts.fw300,
          color: Colours.ng1000,
          fontStyle: Fonts.normal),
      asgardTextStyle6: TextStyle(
          fontSize: Fonts.fs22,
          fontWeight: Fonts.fw500,
          color: Colours.ng1000,
          fontStyle: Fonts.normal)
  ),
  AsgardColours(
      backgroundColor1: Colours.white,
      backgroundColor2: Colours.purple,
      tileColor1: Colours.grey2,
      borderColor1: Colours.ng100,
      borderColor2: Colours.ng200,
      iconColor1: Colours.ng1000,
      shadowColor1: Colours.black.withOpacity(0.25),
      shadowColor2: Colours.black.withOpacity(0.15))
]);
