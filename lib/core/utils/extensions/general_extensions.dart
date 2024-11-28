import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  double get contextHeight => MediaQuery.sizeOf(this).height;

  double get contextWidth => MediaQuery.sizeOf(this).width;
}

extension Space on double {
  SizedBox get verticalSpace => SizedBox(height: this);

  SizedBox get horizontalSpace => SizedBox(width: this);
}
