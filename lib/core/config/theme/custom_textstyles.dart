import 'package:flutter/material.dart';

class CustomTextStyles extends ThemeExtension<CustomTextStyles> {
  final TextStyle headline3;
  final TextStyle headline4;
  final TextStyle headline5;
  final TextStyle headline6;

  const CustomTextStyles(
      {required this.headline3,
      required this.headline4,
      required this.headline5,
      required this.headline6});

  @override
  CustomTextStyles copyWith(
      {TextStyle? headline3,
      TextStyle? headline4,
      TextStyle? headline5,
      TextStyle? headline6}) {
    return CustomTextStyles(
        headline3: headline3 ?? this.headline3,
        headline4: headline4 ?? this.headline4,
        headline5: headline5 ?? this.headline5,
        headline6: headline6 ?? this.headline6);
  }

  @override
  CustomTextStyles lerp(ThemeExtension<CustomTextStyles>? other, double t) {
    if (other is! CustomTextStyles) return this;
    return CustomTextStyles(
        headline3: TextStyle.lerp(headline3, other.headline3, t)!,
        headline4: TextStyle.lerp(headline4, other.headline4, t)!,
        headline5: TextStyle.lerp(headline5, other.headline5, t)!,
        headline6: TextStyle.lerp(headline6, other.headline6, t)!);
  }
}
