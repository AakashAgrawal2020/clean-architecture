import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color cardColor;
  final Color textColor;
  final Color buttonColor;

  const CustomColors(
      {required this.primaryColor,
      required this.secondaryColor,
      required this.backgroundColor,
      required this.cardColor,
      required this.textColor,
      required this.buttonColor});

  @override
  CustomColors copyWith(
      {Color? primaryColor,
      Color? secondaryColor,
      Color? backgroundColor,
      Color? cardColor,
      Color? textColor,
      Color? buttonColor}) {
    return CustomColors(
        primaryColor: primaryColor ?? this.primaryColor,
        secondaryColor: secondaryColor ?? this.secondaryColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        cardColor: cardColor ?? this.cardColor,
        textColor: textColor ?? this.textColor,
        buttonColor: buttonColor ?? this.buttonColor);
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
        primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
        secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
        backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
        cardColor: Color.lerp(cardColor, other.cardColor, t)!,
        textColor: Color.lerp(textColor, other.textColor, t)!,
        buttonColor: Color.lerp(buttonColor, other.buttonColor, t)!);
  }
}
