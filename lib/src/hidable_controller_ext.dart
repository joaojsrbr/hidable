import 'hidable_controller.dart';
import 'package:flutter/material.dart';

extension HidableControllerExt on List<ScrollController> {
  static final hidableControllers = <int, HidableController>{};

  /// Shortcut way of creating hidable controller
  HidableController hidable(size) {
    // If the same instance was created before, we should keep using it.
    if (hidableControllers.containsKey(hashCode)) {
      return hidableControllers[hashCode]!;
    }

    return hidableControllers[hashCode] = HidableController(
      controllers: this,
      size: size,
    );
  }
}
