import 'hidable_controller.dart';
import 'package:flutter/material.dart';

extension HidableControllerExt on List<ScrollController> {
  static final hidableControllers = <int, HidableController>{};

  HidableController hidable(size) {
    if (hidableControllers.containsKey(hashCode)) {
      return hidableControllers[hashCode]!;
    }

    return hidableControllers[hashCode] = HidableController(
      controllers: this,
      size: size,
    );
  }
}
