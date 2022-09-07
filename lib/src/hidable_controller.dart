import 'package:flutter/material.dart';

class HidableController {
  List<ScrollController> controllers;

  double size;

  HidableController({
    required this.controllers,
    required this.size,
  }) {
    for (var scroll in controllers) {
      scroll.addListener(() => listener(scroll));
    }
  }

  double li = 0.0, lastOffset = 0.0;

  final sizeNotifier = ValueNotifier<double>(1.0);

  final stickinessNotifier = ValueNotifier<bool>(false);

  void setStickinessState(bool state) => stickinessNotifier.value = state;

  double sizeFactor() => 1.0 - (li / size);

  void listener(ScrollController scrollcontroller) {
    final p = scrollcontroller.position;

    li = (li + p.pixels - lastOffset).clamp(0.0, size);
    lastOffset = p.pixels;

    if (p.axisDirection == AxisDirection.down && p.extentAfter == 0.0) {
      if (sizeNotifier.value == 0.0) return;

      sizeNotifier.value = 0.0;
      return;
    }

    if (p.axisDirection == AxisDirection.up && p.extentBefore == 0.0) {
      if (sizeNotifier.value == 1.0) return;

      sizeNotifier.value = 1.0;
      return;
    }

    final isZeroValued = li == 0.0 && sizeNotifier.value == 0.0;
    if (isZeroValued || (li == size && sizeNotifier.value == 1.0)) return;

    sizeNotifier.value = sizeFactor();
  }

  void close() {
    stickinessNotifier.dispose();
    sizeNotifier.dispose();
  }
}
