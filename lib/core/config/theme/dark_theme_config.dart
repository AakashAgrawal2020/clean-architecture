import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/fonts.dart';
import 'package:flutter/material.dart';

import 'asgard_colors.dart';
import 'asgard_textstyles.dart';

final darkTheme = ThemeData().copyWith(extensions: <ThemeExtension<dynamic>>[
  const AsgardTextStyles(
      asgardTextStyle1: TextStyle(
          fontSize: Fonts.fs24,
          fontWeight: Fonts.fw600,
          color: Colours.white,
          fontStyle: Fonts.normal),
      asgardTextStyle2: TextStyle(
          fontSize: Fonts.fs20,
          fontWeight: Fonts.fw500,
          color: Colours.white,
          fontStyle: Fonts.normal)),
  const AsgardColours(backgroundColor: Colours.black, tileColor: Colours.grey1)
]);
