import 'package:flutter/material.dart';

class AsgardColours extends ThemeExtension<AsgardColours> {
  final Color backgroundColor;
  final Color tileColor;

  const AsgardColours({required this.backgroundColor, required this.tileColor});

  @override
  AsgardColours copyWith({Color? backgroundColor, Color? tileColor}) {
    return AsgardColours(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        tileColor: tileColor ?? this.tileColor);
  }

  @override
  AsgardColours lerp(ThemeExtension<AsgardColours>? other, double t) {
    if (other is! AsgardColours) return this;
    return AsgardColours(
        backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
        tileColor: Color.lerp(tileColor, other.tileColor, t)!);
  }
}
