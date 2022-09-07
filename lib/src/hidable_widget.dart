import 'package:flutter/material.dart';
import 'hidable_controller_ext.dart';

class Hidable extends StatelessWidget with PreferredSizeWidget {
  final Widget child;

  final List<ScrollController> controllers;

  final bool wOpacity;

  final Size preferredWidgetSize;

  const Hidable({
    Key? key,
    required this.child,
    required this.controllers,
    this.wOpacity = true,
    this.preferredWidgetSize = const Size.fromHeight(56),
  }) : super(key: key);

  @override
  Size get preferredSize => preferredWidgetSize;

  @override
  Widget build(BuildContext context) {
    final hidable = controllers.hidable(preferredWidgetSize.height);

    return ValueListenableBuilder<bool>(
      valueListenable: hidable.stickinessNotifier,
      builder: (_, isStickinessEnabled, __) {
        if (isStickinessEnabled) return hidableCard(1.0, hidable);

        return ValueListenableBuilder<double>(
          valueListenable: hidable.sizeNotifier,
          builder: (_, height, __) => hidableCard(height, hidable),
        );
      },
    );
  }

  Widget hidableCard(double factor, hidable) {
    return Align(
      heightFactor: factor,
      alignment: const Alignment(0, -1),
      child: SizedBox(
        key: ObjectKey(factor),
        height: hidable.size,
        child: wOpacity ? Opacity(opacity: factor, child: child) : child,
      ),
    );
  }
}
