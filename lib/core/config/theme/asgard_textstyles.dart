import 'package:flutter/material.dart';

class AsgardTextStyles extends ThemeExtension<AsgardTextStyles> {
  final TextStyle? asgardTextStyle1;
  final TextStyle? asgardTextStyle2;
  final TextStyle? asgardTextStyle3;
  final TextStyle? asgardTextStyle4;
  final TextStyle? asgardTextStyle5;
  final TextStyle? asgardTextStyle6;

  const AsgardTextStyles(
      {this.asgardTextStyle1,
      this.asgardTextStyle2,
      this.asgardTextStyle3,
      this.asgardTextStyle4,
      this.asgardTextStyle5,
      this.asgardTextStyle6});

  @override
  AsgardTextStyles copyWith(
      {TextStyle? asgardTextStyle1,
      TextStyle? asgardTextStyle2,
      TextStyle? asgardTextStyle3,
      TextStyle? asgardTextStyle4,
      TextStyle? asgardTextStyle5,
      TextStyle? asgardTextStyle6}) {
    return AsgardTextStyles(
        asgardTextStyle1: asgardTextStyle1 ?? this.asgardTextStyle1,
        asgardTextStyle2: asgardTextStyle2 ?? this.asgardTextStyle2,
        asgardTextStyle3: asgardTextStyle3 ?? this.asgardTextStyle3,
        asgardTextStyle4: asgardTextStyle4 ?? this.asgardTextStyle4,
        asgardTextStyle5: asgardTextStyle5 ?? this.asgardTextStyle5,
        asgardTextStyle6: asgardTextStyle6 ?? this.asgardTextStyle6);
  }

  @override
  AsgardTextStyles lerp(ThemeExtension<AsgardTextStyles>? other, double t) {
    if (other is! AsgardTextStyles) return this;
    return AsgardTextStyles(
        asgardTextStyle1:
            TextStyle.lerp(asgardTextStyle1, other.asgardTextStyle1, t)!,
        asgardTextStyle2:
            TextStyle.lerp(asgardTextStyle2, other.asgardTextStyle2, t)!,
        asgardTextStyle3:
            TextStyle.lerp(asgardTextStyle3, other.asgardTextStyle3, t)!,
        asgardTextStyle4:
            TextStyle.lerp(asgardTextStyle4, other.asgardTextStyle4, t)!,
        asgardTextStyle5:
            TextStyle.lerp(asgardTextStyle5, other.asgardTextStyle5, t)!,
        asgardTextStyle6:
            TextStyle.lerp(asgardTextStyle6, other.asgardTextStyle6, t)!);
  }
}
