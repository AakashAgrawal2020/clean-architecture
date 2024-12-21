import 'package:flutter/material.dart';

class AsgardColours extends ThemeExtension<AsgardColours> {
  final Color backgroundColor;
  final Color tileColor;
  final Color shadowColor1;
  final Color shadowColor2;

  const AsgardColours(
      {required this.backgroundColor,
      required this.tileColor,
      required this.shadowColor1,
      required this.shadowColor2});

  @override
  AsgardColours copyWith(
      {Color? backgroundColor,
      Color? tileColor,
      Color? shadowColor1,
      Color? shadowColor2}) {
    return AsgardColours(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        tileColor: tileColor ?? this.tileColor,
        shadowColor1: shadowColor1 ?? this.shadowColor1,
        shadowColor2: shadowColor2 ?? this.shadowColor2);
  }

  @override
  AsgardColours lerp(ThemeExtension<AsgardColours>? other, double t) {
    if (other is! AsgardColours) return this;
    return AsgardColours(
        backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
        tileColor: Color.lerp(tileColor, other.tileColor, t)!,
        shadowColor1: Color.lerp(shadowColor1, other.shadowColor1, t)!,
        shadowColor2: Color.lerp(shadowColor2, other.shadowColor2, t)!);
  }
}
