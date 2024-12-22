import 'package:flutter/animation.dart';

class AnimationUtils {
  static List<AnimationController> createStaggeredControllers({
    required int itemCount,
    required TickerProvider vsync,
    required int itemDuration,
    required int delayDuration,
  }) {
    final controllers = <AnimationController>[];
    for (int i = 0; i < itemCount; i++) {
      final controller = AnimationController(
          duration: Duration(milliseconds: itemDuration), vsync: vsync);
      controllers.add(controller);
      Future.delayed(Duration(milliseconds: delayDuration) * i,
          () => controller.forward());
    }
    return controllers;
  }
}
