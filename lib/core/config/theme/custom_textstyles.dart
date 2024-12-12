import 'package:flutter/material.dart';

class CustomTextStyles extends ThemeExtension<CustomTextStyles> {
  final TextStyle custom1;
  final TextStyle custom2;
  final TextStyle custom3;
  final TextStyle custom4;

  const CustomTextStyles(
      {required this.custom1,
      required this.custom2,
      required this.custom3,
      required this.custom4});

  @override
  CustomTextStyles copyWith(
      {TextStyle? custom1,
      TextStyle? custom2,
      TextStyle? custom3,
      TextStyle? custom4}) {
    return CustomTextStyles(
        custom1: custom1 ?? this.custom1,
        custom2: custom2 ?? this.custom2,
        custom3: custom3 ?? this.custom3,
        custom4: custom4 ?? this.custom4);
  }

  @override
  CustomTextStyles lerp(ThemeExtension<CustomTextStyles>? other, double t) {
    if (other is! CustomTextStyles) return this;
    return CustomTextStyles(
        custom1: TextStyle.lerp(custom1, other.custom1, t)!,
        custom2: TextStyle.lerp(custom2, other.custom2, t)!,
        custom3: TextStyle.lerp(custom3, other.custom3, t)!,
        custom4: TextStyle.lerp(custom4, other.custom4, t)!);
  }
}
