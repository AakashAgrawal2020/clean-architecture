import 'package:flutter/material.dart';

class AsgardColours extends ThemeExtension<AsgardColours> {
  final Color? backgroundColor;

  const AsgardColours({this.backgroundColor});

  @override
  AsgardColours copyWith({Color? backgroundColor}) {
    return AsgardColours(
        backgroundColor: backgroundColor ?? this.backgroundColor);
  }

  @override
  AsgardColours lerp(ThemeExtension<AsgardColours>? other, double t) {
    if (other is! AsgardColours) return this;
    return AsgardColours(
        backgroundColor:
            Color.lerp(backgroundColor, other.backgroundColor, t)!);
  }
}
