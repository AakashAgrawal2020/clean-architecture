import 'package:flutter/material.dart';

class AsgardColours extends ThemeExtension<AsgardColours> {
  final Color backgroundColor1;
  final Color backgroundColor2;
  final Color borderColor1;
  final Color borderColor2;
  final Color iconColor1;
  final Color tileColor1;
  final Color shadowColor1;
  final Color shadowColor2;
  final Color textShadow1;
  final Color polylineColor1;

  @override
  AsgardColours copyWith({
    Color? backgroundColor1,
    Color? backgroundColor2,
    Color? tileColor1,
      Color? borderColor1,
      Color? borderColor2,
      Color? iconColor1,
      Color? shadowColor1,
      Color? shadowColor2,
      Color? polylineColor1,
      Color? textShadow1}) {
    return AsgardColours(
        backgroundColor1: backgroundColor1 ?? this.backgroundColor1,
        backgroundColor2: backgroundColor2 ?? this.backgroundColor2,
        borderColor1: borderColor1 ?? this.borderColor1,
        borderColor2: borderColor2 ?? this.borderColor2,
        iconColor1: iconColor1 ?? this.iconColor1,
        tileColor1: tileColor1 ?? this.tileColor1,
        shadowColor1: shadowColor1 ?? this.shadowColor1,
        shadowColor2: shadowColor2 ?? this.shadowColor2,
        polylineColor1: polylineColor1 ?? this.polylineColor1,
        textShadow1: textShadow1 ?? this.textShadow1);
  }

  const AsgardColours(
      {required this.backgroundColor1,
      required this.backgroundColor2,
      required this.tileColor1,
      required this.borderColor1,
      required this.borderColor2,
      required this.iconColor1,
      required this.shadowColor1,
      required this.shadowColor2,
      required this.polylineColor1,
      required this.textShadow1});

  @override
  AsgardColours lerp(ThemeExtension<AsgardColours>? other, double t) {
    if (other is! AsgardColours) return this;
    return AsgardColours(
        backgroundColor1:
            Color.lerp(backgroundColor1, other.backgroundColor1, t)!,
        backgroundColor2:
            Color.lerp(backgroundColor2, other.backgroundColor2, t)!,
        borderColor1: Color.lerp(borderColor1, other.borderColor1, t)!,
        borderColor2: Color.lerp(borderColor2, other.borderColor2, t)!,
        iconColor1: Color.lerp(iconColor1, other.iconColor1, t)!,
        tileColor1: Color.lerp(tileColor1, other.tileColor1, t)!,
        shadowColor1: Color.lerp(shadowColor1, other.shadowColor1, t)!,
        shadowColor2: Color.lerp(shadowColor2, other.shadowColor2, t)!,
        polylineColor1: Color.lerp(polylineColor1, other.polylineColor1, t)!,
        textShadow1: Color.lerp(textShadow1, other.shadowColor2, t)!);
  }
}
