import 'package:clean_architecture/core/helpers/colours.dart';
import 'package:clean_architecture/core/helpers/textstyles.dart';
import 'package:flutter/material.dart';

import 'custom_colors.dart';
import 'custom_textstyles.dart';

final darkTheme = ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black, foregroundColor: Colors.white),
        textTheme: TextTheme(
            displaySmall: TextStyles.textStyle1,
            displayMedium: TextStyles.textStyle2,
            displayLarge: TextStyles.textStyle3,
            bodySmall: TextStyles.textStyle4,
            bodyLarge: TextStyles.textStyle5))
    .copyWith(
  extensions: <ThemeExtension<dynamic>>[
    CustomTextStyles(
        custom1: TextStyles.textStyle1!,
        custom2: TextStyles.textStyle1!,
        custom3: TextStyles.textStyle1!,
        custom4: TextStyles.textStyle1!),
    const CustomColors(
        primaryColor: Colours.green,
        secondaryColor: Colours.magenta,
        backgroundColor: Colours.red,
        cardColor: Colours.white,
        textColor: Colours.black,
        buttonColor: Colours.green)
  ],
);

// final customStyles = Theme.of(context).extension<CustomTextStyles>();
