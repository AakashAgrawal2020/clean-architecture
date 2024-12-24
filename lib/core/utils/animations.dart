import 'package:flutter/animation.dart';

class AnimationUtils {
  static List<AnimationController> createControllers(
      {required int itemCount,
      required TickerProvider vsync,
      required int itemDuration,
      required int delayDuration,
      required bool autoPlay}) {
    final controllers = <AnimationController>[];
    for (int i = 0; i < itemCount; i++) {
      final controller = AnimationController(
          duration: Duration(milliseconds: itemDuration), vsync: vsync);
      controllers.add(controller);
      if (autoPlay) {
        Future.delayed(Duration(milliseconds: delayDuration) * i,
            () => controller.forward());
      }
    }
    return controllers;
  }

  static AnimationController createController(
      {required TickerProvider vsync,
      required int itemDuration,
      required bool autoPlay}) {
    final controller = AnimationController(
        duration: Duration(milliseconds: itemDuration), vsync: vsync);
    if (autoPlay) {
      controller.forward();
    }
    return controller;
  }
}
